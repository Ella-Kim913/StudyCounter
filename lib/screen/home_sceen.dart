import 'dart:async';

import 'package:flutter/material.dart';
import 'package:promodoapp/widget/timeselect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const tweenthFiveMinutes = 1500;
  late int getTime;
  int totalSeconds = tweenthFiveMinutes;
  int totalPomod = 0;
  int totalGoal = 0;
  bool isRunning = false;
  bool isSelected = false;
  bool breakTime = false;
  late Timer timer; //Timer라는 패키지가 내장되어 있음 이미

  void putNumber(int wanttime) {
    totalSeconds = wanttime;
    isSelected = true;
    setState(() {});
  }

  void onTickBreak(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunning = false;
        breakTime = false;
        totalSeconds = 4;
      });
      timer.cancel();
    } else {
      setState(() {});
      totalSeconds = totalSeconds - 1;
    }
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomod = totalPomod + 1;
        isRunning = false;
        totalSeconds = 2;
        breakTime = false;

        if (totalPomod == 4) {
          // setState(() {
          totalGoal = totalGoal + 1;
          totalPomod = 0;
          totalSeconds = 3;
          breakTime = true;
          if (totalGoal == 12) {
            totalGoal = 0;
          }
          // });
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  // void breakTimeAction() {
  //   setState(() {
  //     totalSeconds = totalSeconds - 1;
  //     totalPomod = 0;
  //     breakTime = false;
  //   });
  // }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      breakTime ? onTickBreak : onTick,
    );

    setState(() {
      isRunning = true;
    });

    // if (breakTime = false) {
    //   timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     onTick,
    //   );
    // } else {
    //   timer = Timer.periodic(
    //     const Duration(seconds: 1),
    //     onTickBreak,
    //   );

    //   setState(() {
    //     isRunning = true;
    //   });
    // }
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    setState(() {
      totalSeconds = tweenthFiveMinutes;
      isSelected = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
        .toString()
        .split('.')
        .first //0:24:59.000000 밀리초를 없애기 위한 작업 1) 점을 기준으로 앞과 뒤를 자르고 2) 리스트에서 앞만 선택
        .substring(2, 7); //0:24:59 에서 시를 없애기 위한 작업 - 2번째부터 7번째까지만 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            //전체 화면에서 비율로 정해줄 수 있음 (박스 크기를 딱 정하는게 아니라)
            flex: 3,
            child: Column(
              children: [
                const SizedBox(height: 140),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    format(totalSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 89,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: breakTime,
                  child: const Text(
                    "BREAKTIME",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timeselect(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           selectTime(900),
                  //           selectTime(1200),
                  //           selectTime(1500),
                  //           selectTime(1800),
                  //           selectTime(2100),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      icon: isRunning
                          ? const Icon(
                              Icons.pause_circle_outline_outlined,
                            )
                          : const Icon(
                              Icons.play_circle_outline,
                            )),
                  IconButton(
                    iconSize: 45,
                    color: Theme.of(context).cardColor,
                    onPressed: reset,
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ROUND",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                ),
                                Text(
                                  '$totalPomod/4',
                                  style: TextStyle(
                                    fontSize: 58,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "GOAL",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                ),
                                Text(
                                  '$totalGoal/12',
                                  style: TextStyle(
                                    fontSize: 58,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .color,
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }

  IconButton selectTime(int time) {
    return IconButton(
      iconSize: 100,
      color: Colors.black,
      onPressed: () {
        putNumber(time);
      },
      icon: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 3,
                ),
                shape: BoxShape.rectangle,
              ),
              child: Text(
                "$time",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 3,
                ),
                color: Theme.of(context).cardColor,
                shape: BoxShape.rectangle,
              ),
              child: Text(
                "$time",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}
