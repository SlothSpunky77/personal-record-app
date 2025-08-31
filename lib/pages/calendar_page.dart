import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/models/database.dart';
import 'package:pr/pages/log_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  // Direction of animation (1 for forward, -1 for backward)
  int _animationDirection = 0;

  final db = AppDatabase();
  Set<DateTime> _workoutDates = {};
  DateTime? _earliestWorkoutDate;
  DateTime? _latestWorkoutDate;
  late DateTime _currentDate; //which year and month you're on to navigate

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });

    _loadWorkoutDates();
    _loadDateBounds();
    // in the above functions, you use allLogs in each of them, so try using it just once
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadWorkoutDates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final allLogs = await db.select(db.logs).get();

      // Filter for current month
      final currentMonthLogs = allLogs.where((log) {
        final logDate = log.dt;
        return logDate.year == _currentDate.year &&
            logDate.month == _currentDate.month;
      }).toList();

      // Extract unique dates (ignore time, only consider date)
      final uniqueDates = currentMonthLogs.map((log) {
        final date = log.dt;
        return DateTime(date.year, date.month, date.day);
      }).toSet();

      setState(() {
        _workoutDates = uniqueDates;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading workout dates: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // instead of this function
  Future<void> _loadDateBounds() async {
    try {
      final allLogs = await db.select(db.logs).get();

      if (allLogs.isNotEmpty) {
        // Sort by date
        allLogs.sort((a, b) => a.dt.compareTo(b.dt));

        setState(() {
          _earliestWorkoutDate = allLogs.first.dt;
          _latestWorkoutDate = allLogs.last.dt;
        });
      }
    } catch (e) {
      print('Error loading date bounds: $e');
    }
  }

  // Check if a date tile in the calendar has workout data
  bool _hasWorkout(DateTime date) {
    return _workoutDates.contains(DateTime(
      date.year,
      date.month,
      date.day,
    ));
  }

  // Navigate to previous month
  void _previousMonth() {
    if (_canGoToPreviousMonth()) {
      setState(() {
        _animationDirection = -1;
        _animationController.forward();
        _currentDate = DateTime(
          _currentDate.year,
          _currentDate.month - 1,
          1,
        );
      });
      // Load workout dates for the new month
      _loadWorkoutDates();
    }
  }

  // Navigate to next month
  void _nextMonth() {
    if (_canGoToNextMonth()) {
      setState(() {
        _animationDirection = 1;
        _animationController.forward();
        _currentDate = DateTime(
          _currentDate.year,
          _currentDate.month + 1,
          1,
        );
      });
    }
    // Load workout dates for the new month
    _loadWorkoutDates();
  }

  // Navigate to previous year
  void _previousYear() {
    if (_canGoToPreviousYear()) {
      setState(() {
        _animationDirection = -1;
        _animationController.forward();
        _currentDate = DateTime(
          _currentDate.year - 1,
          _currentDate.month,
          1,
        );
      });
      // Load workout dates for the new month
      _loadWorkoutDates();
    }
  }

  // Navigate to next year
  void _nextYear() {
    if (_canGoToNextYear()) {
      setState(() {
        _animationDirection = 1;
        _animationController.forward();
        _currentDate = DateTime(
          _currentDate.year + 1,
          _currentDate.month,
          1,
        );
      });
    }
    // Load workout dates for the new month
    _loadWorkoutDates();
  }

  bool _canGoToPreviousMonth() {
    if (_earliestWorkoutDate == null) return false;

    final previousMonth = DateTime(
      _currentDate.year,
      _currentDate.month - 1,
      1,
    );
    return previousMonth.isAfter(_earliestWorkoutDate!) ||
        (previousMonth.year == _earliestWorkoutDate!.year &&
            previousMonth.month == _earliestWorkoutDate!.month);
  }

  bool _canGoToNextMonth() {
    if (_latestWorkoutDate == null) return false;

    final nextMonth = DateTime(
      _currentDate.year,
      _currentDate.month + 1,
      1,
    );
    return nextMonth.isBefore(_latestWorkoutDate!) ||
        (nextMonth.year == _latestWorkoutDate!.year &&
            nextMonth.month == _latestWorkoutDate!.month);
  }

  bool _canGoToPreviousYear() {
    if (_earliestWorkoutDate == null) return false;

    final previousYear = DateTime(
      _currentDate.year - 1,
      _currentDate.month,
      1,
    );
    return previousYear.isAfter(_earliestWorkoutDate!) ||
        previousYear.year == _earliestWorkoutDate!.year;
  }

  bool _canGoToNextYear() {
    if (_latestWorkoutDate == null) return false;

    final nextYear = DateTime(
      _currentDate.year + 1,
      _currentDate.month,
      1,
    );
    return nextYear.isBefore(_latestWorkoutDate!) ||
        nextYear.year == _latestWorkoutDate!.year;
  }

  // Show workout details for a specific date
  // Show workout details for a specific date
  void _showWorkoutDetailsForDate(DateTime date) async {
    try {
      // Join Logs with Workouts to get workout names
      final query = db.select(db.logs).join([
        leftOuterJoin(
            db.workouts, db.workouts.workoutID.equalsExp(db.logs.workoutID)),
      ]);

      final results = await query.get();

      // Filter for the specific date
      final dateLogs = results.where((row) {
        final log = row.readTable(db.logs);
        final logDate = log.dt;
        return logDate.year == date.year &&
            logDate.month == date.month &&
            logDate.day == date.day;
      }).toList();

      if (dateLogs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No workouts found for this date'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: darkMode.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: darkMode.colorScheme.primary,
              width: 2,
            ),
          ),
          title: Text(
            'Workouts on ${DateFormat('MMM dd, yyyy').format(date)}',
            style: TextStyle(
              color: darkMode.colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dateLogs.length,
              itemBuilder: (context, index) {
                final row = dateLogs[index];
                final log = row.readTable(db.logs);
                final workout = row.readTable(db.workouts);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pop(); // Close the current dialog first
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LogPage(
                          workoutName: workout.name,
                          workoutId: workout.workoutID,
                          highlightLogId: log.logID,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: darkMode.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: darkMode.colorScheme.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout
                              .name, // This now shows the actual workout name
                          style: TextStyle(
                            color: Colors.green.shade300,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Time: ${DateFormat('HH:mm').format(log.dt)}',
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(
                  color: darkMode.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error loading workout details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error loading workout details'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Workout Calendar',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: darkMode.colorScheme.primary,
        foregroundColor: darkMode.colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildYearNavigation(),
          _buildMonthNavigation(),
          _buildWeekdayHeaders(),

          // Calendar grid
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: darkMode.colorScheme.primary,
                    ),
                  )
                : AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          _animationDirection *
                              _animation.value *
                              MediaQuery.of(context).size.width *
                              0.3 *
                              (1 - _animation.value),
                          0,
                        ),
                        child: Opacity(
                          opacity: 1 - (_animation.value * 0.6),
                          child: _buildCalendarGrid(),
                        ),
                      );
                    },
                  ),
          ),

          // Legend
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildYearNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: darkMode.colorScheme.primary.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: darkMode.colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _canGoToPreviousYear() ? _previousYear : null,
            icon: Icon(
              Icons.chevron_left,
              color: _canGoToPreviousYear()
                  ? darkMode.colorScheme.inversePrimary
                  : darkMode.colorScheme.inversePrimary.withOpacity(0.3),
              size: 28,
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 85,
            child: Center(
              child: Text(
                _currentDate.year.toString(),
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: _canGoToNextYear() ? _nextYear : null,
            icon: Icon(
              Icons.chevron_right,
              color: _canGoToNextYear()
                  ? darkMode.colorScheme.inversePrimary
                  : darkMode.colorScheme.inversePrimary.withOpacity(0.3),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: darkMode.colorScheme.primary.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: darkMode.colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _canGoToPreviousMonth() ? _previousMonth : null,
            icon: Icon(
              Icons.chevron_left,
              color: _canGoToPreviousMonth()
                  ? darkMode.colorScheme.inversePrimary
                  : darkMode.colorScheme.inversePrimary.withOpacity(0.3),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 110,
            child: Center(
              child: Text(
                DateFormat('MMMM').format(_currentDate),
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: _canGoToNextMonth() ? _nextMonth : null,
            icon: Icon(
              Icons.chevron_right,
              color: _canGoToNextMonth()
                  ? darkMode.colorScheme.inversePrimary
                  : darkMode.colorScheme.inversePrimary.withOpacity(0.3),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: darkMode.colorScheme.primary.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays.map((day) {
          return Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // First day of the current month
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);

    // Day of the week for the first day (0 is Monday in our layout)
    int firstWeekday = firstDay.weekday - 1;

    // Number of days in the current month
    final daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    // Calculate days from previous month to show
    final daysFromPreviousMonth = firstWeekday;

    // Previous month's days to display
    final previousMonth =
        DateTime(_currentDate.year, _currentDate.month - 1, 1);
    final daysInPreviousMonth =
        DateTime(_currentDate.year, _currentDate.month, 0).day;

    final List<Widget> dayWidgets = [];

    // Add days from previous month
    for (int i = 0; i < daysFromPreviousMonth; i++) {
      final day = daysInPreviousMonth - daysFromPreviousMonth + i + 1;
      final date = DateTime(previousMonth.year, previousMonth.month, day);

      dayWidgets.add(
        _buildDateCell(day, date, isCurrentMonth: false),
      );
    }

    // Add days from current month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentDate.year, _currentDate.month, day);

      dayWidgets.add(
        _buildDateCell(day, date, isCurrentMonth: true),
      );
    }

    // Add days from next month to fill the grid (6 rows x 7 days = 42 cells total)
    final nextMonth = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    final remainingCells = 42 - dayWidgets.length;

    for (int day = 1; day <= remainingCells; day++) {
      final date = DateTime(nextMonth.year, nextMonth.month, day);

      dayWidgets.add(
        _buildDateCell(day, date, isCurrentMonth: false),
      );
    }

    // Create the grid with 6 rows and 7 columns
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      children: dayWidgets,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
    );
  }

  Widget _buildDateCell(int day, DateTime date,
      {required bool isCurrentMonth}) {
    final isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    final hasWorkout = _hasWorkout(date);

    // Determine cell background color
    Color backgroundColor;
    if (isToday) {
      backgroundColor = darkMode.colorScheme.primary;
    } else if (isCurrentMonth) {
      backgroundColor = darkMode.colorScheme.primary.withOpacity(0.1);
    } else {
      backgroundColor = darkMode.colorScheme.surface;
    }

    // Determine text style
    final textStyle = TextStyle(
      color: !isCurrentMonth
          ? darkMode.colorScheme.inversePrimary.withOpacity(0.3)
          : hasWorkout
              ? Colors.green.shade300
              : darkMode.colorScheme.inversePrimary.withOpacity(0.7),
      fontWeight: isToday || hasWorkout ? FontWeight.bold : FontWeight.normal,
      fontSize: 16,
    );

    return InkWell(
      onTap: hasWorkout
          ? () {
              // Navigate to workout details for this date
              _showWorkoutDetailsForDate(date);
            }
          : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(color: Colors.green.shade300, width: 2)
              : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.toString(),
                style: textStyle,
              ),
              if (hasWorkout)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: darkMode.colorScheme.primary.withOpacity(0.2),
        border: Border(
          top: BorderSide(
            color: darkMode.colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem('Workout', Colors.green.shade400),
          const SizedBox(width: 40),
          _buildLegendItem('No Workout',
              darkMode.colorScheme.inversePrimary.withOpacity(0.7)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: SizedBox(),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: darkMode.colorScheme.inversePrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
