import 'package:flutter/material.dart';

class timeselect extends StatelessWidget {
  timeselect({super.key});

  double selectTime = 1500;

  List selectableTimes = [
    "900",
    "1200",
    "1500",
    "1800",
    "2100",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 60),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectableTimes.map((time) {
          return InkWell(
            onTap: () => selectTime,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              height: 70,
              width: 100,
              decoration: int.parse(time) == selectTime
                  ? BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                        width: 3,
                      ),
                    )
                  : BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                        width: 3,
                      ),
                    ),
              child: Center(
                child: Text((int.parse(time) ~/ 60).toString(),
                    style: int.parse(time) == selectTime
                        ? TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 50,
                          )
                        : TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 50,
                          )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
