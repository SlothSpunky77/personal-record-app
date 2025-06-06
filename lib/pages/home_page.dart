import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pr/models/database.dart';
import 'package:pr/pages/exercise_page.dart';
import 'package:pr/theme/theme.dart';

//TODO: add an info section wwith the floatingactionbutton

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
  bool showInfoOverlay = false;

  @override
  void initState() {
    super.initState();
    groupFetch();
  }

  Future<void> groupFetch() async {
    List<MuscleGroup> groups = await db.fetchGroups();
    setState(() {
      groupsList = groups;
    });
  }

  Color pickedColor = Colors.white;
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
            Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: darkMode.colorScheme.inversePrimary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "This is where you can add a muscle group within which you can add workouts for that muscle group.\nThe color can also be changed. Tap on the white box to change the default color.",
                    style: TextStyle(
                      color: darkMode.colorScheme.inversePrimary,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Group color: ",
                  style: TextStyle(color: Colors.white),
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextButton(
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
                                //have a Column with 'OK' button in the bottom
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
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(pickedColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(""),
                    );
                  },
                ),
              ],
            ),
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
        title: Text(
          'Edit Group',
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
        ),
        content: TextField(
          style: TextStyle(
            color: darkMode.colorScheme.inversePrimary,
          ),
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
            child: Text(
              'UPDATE',
              style: TextStyle(color: darkMode.colorScheme.inversePrimary),
            ),
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
        title: Text(
          'Delete group \'$name\'?',
          style: TextStyle(color: darkMode.colorScheme.inversePrimary),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              await db.deleteGroup(id);
              await groupFetch();
              selectedTileIndex = null;
            },
            child: Text(
              'DELETE',
              style: TextStyle(color: darkMode.colorScheme.inversePrimary),
            ),
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
                  onPressed: () {
                    editGroup(
                      groupsList[selectedTileIndex!],
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteGroup(groupsList[selectedTileIndex!].groupID,
                        groupsList[selectedTileIndex!].groupName);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
              IconButton(
                icon: const Icon(Icons.info_outline),
                tooltip: 'Info',
                onPressed: () {
                  setState(() {
                    showInfoOverlay = true;
                  });
                },
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
              if (showInfoOverlay) {
                setState(() {
                  showInfoOverlay = false;
                });
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/personal_record.png"),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: List.generate(
                          groupsList.length,
                          (index) {
                            final group = groupsList[index];
                            final bool isSelected = selectedTileIndex == index;
                            final Color baseColor = Color(group.color);
                            final Color tileColor = isSelected
                                ? Color.lerp(
                                        baseColor,
                                        const Color.fromARGB(255, 44, 44, 44),
                                        0.9) ??
                                    baseColor
                                : darkMode.colorScheme.primary;
                            final Color gradientColor = isSelected
                                ? Color.lerp(baseColor, Colors.white, 0.2) ??
                                    baseColor
                                : Color.lerp(darkMode.colorScheme.primary,
                                        baseColor, 0.3) ??
                                    darkMode.colorScheme.primary;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  colors: [
                                    tileColor,
                                    gradientColor,
                                  ],
                                  stops: const [0.4, 1],
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              child: ListTile(
                                onTap: () {
                                  if (selectedTileIndex != null) {
                                    setState(() {
                                      selectedTileIndex = null;
                                    });
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
                                onLongPress: () {
                                  setState(() {
                                    selectedTileIndex = index;
                                  });
                                },
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
                          },
                        ),
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
                      backgroundColor: darkMode.colorScheme.primary,
                      onPressed: createGroup,
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
        if (showInfoOverlay)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showInfoOverlay = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: darkMode.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: darkMode.colorScheme.primary,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline,
                            size: 40,
                            color: darkMode.colorScheme.inversePrimary),
                        const SizedBox(height: 16),
                        Text(
                          "Long press an item to select it.\n\nWhen selected, you can edit or delete the item using the icons in the top right.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkMode.colorScheme.inversePrimary,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tap anywhere to dismiss.",
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
            ),
          ),
      ],
    );
  }
}

//add color selsction during the creation of the group. Give the group tile the tint. Clicking on the group gives its exercise_page's background image the same tint.
