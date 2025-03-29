import 'package:flutter/material.dart';
import 'package:flutter_state_controll/page/BLocPatternPage.dart';
import 'package:flutter_state_controll/page/InheritedWidgetPage.dart';
import 'package:flutter_state_controll/page/ProviderAndNotifierPage.dart';
import 'package:flutter_state_controll/page/ProviderPage.dart';
import 'package:flutter_state_controll/page/RiverpodPage.dart';

void main() {
  runApp(const MyApp());
}

/*
  StatefulWidgetによるStage管理
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'StateFullWidget'),
      //ページ遷移の設定を追加
      initialRoute: '/',
      routes: {
        '/inherite': (context) => const InheritedWidgetMainPage(),
        '/bloc': (context) => const BLocPatternPage(),
        '/provider': (context) => const ProviderPage(),
        '/notifier': (context) => const ProviderAndNotifierPage(),
        '/riverpod': (context) => const RiverpodPage(),
      },
      onGenerateRoute: (settings) {
        // if (settings.name == '/detail') {
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return MemoDetailPage(settings.arguments as Memo);
        //     },
        //   );
        // }
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const WidgetA(),
              WidgetB(_counter),
              WidgetC(_incrementCounter)
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 234, 208, 238),
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  title: Text("InheritedWidgetPage"),
                  leading: const Icon(Icons.add_card_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/inherite');
                  },
                ),
                CustomeDiveider(),
                ListTile(
                  title: const Text("BLocPatternPage"),
                  leading: const Icon(Icons.add_card_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/bloc');
                  },
                ),
                CustomeDiveider(),
                ListTile(
                  title: Text("ProviderPage"),
                  leading: Icon(Icons.add_card_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/provider');
                  },
                ),
                CustomeDiveider(),
                ListTile(
                  title: Text("Provider+StateNotifierPage"),
                  leading: Icon(Icons.add_card_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/notifier');
                  },
                ),
                CustomeDiveider(),
                ListTile(
                  title: Text("RiverpodPage"),
                  leading: Icon(Icons.add_card_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/riverpod');
                  },
                ),
              ],
            ),
          )
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
  final int _counter;
  const WidgetB(counter,{super.key}) : _counter = counter;

  @override
  Widget build(BuildContext context) {
    print("WidgetB");
    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class WidgetC extends StatelessWidget {
  final Function _fn;
  const WidgetC(fn,{super.key}) : _fn = fn;

  @override
  Widget build(BuildContext context) {
    print("WidgetC");
    return ElevatedButton(
      onPressed: () {
        _fn();
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

class CustomeDiveider extends StatelessWidget {
  const CustomeDiveider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      height: 10,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
