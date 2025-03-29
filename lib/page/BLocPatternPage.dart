import 'dart:async';

import 'package:flutter/material.dart';

/*
  BLocパターンによるStage管理
*/
class BLocPatternPage extends StatefulWidget {
  const BLocPatternPage({super.key});

  @override
  State<BLocPatternPage> createState() => BLocPatternPageState();
}

class BLocPatternPageState extends State<BLocPatternPage> {
  late BLocPatternPageLogic logic;

  @override
  void initState() {
    super.initState();
    logic = BLocPatternPageLogic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('BLocパターン'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const WidgetA(),
              WidgetB(logic),
              WidgetC(logic),
            ],
          ),
        ));
  }
}

/* BLocパターンのロジック実装 */
class BLocPatternPageLogic {
  BLocPatternPageLogic() {
    _counterController.sink.add(counter);
  }
  final StreamController<int> _counterController = StreamController();

  int counter = 0;

  Stream<int> get count => _counterController.stream;

  void increment() {
    counter++;
    _counterController.sink.add(counter);
  }

  /*
  StreamControllerを閉じてリソースを解放するために使用されます。
  StreamControllerを使用している場合、使用が終わったら必ず閉じる必要があります。
  これにより、メモリリークを防ぎ、アプリケーションのパフォーマンスを維持することができます。
  */
  void dispose() {
    _counterController.close();
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({super.key});

  @override
  Widget build(BuildContext context) {
    print("WidgetA");
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB(this.logic, {super.key});
  final BLocPatternPageLogic logic;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: logic.count,
        builder: (context, snapshot) {
          print("WidgetB");
          return Text(
            '${snapshot.data}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        });
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC(this.logic, {super.key});
  final BLocPatternPageLogic logic;

  @override
  Widget build(BuildContext context) {
    print("WidgetC");
    return ElevatedButton(
      onPressed: () {
        logic.increment();
      },
      child: Icon(Icons.account_circle_outlined),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.limeAccent),
        shape: WidgetStateProperty.all<CircleBorder>(CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
        )),
      ),
    );
  }
}
