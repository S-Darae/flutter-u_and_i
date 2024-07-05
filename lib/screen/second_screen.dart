// 디데이를 활용한 실습
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  DateTime lastDay = DateTime.now();
  DateTime now = DateTime.now();
  bool isMinusBtnEnabled = true;

  // 날짜 재설정 버튼
  void newDatePressed() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      //  다이얼로그가 처음 열릴 때 표시할 초기 날짜
      initialDate: lastDay,
      // 선택할 수 있는 가장 이른 날짜
      firstDate: DateTime.now(),
      // 선택할 수 있는 가장 늦은 날짜
      lastDate: DateTime(2200),
      locale: const Locale('ko', 'KR'),
    );

    // 선택한 날짜가 변경되었다면 업데이트
    if (pickedDate != null && pickedDate != lastDay) {
      setState(
        () {
          lastDay = pickedDate;
          isMinusBtnEnabled = lastDay.isAfter(now);
        },
      );
    }
  }

  // 마이너스 버튼
  void minusPressed() {
    setState(() {
      lastDay = lastDay.subtract(
        const Duration(days: 1),
      );
      isMinusBtnEnabled = lastDay.isAfter(now);
    });
  }

  // 플러스 버튼
  void plusPressed() {
    setState(() {
      lastDay = lastDay.add(
        const Duration(days: 1),
      );
      isMinusBtnEnabled = lastDay.isAfter(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Text(
              "회원권 기간 조회 🎟",
              // copyWith로 textTheme 부분 수정
              style: textTheme.headlineMedium?.copyWith(
                color: const Color.fromARGB(255, 78, 78, 78),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "회원권 만료까지",
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    "D${DateTime(now.year, now.month, now.day).difference(lastDay).inDays}",
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            GymCard(
              textTheme: textTheme,
              lastDay: lastDay,
              newDatePressed: newDatePressed,
              minusPressed: minusPressed,
              plusPressed: plusPressed,
              isMinusBtnEnabled: isMinusBtnEnabled,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class GymCard extends StatelessWidget {
  const GymCard({
    super.key,
    required this.textTheme,
    required this.lastDay,
    required this.newDatePressed,
    required this.minusPressed,
    required this.plusPressed,
    required this.isMinusBtnEnabled,
  });

  final TextTheme textTheme;
  final DateTime lastDay;
  final VoidCallback newDatePressed;
  final VoidCallback minusPressed;
  final VoidCallback plusPressed;
  final bool isMinusBtnEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 223, 233),
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 6),
              blurRadius: 15,
              color: Color.fromARGB(20, 75, 53, 68),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25,
        ),
        child: Column(
          children: [
            Text(
              "[레드웨일짐 이용권]",
              style: textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "${lastDay.year}년 ${lastDay.month}월 ${lastDay.day}일까지 사용 가능",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBtn(
                    onPressed: () {
                      isMinusBtnEnabled ? minusPressed() : null;
                    },
                    buttonName: "-1일",
                  ),
                  CustomBtn(
                    onPressed: () {
                      plusPressed();
                    },
                    buttonName: "+1일",
                  ),
                  CustomBtn(
                    onPressed: () {
                      newDatePressed();
                    },
                    buttonName: "날짜 재입력",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBtn extends StatelessWidget {
  // VoidCallback는 콜백 함수를 정의할 떄 사용하는 타입 중 하나로, 매개변수를 받지않고 반환 값이 없는 함수 타입
  final VoidCallback onPressed;
  final String buttonName;

  const CustomBtn({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 9,
          ),
          backgroundColor: const Color.fromARGB(178, 255, 255, 255)),
      child: Text(
        buttonName,
        style: const TextStyle(
          fontSize: 19,
          color: Color.fromARGB(250, 75, 53, 68),
        ),
      ),
    );
  }
}
