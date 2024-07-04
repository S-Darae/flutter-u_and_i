# [디데이] u_and_i

Cupertino Widget, CupertinoDatePicker, Font Component, Dialog, StatefulWidget 상태 관리

<br>

## 1️⃣ setState() 함수

```
setState(() {
  number ++;
})
```

- setState() 함수는 **매개변수** 하나를 입력 받음
- 이 매개변수는 **콜백 함수**이고, 이 콜백 함수에 변경하고 싶은 속성들을 입력해주면 <br> 해당 코드가 반영된 뒤 build()함수가 실행됨 (단, 콜백 함수가 비동기로 작성되면 안 됨)

<br>

## 2️⃣ Font Component

▫ pubspec.yaml

```
flutter:
  uses-material-design: true

  assets:
    - asset/img/

  fonts:
    - family: Pretendard
      fonts:
        - asset: asset/font/Pretendard-Bold.otf
          weight: 700
        - asset: asset/font/Pretendard-Medium.otf
          weight: 600
        - asset: asset/font/Pretendard-Regular.otf
          weight: 500
```

▫ main.dart

```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 252, 183, 206),
        ),
        fontFamily: 'Pretendard',
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Color.fromARGB(255, 75, 53, 68),
              fontSize: 57,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: Color.fromARGB(230, 75, 53, 68),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
```

- ThemeData 매개변수로는, fontFamily, textTheme, tabBarTheme, cardTheme, appBarTheme, <br> floatingActionButtonTheme, elevatedButtonTheme, checkboxTheme 등이 있음 (위젯이름Theme 형식)

<br>

## 3️⃣ 레이아웃 - class 쪼개기

```
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _DDay(),
            const Spacer(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}
```

- \_DDay 위젯처럼 이름 첫 글자가 언더스코어면 다른 파일에서 접근할 수 없음 <br> 파일 불러오기 했을 때 불필요한 값들이 불러와지는 것을 방지하기 위해 언더스코어 활용
- 코드가 길어질 것을 대비해 class를 쪼개어 적어주고, 메인 클래스 바디에 **\_DDay()** 형식으로 입력

<br>

## 4️⃣ StatefulWidget 상태 관리

```
class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();
  ... 생략 ...
}
```

```
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0️⃣. 처음 만난 날을 변숫값으로 저장 (추후 변경하면서 사용)
  DateTime firstDay = DateTime.now();

  // 1️⃣-4. 플러스 버튼을 눌렀을 때 실행할 함수
  void onPlusPressed() {
    setState(() {
      firstDay = firstDay.subtract(
        const Duration(days: 1),
      );
    });
  }

  // 2️⃣-4. 하트 버튼을 눌렀을 때 실행할 함수
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

  // 3️⃣-4. 마이너스 버튼을 눌렀을 때 실행할 함수
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
      body: SafeArea(
        // 상단 아이폰 노치 잘림 방지
        top: true,
        bottom: false,
        child: Column(
          children: [
            _DDay(
              // 1️⃣-5, 2️⃣-5, 3️⃣-5. 버튼 눌렀을 때 실행할 함수 전달
              // 4️⃣-6. 변숫값을 매개변수로 입력
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
  // 1️⃣-1, 2️⃣-1, 3️⃣-1. 각 버튼을 눌렀을 때 실행할 변수 선언 (함수 타입의 변수)
  final GestureTapCallback onHeartPressed;
  final GestureTapCallback onPlusPressed;
  final GestureTapCallback onMinusPressed;

  // 4️⃣-1. 사귀기 시작한 날 변수 선언
  final DateTime firstDay;

  // 1️⃣-2, 2️⃣-2, 3️⃣-2, 4️⃣-2. 위에서 입력한 변숫값을 생성자에 매개변수로 외부에서 입력받도록 정의
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

    // 4️⃣-3. 현재 날짜 시간 값을 now 변수에 저장
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "우리 처음 만난 날",
        ),
        const SizedBox(
          height: 2,
        ),
        // 4️⃣-4. DateTime을 년월일 형식으로 입력
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
                // 1️⃣-3. 버튼 눌렀을 때 실행할 함수 입력
                onMinusPressed();
              },
              icon: const Icon(
                Icons.exposure_minus_1_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                // 2️⃣-3. 버튼 눌렀을 때 실행할 함수 입력
                onHeartPressed();
              },
              icon: const Icon(
                Icons.favorite,
              ),
            ),
            IconButton(
              onPressed: () {
                // 3️⃣-3. 버튼 눌렀을 때 실행할 함수 입력
                onPlusPressed();
              },
              icon: const Icon(
                Icons.plus_one_rounded,
              ),
            ),
          ],
        ),
        // 4️⃣-5. DDay 계산
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
```

#### 💡 코드 자세히 보기 - 1. 플러스, 2. 하트, 3. 마이너스 버튼 구현

1. **함수 타입의 변수 선언**

- 이 변수에는 특정 함수가 할당될 수 있고, 추후 해당 변수를 통해 함수를 호출할 수 있음
- 사용자가 버튼을 클릭했을 때 어떤 동작을 수행할지 정의하려면, 클릭 이벤트를 처리할 함수를 콜백으로 전달해야 함

```
class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final GestureTapCallback onPlusPressed;
  final GestureTapCallback onMinusPressed;
```

2. **변숫값을 생성자에 매개변수로 외부에서 입력받도록 정의**

```
  const _DDay({
    required this.onHeartPressed,
    required this.firstDay,
    required this.onPlusPressed,
    required this.onMinusPressed,
  });
```

3. **IconButton > onPressed에 버튼을 눌렀을 때 실행할 함수 입력**

```
            IconButton(
              onPressed: () {
                onMinusPressed();
              }
```

4. **메인 클래스(HomeScreen)에 버튼을 눌렀을 때 실행할 함수의 내용 입력**

- DateTime : 날짜와 시간을 저장할 수 있는 변수 타입
- subtract : 원하는만큼 기간을 뺼 수 있는 함수 (반대는 add)
- Duration : 기간을 정할 수 있는 변수 타입
- barrier : 다이얼로그 위젯 외에 흐림 처리가 된 부분

```
  void onPlusPressed() {
    setState(() {
      firstDay = firstDay.subtract(
        const Duration(days: 1),
      );
    });
  }
```

```
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
```

```
  void onMinusPressed() {
    setState(() {
      firstDay = firstDay.add(
        const Duration(days: 1),
      );
    });
  }
```

<br>

#### 💡 코드 자세히 보기 - 4. D-Day 계산

1.  **기간을 세기 시작할 첫 날짜 변수 선언**

```
  final DateTime firstDay;
```

2. **변숫값을 생성자에 매개변수로 외부에서 입력받도록 정의**

```
  const _DDay({
    required this.firstDay,
  });
```

3. **현재 날짜 시간 값을 now 변수에 저장**

```
  final now = DateTime.now();
```

4. **DateTime을 년, 월, 일 형식으로 입력**

```Text(
          "${firstDay.year}.${firstDay.month}.${firstDay.day}"
        ),
```

5.  **DDay 계산**

```
    Text(
           "D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}"
    ),
```

6.  **변숫값을 매개변수로 입력**

```
    _DDay(
          onMinusPressed: onMinusPressed,
          onHeartPressed: onHeartPressed,
          onPlusPressed: onPlusPressed,
          firstDay: firstDay,
         ),
```
