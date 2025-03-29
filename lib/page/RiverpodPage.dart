import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_controll/model/RiverPodModel.dart';
import 'package:flutter_state_controll/state/RiverPodState.dart';

class RiverpodPage extends StatelessWidget {
  const RiverpodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Riverpod'),
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

// StateNotifier クラスを使用して状態管理を行うためのプロバイダー
final riverPodProvider =
    StateNotifierProvider<RiverpodModel, RiverpodState>(
        (ref) => RiverpodModel());

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

class WidgetB extends ConsumerWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("WidgetB");
    final int counter = ref.watch(riverPodProvider).counter;
    final int cnt = ref.watch(riverPodProvider).cnt;
    return Column(
      children: [
        Text(
          '$counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          '$cnt',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class WidgetC extends ConsumerWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("WidgetC");
    final Function increment = ref.read(riverPodProvider.notifier).increment;
    final Function decrement = ref.read(riverPodProvider.notifier).decrement;
    return ElevatedButton(
      onPressed: () {
        increment();
        decrement();
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
