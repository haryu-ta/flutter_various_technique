import 'package:flutter/material.dart';

/*
  InheritedWidgeによるStage管理
*/
class InheritedWidgetMainPage extends StatefulWidget {
  const InheritedWidgetMainPage({super.key});

  @override
  State<InheritedWidgetMainPage> createState() => InheritedwidgetPageState();
}

class InheritedwidgetPageState extends State<InheritedWidgetMainPage> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedWidgetMainPageWidget(
      state: this,
      counter: counter,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('InheritedWidgetPage'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                WidgetA(),
                WidgetB(),
                WidgetC(),
              ],
            ),
          )),
    );
  }
}

class InheritedWidgetMainPageWidget extends InheritedWidget {
  const InheritedWidgetMainPageWidget(
      {super.key,
      required super.child,
      required this.state,
      required this.counter});

  final int counter;
  final InheritedwidgetPageState state;

  /*
    of メソッドは、InheritedWidgetPage クラスの静的メソッドであり、
    BuildContext を使用してウィジェットツリー内の InheritedWidgetPage インスタンスにアクセスするために使用されます。
    このメソッドは、InheritedWidgetPage の状態である InheritedwidgetPageState を取得するための便利な方法を提供します。
  */
  static InheritedwidgetPageState of(BuildContext context,
      {bool listen = true}) {
    if (listen) {
      /*
      context.dependOnInheritedWidgetOfExactType<InheritedWidgetMainPageWidget>() を使用して 
      InheritedWidgetPage に依存するようにします。
      これにより、InheritedWidgetPage の状態が変更されたときに、依存しているウィジェットが再構築されます。
      */
      return context
          .dependOnInheritedWidgetOfExactType<InheritedWidgetMainPageWidget>()!
          .state;
    } else {
      /*
      ウィジェット要素を直接取得します。この方法では、依存関係が設定されないため、
      InheritedWidgetPage の状態が変更されても、依存しているウィジェットは再構築されません
      */ 
      return (context
              .getElementForInheritedWidgetOfExactType<InheritedWidgetMainPageWidget>()!
              .widget as InheritedWidgetMainPageWidget)
          .state;
    }
  }

  /*
  InheritedWidget の新しいインスタンスと古いインスタンスを比較し、状態が変更されたかどうかを判断します。
  このメソッドが true を返すと、依存しているウィジェットは再構築され、最新の状態を反映します。
  逆に false を返すと、再構築は行われません。
  */
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // 常に再構築
    return true;

    // counterの値が変わったときだけ再構築
    //return counter != oldWidget.counter;
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
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    print("WidgetB");
    // バケツ渡ししなくてもstateを取得できる
    final InheritedwidgetPageState state = InheritedWidgetMainPageWidget.of(context);
    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    print("WidgetC");
    // listen = falseを設定することで再構築対象から除外する
    final InheritedwidgetPageState state = InheritedWidgetMainPageWidget.of(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        state.incrementCounter();
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
