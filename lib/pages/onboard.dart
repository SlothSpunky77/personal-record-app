import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Page1(),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});
  void setCompleted(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("completed", value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 3) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: const Color.fromARGB(255, 26, 0, 46),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2,
                    child: Icon(
                      Icons.bolt_rounded,
                      size: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Simple.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      const Text(
                        'Straightforward.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text(
                        'Maintains your records',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'flawlessly.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Text(
                            'And ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'so much more.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              backgroundColor: Color.fromARGB(255, 83, 83, 83),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(50),
                        child: MaterialButton(
                          onPressed: () => {
                            setCompleted(true),
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/main', (route) => false),
                          },
                          height: 70,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          color: const Color.fromARGB(255, 214, 197, 224),
                          child: const Text(
                            " Let's go! ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < -3) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Page3()));
          }
          if (details.delta.dx > 3) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: const Color.fromARGB(255, 14, 0, 34),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2,
                    child: Icon(
                      Icons.track_changes,
                      size: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Track ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'PRs.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Color.fromARGB(255, 92, 92, 92),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Maintain ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'logs.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              backgroundColor:
                                  Color.fromARGB(255, 129, 129, 129),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < -3) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Page2()));
          }
        },
        child: Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Column(
            children: [
              //top half
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2,
                    child: Icon(Icons.rocket_launch_outlined,
                        size: MediaQuery.of(context).size.width / 2),
                  ),
                ),
              ),
              //bottom half
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 70,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'to ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Personal Record.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                    Color.fromARGB(255, 79, 79, 79)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
