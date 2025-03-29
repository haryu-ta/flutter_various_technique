import 'package:flutter/material.dart';
import 'package:flutter_state_controll/model/ProviderAndNotifierModel.dart';
import 'package:flutter_state_controll/state/ProviderAndNotifierState.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class ProviderAndNotifierPage extends StatelessWidget {
  const ProviderAndNotifierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<ProviderAndNotifierModel,ProviderAndNotifierState>(
      create: (BuildContext context) { 
        return ProviderAndNotifierModel();
      },
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Provider + StateNotifier'),
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
        ),
      ),
    );
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
    // この方法の場合はwatchでもselectでも値が変化した場合のみ再ビルドされる
    final int counter = context.watch<ProviderAndNotifierState>().counter;
    //final int counter  = context.select<ProviderAndNotifierState,int>((state) => state.counter);
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
    final Function fn = context.read<ProviderAndNotifierModel>().increment;
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
