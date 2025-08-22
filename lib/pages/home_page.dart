import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pr/models/database.dart';
import 'package:pr/pages/exercise_page.dart';
import 'package:pr/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  int? selectedTileIndex;
  int currentPageIndex = 0;
  List<MuscleGroup> groupsList = [];
  final db = AppDatabase();

  final GlobalKey infoIconKey = GlobalKey();
  OverlayEntry? infoOverlayEntry;
  final GlobalKey onboardKey = GlobalKey();
  OverlayEntry? onboardOverlayEntry;
  final GlobalKey colorInfoKey = GlobalKey();
  OverlayEntry? colorHelpEntry;

  Color pickedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    groupFetch().then((_) {
      if (groupsList.isEmpty) {
        Future.delayed(const Duration(milliseconds: 500), showOnboardOverlay);
      }
    });
  }

  @override
  void dispose() {
    hideInfoOverlay();
    hideOnboardOverlay();
    hideColorHelpOverlay();
    textController.dispose();
    super.dispose();
  }

  Future<void> groupFetch() async {
    List<MuscleGroup> groups = await db.fetchGroups();
    setState(() {
      groupsList = groups;
    });
  }

  void createGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          side: BorderSide(
            color: darkMode.colorScheme.primary,
            width: 5,
          ),
        ),
        title: Text(
          'New Group',
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: darkMode.colorScheme.inversePrimary,
              ),
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter new group name...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127)),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Group color: ",
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  key: colorInfoKey,
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showColorHelpOverlay();
                    });
                  },
                  icon: Icon(Icons.info_outline_rounded,
                      color: darkMode.colorScheme.inversePrimary),
                ),
                Spacer(),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(pickedColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: darkMode.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              side: BorderSide(
                                color: darkMode.colorScheme.primary,
                                width: 5,
                              ),
                            ),
                            content: IntrinsicHeight(
                              child: Padding(
                                //TODO: have a Column with 'OK' button in the bottom
                                padding: const EdgeInsets.only(top: 10),
                                child: Theme(
                                  data: ThemeData(
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    textTheme: Typography.whiteCupertino,
                                  ),
                                  child: HueRingPicker(
                                    pickerColor: pickedColor,
                                    onColorChanged: (color) {
                                      setState(() {
                                        pickedColor = color;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.newGroup(textController.text, pickedColor.value);
              pickedColor = Colors.white;
              await groupFetch();
              textController.clear();
            },
            child: Text(
              'ADD',
              style: TextStyle(color: darkMode.colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }

  void editGroup(MuscleGroup group) {
    textController.text = group.groupName;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.primary,
        title: Text('Edit Group',
            style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
        content: TextField(
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Edit group name...',
            hintStyle: TextStyle(color: Color.fromARGB(255, 127, 127, 127)),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.updateGroup(group.groupID, textController.text);
              await groupFetch();
              textController.clear();
              selectedTileIndex = null;
            },
            child: Text('UPDATE',
                style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
          ),
        ],
      ),
    );
  }

  void deleteGroup(int id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkMode.colorScheme.primary,
        title: Text("Delete group '$name'?",
            style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.deleteGroup(id);
              await groupFetch();
              selectedTileIndex = null;
            },
            child: Text('DELETE',
                style: TextStyle(color: darkMode.colorScheme.inversePrimary)),
          ),
        ],
      ),
    );
  }

  // startWorkout() {
  //   List<int> selectedIndices = [];
  //   List idList = [];
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //           color: darkMode.colorScheme.secondary,
  //           width: 7,
  //         ),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       backgroundColor: darkMode.colorScheme.surface,
  //       child: StatefulBuilder(
  //         builder: (context, setState) {
  //           return SizedBox(
  //             height: 500,
  //             width: 400,
  //             child: Container(
  //               padding: const EdgeInsets.only(
  //                   left: 20, right: 20, bottom: 10, top: 10),
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 10, top: 5),
  //                     child: Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: Text(
  //                         "Add to today's workout",
  //                         style: TextStyle(
  //                           color: darkMode.colorScheme.inversePrimary,
  //                           fontSize: 25,
  //                           fontWeight: FontWeight.w900,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: ListView.builder(
  //                       itemCount: groupsList.length,
  //                       itemBuilder: (context, index) {
  //                         final group = groupsList[index];
  //                         bool isSelected = selectedIndices.contains(index);
  //                         return Container(
  //                           decoration: BoxDecoration(
  //                             border: Border.all(
  //                               color: Color(group.color),
  //                             ),
  //                             color: isSelected
  //                                 ? darkMode.colorScheme.primary
  //                                 : darkMode.colorScheme.secondary,
  //                             borderRadius: BorderRadius.circular(20),
  //                           ),
  //                           margin: const EdgeInsets.only(top: 5, bottom: 5),
  //                           child: ListTile(
  //                             splashColor: Colors.transparent,
  //                             onTap: () {
  //                               setState(() {
  //                                 if (isSelected) {
  //                                   selectedIndices.remove(index);
  //                                   idList.remove(group.groupID);
  //                                 } else {
  //                                   selectedIndices.add(index);
  //                                   idList.add(group.groupID);
  //                                 }
  //                               });
  //                             },
  //                             contentPadding: const EdgeInsets.symmetric(
  //                               horizontal: 15,
  //                             ),
  //                             title: Text(
  //                               group.groupName,
  //                               style: TextStyle(
  //                                 color: darkMode.colorScheme.inversePrimary,
  //                                 fontSize: 23,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             trailing: isSelected
  //                                 ? const Icon(Icons.check, color: Colors.white)
  //                                 : null,
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(
  //                         top: 10, bottom: 5, right: 10, left: 10),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         TextButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text(
  //                             "CANCEL",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 16),
  //                           ),
  //                         ),
  //                         TextButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                             // Navigator.push(
  //                             //   context,
  //                             //   MaterialPageRoute(
  //                             //     builder: (context) =>
  //                             //         WorkoutSession(list: idList),
  //                             //   ),
  //                             // );
  //                           },
  //                           child: const Text(
  //                             "PROCEED",
  //                             style:
  //                                 TextStyle(color: Colors.white, fontSize: 16),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  void showInfoOverlay() {
    hideInfoOverlay();
    final RenderBox renderBox =
        infoIconKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    infoOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: hideInfoOverlay,
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Positioned(
            top: position.dy + size.height + 20,
            right: 10,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: darkMode.colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: darkMode.colorScheme.primary, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Info',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkMode.colorScheme.inversePrimary,
                            fontSize: 18)),
                    const SizedBox(height: 12),
                    Text(
                      "Add all your workout muscle groups here, within which you will have your list of exercises.\nOr not. You do you.\n\nLong press an item to select it.\nWhen selected, you can edit or delete the item using the icons that will appear in the top right.",
                      style: TextStyle(
                          color: darkMode.colorScheme.inversePrimary,
                          fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('Tap anywhere to close',
                          style: TextStyle(
                              color: darkMode.colorScheme.inversePrimary
                                  .withOpacity(0.7),
                              fontSize: 12,
                              fontStyle: FontStyle.italic)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(infoOverlayEntry!);
  }

  void hideInfoOverlay() {
    infoOverlayEntry?.remove();
    infoOverlayEntry = null;
  }

  void showOnboardOverlay() {
    hideOnboardOverlay();
    final RenderBox renderBox =
        onboardKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Offset fabCenter =
        Offset(position.dx + (size.width / 2), position.dy + (size.height / 2));
    onboardOverlayEntry = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: HolePainter(
                  holeOffset: fabCenter,
                  holeSize: Size(size.width + 20, size.height + 20),
                  opacity: 0.8,
                ),
              ),
            ),
            Positioned.fill(
              child: Stack(
                children: [
                  Positioned(
                    left: position.dx - 10,
                    top: position.dy - 10,
                    width: size.width + 20,
                    height: size.height + 20,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        hideOnboardOverlay();
                        createGroup();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: position.dx - 310,
              top: position.dy - 50,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: darkMode.colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: darkMode.colorScheme.primary, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: darkMode.colorScheme.inversePrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Create a new group",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkMode.colorScheme.inversePrimary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Start by creating a new muscle group by tapping on the plus button.",
                        style: TextStyle(
                          color: darkMode.colorScheme.inversePrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Overlay.of(context).insert(onboardOverlayEntry!);
  }

  void hideOnboardOverlay() {
    onboardOverlayEntry?.remove();
    onboardOverlayEntry = null;
  }

  void showColorHelpOverlay() {
    hideColorHelpOverlay();
    final ctx = colorInfoKey.currentContext;
    if (ctx == null)
      return; //TODO: This seems to be cleaner code, use it above as well
    final box = ctx.findRenderObject() as RenderBox;
    // final size = box.size;
    final pos = box.localToGlobal(Offset.zero);

    colorHelpEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: hideColorHelpOverlay,
              child: Container(color: Colors.black54),
            ),
          ),
          Positioned(
            left: pos.dx + 10,
            top: pos.dy - 60,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 220,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: darkMode.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: darkMode.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Text(
                  "Tap the white box to change the default color.",
                  style: TextStyle(
                    color: darkMode.colorScheme.inversePrimary,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(colorHelpEntry!);
  }

  void hideColorHelpOverlay() {
    colorHelpEntry?.remove();
    colorHelpEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: darkMode.colorScheme.surface,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Text(
              selectedTileIndex != null ? 'Item Selected' : 'Personal Record',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: darkMode.colorScheme.primary,
            foregroundColor: darkMode.colorScheme.inversePrimary,
            actions: [
              if (selectedTileIndex != null) ...[
                IconButton(
                  onPressed: () => editGroup(groupsList[selectedTileIndex!]),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteGroup(groupsList[selectedTileIndex!].groupID,
                        groupsList[selectedTileIndex!].groupName);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ] else
                IconButton(
                  key: infoIconKey,
                  icon: const Icon(Icons.info_outline),
                  onPressed: showInfoOverlay,
                ),
            ],
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (selectedTileIndex != null) {
                setState(() {
                  selectedTileIndex = null;
                });
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/personal_record.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 28, 28, 28).withOpacity(0.5),
                    BlendMode.srcATop,
                  ),
                ),
              ),
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(groupsList.length, (index) {
                          final group = groupsList[index];
                          final bool isSelected = selectedTileIndex == index;
                          final Color baseColor = Color(group.color);
                          final Color tileColor = isSelected
                              ? (Color.lerp(
                                      baseColor,
                                      const Color.fromARGB(255, 44, 44, 44),
                                      0.9) ??
                                  baseColor)
                              : darkMode.colorScheme.primary;
                          final Color gradientColor = isSelected
                              ? (Color.lerp(baseColor, Colors.white, 0.2) ??
                                  baseColor)
                              : (Color.lerp(darkMode.colorScheme.primary,
                                      baseColor, 0.3) ??
                                  darkMode.colorScheme.primary);
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                colors: [tileColor, gradientColor],
                                stops: const [0.4, 1],
                              ),
                            ),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: ListTile(
                              onTap: () {
                                if (selectedTileIndex != null) {
                                  setState(() => selectedTileIndex = null);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExercisePage(
                                        groupName: group.groupName,
                                        id: group.groupID,
                                        color: group.color,
                                      ),
                                    ),
                                  );
                                }
                              },
                              onLongPress: () =>
                                  setState(() => selectedTileIndex = index),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              title: Text(
                                group.groupName,
                                style: TextStyle(
                                  color: darkMode.colorScheme.inversePrimary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    FloatingActionButton(
                      key: onboardKey,
                      backgroundColor: darkMode.colorScheme.primary,
                      onPressed: () {
                        hideOnboardOverlay();
                        createGroup();
                      },
                      child: Icon(
                        Icons.add,
                        color: darkMode.colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter to create a spotlight effect with a hole for the FAB
class HolePainter extends CustomPainter {
  final Offset holeOffset;
  final Size holeSize;
  final double opacity;

  HolePainter({
    required this.holeOffset,
    required this.holeSize,
    this.opacity = 0.8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final Path holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: holeOffset,
              width: holeSize.width,
              height: holeSize.height),
          const Radius.circular(40),
        ),
      );
    final Path finalPath =
        Path.combine(PathOperation.difference, backgroundPath, holePath);
    canvas.drawPath(
        finalPath, Paint()..color = Colors.black.withOpacity(opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HolePainter &&
        (oldDelegate.holeOffset != holeOffset ||
            oldDelegate.holeSize != holeSize ||
            oldDelegate.opacity != opacity);
  }
}
