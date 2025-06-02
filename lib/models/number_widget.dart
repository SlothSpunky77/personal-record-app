import 'package:flutter/material.dart';
import 'package:pr/theme/theme.dart';

class NumberStep extends StatefulWidget {
  final int initialValue;
  final Function(int) onValueChanged; //is 'int' required here?
  const NumberStep({
    super.key,
    required this.initialValue,
    required this.onValueChanged,
  });

  @override
  State<NumberStep> createState() => _NumberStepState();
  //int get finalValue => value;
}

class _NumberStepState extends State<NumberStep> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: darkMode.colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (value != 0) {
                  value--;
                  widget.onValueChanged(value);
                }
              });
            },
            icon: Icon(
              Icons.remove,
              color: darkMode.colorScheme.inversePrimary,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              color: darkMode.colorScheme.inversePrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                value++;
                widget.onValueChanged(value);
              });
            },
            icon: Icon(
              Icons.add,
              color: darkMode.colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
    );
  }
}
