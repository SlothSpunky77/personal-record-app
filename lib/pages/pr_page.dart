import 'package:flutter/material.dart';
import 'package:pr/models/database.dart';
import 'package:pr/theme/theme.dart';

// Data classes for organizing PR data
class MuscleGroupPRs {
  final String muscleGroup;
  final Color color;
  final List<WorkoutPR> workouts;

  MuscleGroupPRs({
    required this.muscleGroup,
    required this.color,
    required this.workouts,
  });
}

class WorkoutPR {
  final String workoutName;
  final double? maxWeight;
  final int? maxWeightReps;
  final DateTime? maxWeightDate;
  final double? maxVolumeWeight;
  final int? maxVolumeReps;
  final DateTime? maxVolumeDate;

  WorkoutPR({
    required this.workoutName,
    this.maxWeight,
    this.maxWeightReps,
    this.maxWeightDate,
    this.maxVolumeWeight,
    this.maxVolumeReps,
    this.maxVolumeDate,
  });
}

class PRPage extends StatefulWidget {
  const PRPage({super.key});

  @override
  State<PRPage> createState() => _PRPageState();
}

class _PRPageState extends State<PRPage> {
  final db = AppDatabase();
  List<MuscleGroupPRs> muscleGroupPRs = [];
  bool isLoading = true;
  String sortBy = 'weight'; // 'weight' or 'volume'

  @override
  void initState() {
    super.initState();
    fetchPRRecords();
  }

  Future<void> fetchPRRecords() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch all muscle groups
      final allGroups = await db.fetchGroups();
      final allPRs = await db.fetchAllPersonalRecords();

      List<MuscleGroupPRs> groupPRs = [];

      for (final group in allGroups) {
        // Get all workouts for this muscle group
        final groupWorkouts = await db.fetchWorkouts(group.groupID);

        List<WorkoutPR> workoutPRs = [];

        for (final workout in groupWorkouts) {
          // Find PR for this workout
          final pr =
              allPRs.where((p) => p.workoutID == workout.workoutID).firstOrNull;

          if (pr != null) {
            workoutPRs.add(WorkoutPR(
              workoutName: workout.name,
              maxWeight: pr.maxWeight,
              maxWeightReps: pr.maxWeightReps,
              maxWeightDate: pr.maxWeightDate,
              maxVolumeWeight: pr.maxVolumeWeight,
              maxVolumeReps: pr.maxVolumeReps,
              maxVolumeDate: pr.maxVolumeDate,
            ));
          }
        }

        // Only add muscle group if it has workouts with PRs
        if (workoutPRs.isNotEmpty) {
          // Sort workouts within this muscle group
          if (sortBy == 'weight') {
            workoutPRs
                .sort((a, b) => (b.maxWeight ?? 0).compareTo(a.maxWeight ?? 0));
          } else {
            // Sort by volume (weight * reps)
            workoutPRs.sort((a, b) {
              final aVolume = (a.maxVolumeWeight ?? 0) * (a.maxVolumeReps ?? 0);
              final bVolume = (b.maxVolumeWeight ?? 0) * (b.maxVolumeReps ?? 0);
              return bVolume.compareTo(aVolume);
            });
          }

          groupPRs.add(MuscleGroupPRs(
            muscleGroup: group.groupName,
            color: Color(group.color),
            workouts: workoutPRs,
          ));
        }
      }

      setState(() {
        muscleGroupPRs = groupPRs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching PR records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode.colorScheme.primary,
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: const Text(
          'PRs',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: darkMode.colorScheme.primary,
        foregroundColor: darkMode.colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            color: darkMode.colorScheme.secondary,
            icon: Icon(Icons.sort, color: darkMode.colorScheme.inversePrimary),
            onSelected: (String value) {
              setState(() {
                sortBy = value;
              });
              fetchPRRecords();
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'weight',
                child: Row(
                  children: [
                    Icon(Icons.fitness_center,
                        color: sortBy == 'weight'
                            ? Colors.orange
                            : darkMode.colorScheme.inversePrimary),
                    const SizedBox(width: 8),
                    Text('Sort by Max Weight',
                        style: TextStyle(
                          color: sortBy == 'weight'
                              ? Colors.orange
                              : darkMode.colorScheme.inversePrimary,
                          fontWeight: sortBy == 'weight'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'volume',
                child: Row(
                  children: [
                    Icon(Icons.trending_up,
                        color: sortBy == 'volume'
                            ? Colors.orange
                            : darkMode.colorScheme.inversePrimary),
                    const SizedBox(width: 8),
                    Text('Sort by Max Volume',
                        style: TextStyle(
                          color: sortBy == 'volume'
                              ? Colors.orange
                              : darkMode.colorScheme.inversePrimary,
                          fontWeight: sortBy == 'volume'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: darkMode.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : muscleGroupPRs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emoji_events,
                          size: 80,
                          color: darkMode.colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Personal Records Yet',
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Complete workouts to see your PRs!',
                          style: TextStyle(
                            color: darkMode.colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: muscleGroupPRs.length,
                    itemBuilder: (context, index) {
                      final muscleGroupPR = muscleGroupPRs[index];
                      return MuscleGroupCard(
                        muscleGroupPR: muscleGroupPR,
                        sortBy: sortBy,
                      );
                    },
                  ),
      ),
    );
  }
}

class MuscleGroupCard extends StatelessWidget {
  final MuscleGroupPRs muscleGroupPR;
  final String sortBy;

  const MuscleGroupCard({
    super.key,
    required this.muscleGroupPR,
    required this.sortBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: muscleGroupPR.color,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Muscle Group Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkMode.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              muscleGroupPR.muscleGroup,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Workouts List
          Container(
            decoration: BoxDecoration(
              color: muscleGroupPR.color.withOpacity(0.17),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ...muscleGroupPR.workouts.map((workout) => WorkoutPRTile(
                      workout: workout,
                      sortBy: sortBy,
                      groupColor: muscleGroupPR.color,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutPRTile extends StatelessWidget {
  final WorkoutPR workout;
  final String sortBy;
  final Color groupColor;

  const WorkoutPRTile({
    super.key,
    required this.workout,
    required this.sortBy,
    required this.groupColor,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isWeightSort = sortBy == 'weight';
    final primaryValue =
        isWeightSort ? workout.maxWeight : workout.maxVolumeWeight;
    final primaryReps =
        isWeightSort ? workout.maxWeightReps : workout.maxVolumeReps;
    final primaryDate =
        isWeightSort ? workout.maxWeightDate : workout.maxVolumeDate;

    if (primaryValue == null || primaryDate == null || primaryReps == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: groupColor.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.workoutName,
            style: TextStyle(
              // color: darkMode.colorScheme.inversePrimary,
              color: const Color.fromARGB(255, 244, 244, 244),
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isWeightSort ? 'Max Weight' : 'Max Volume',
                    style: TextStyle(
                      color: darkMode.colorScheme.inversePrimary,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    isWeightSort
                        ? '${primaryValue.toStringAsFixed(1)} kg × $primaryReps reps'
                        : '${(primaryValue * primaryReps).toStringAsFixed(1)} kg (${primaryValue.toStringAsFixed(1)} kg × $primaryReps reps)',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 229, 229, 229),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                _formatDate(primaryDate),
                style: TextStyle(
                  color: darkMode.colorScheme.inversePrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
