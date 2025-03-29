import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  ProviderによるStage管理

  1. pubspec.ymlにproviderパッケージを追加
*/
class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 2. ChangeNotifierProviderを使用して、ProviderPageStageを作成
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderPageStage(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Provider'),
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
        )
      ),
    );
  }
}

// 3. ChangeNotifierを継承して、ProviderPageStageを作成
class ProviderPageStage extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    // setStage同等
    notifyListeners();
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
    // 値が変化しても変化しなくても再ビルドしたい場合
    //final int counter = context.watch<ProviderPageStage>().counter;
    // 値が変化した場合だけ再ビルドしたい場合
    final int counter = context.select<ProviderPageStage, int>((state) => state.counter);
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    print("WidgetC");
    // 値が変化しても変化しなくても再ビルドしない場合
    final fn = context.read<ProviderPageStage>().incrementCounter;
    return ElevatedButton(
      onPressed: () {
        fn();
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
