import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  void onPlusPressed() {
    setState(() {
      firstDay = firstDay.subtract(
        const Duration(days: 1),
      );
    });
  }

  void onHeartPressed() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 320,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void onMinusPressed() {
    setState(() {
      firstDay = firstDay.add(
        const Duration(days: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 183, 206),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            _DDay(
              onMinusPressed: onMinusPressed,
              onHeartPressed: onHeartPressed,
              onPlusPressed: onPlusPressed,
              firstDay: firstDay,
            ),
            const Spacer(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final GestureTapCallback onPlusPressed;
  final GestureTapCallback onMinusPressed;

  final DateTime firstDay;
  const _DDay({
    required this.onHeartPressed,
    required this.firstDay,
    required this.onPlusPressed,
    required this.onMinusPressed,
  });
  @override
  Widget build(BuildContext context) {
    // textTheme 코드 축약
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 35,
        ),
        Text(
          "U and I 💕",
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "우리 처음 만난 날",
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          "${firstDay.year}.${firstDay.month}.${firstDay.day}",
          style: textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                onMinusPressed();
              },
              icon: const Icon(
                Icons.exposure_minus_1_rounded,
                size: 30,
                color: Color.fromARGB(180, 75, 53, 68),
              ),
            ),
            IconButton(
              onPressed: () {
                onHeartPressed();
              },
              icon: const Icon(
                Icons.favorite,
                size: 24,
                color: Color.fromARGB(210, 225, 83, 130),
              ),
            ),
            IconButton(
              onPressed: () {
                onPlusPressed();
              },
              icon: const Icon(
                Icons.plus_one_rounded,
                size: 30,
                color: Color.fromARGB(180, 75, 53, 68),
              ),
            ),
          ],
        ),
        Text(
          "D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}",
          style: textTheme.headlineLarge,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "asset/img/middle_image.png",
        // 화면의 반만큼 높이 구현
        height: MediaQuery.of(context).size.height / 2.4,
      ),
    );
  }
}
