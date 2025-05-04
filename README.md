# flutter_state_controll

## state管理widget

### StatefulWidget

- ○：実装がたやすい
- ×：バケツリレーになる
- ×：ロジックとstate管理が一色たんでコードが読みづらい

### IngeritedWidget

- ○：バケツリレーがなくなる
- ×：実装量が増える
- ×：ロジックとstate管理が一色たんでコードが読みづらい

### BLoc

- ○：見た目と(ロジックとstate)の管理が分離されている
- ×：バケツリレーになる
- ×：理解が難しい
- ×：実装が増える

### Provider

- ○：見た目と(ロジックとstate)の管理が分離されている
- ○：バケツリレーにならない
- △：そこまで実装が増えない
- ×：ChangeNotifierProviderからしか参照できない
- 導入パッケージ
  - provider

### Provider + StateNorifier

- ○：見た目 と ロジック と state 各々の管理が分離されている
- ○：バケツリレーにならない
- △：そこまで実装が増えない
- ×：StateNotifierProviderからしか参照できない
- 導入パッケージ
  - provider
  - flutter_state_notifier
  - state_notifier

### Riverpod

- ○：見た目 と ロジック と state 各々の管理が分離されている
- ○：バケツリレーにならない
- ○：グローバルどこからでもアクセス可能
- 導入パッケージ
  - riverpod


**View定義**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        body:const widgetA()
      )
    );
  }
}
```

**state定義クラス**
```dart
class pageState {
  // コンストラクタを定義
  const pageState({this.counter = 0, this.cnt = 10});
  // state管理する変数を定義
  final int counter;
  final int cnt;


  pageState copyWith(String kbn, int count) {
    if (kbn == 'increment') {
      return pageState(
        counter: count,
        cnt: this.cnt,
      );
    } else if (kbn == 'decrement') {
      return pageState(
        counter: this.counter,
        cnt: count,
      );
    } else {
      return pageState(
        counter: this.counter,
        cnt: this.cnt,
      );
    }
  }  
}
```

**notifier定義クラス**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// グローバル変数としてStateを管理を行うPorviderを定義
// StateNotifier クラスを使用して状態管理を行うためのプロバイダー
final provider =
    StateNotifierProvider<PageNotifier, PageState>(
        (ref) => PageNotifier());

class PageNotifier extends StateNotifier<pageState> {
  PageNotifier() : super(const pageState());

  void increment() {
    state = state.copyWith('increment',state.counter + 1);
  }

  void decrement() {
    state = state.copyWith('decrement',state.cnt - 1);
  }

  // stateを変更しない
  void reBuild(){
    state = const pageState();
  }
}

```

**利用場所**

```dart
// --- Stateless Widget ---
// ConsumerWidgetを継承
class WidgetA extends ConsumerWidget {
  const WidgetA({super.key});

  @override
  // 引数にWidgetRefを受け取る
  Widget build(BuildContext context,WidgetRef ref) {
    final int counter = ref.watch(provider).counter;
    final int cnt = ref.watch(provider).cnt;
    final Function increment = ref.watch(provider.notifier).increment;
    return Column(
      children : [
        Text(
          '$counter'
        ),
        Text(
          '$cont'
        ),
        IcElevatedButtonon(
          onPressed: () {
            increment();
          },
          child: Icon(Icons.account_circle_outlined)
        )
      ]
    );
  }
}
```

```dart
// --- Stateful Widget ---
class WidgetA extends ConsumerStatefulWidget {
  const WidgetA({super.key});

  @override
  ConsumerState<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends ConsumerState<WidgetA> {
  ref.read(provider).counter;
  ref.read(provider.notifier).increment();
}
```

## refとwatch

https://zenn.dev/tarakosuziko/articles/39f3ee5f4cf678

- watch
  - プロバイダの状態を監視し、その状態が変化したときにウィジェットを再描画します。これは、プロバイダの状態をUIに反映させる場合に使われます。
  - プロバイダの状態をUIに表示したい場合。状態が変わったら、自動的にUIを更新する必要がある場合。
- read
  - プロバイダの状態を一度だけ取得し、その状態を操作するために使います。readを使うと、その状態が変わってもウィジェットの再描画は行われません。
  - プロバイダの状態を使って一度だけ操作したい場合。ボタンのクリックや入力など、ユーザーのアクションに応じて状態を変更したい場合。
- listen
  - プロバイダの状態の変更をリスニングし、変更があったときに特定のコールバックを実行します。
  - ウィジェット全体を再ビルドするのではなく、一度設定したコールバックで必要な処理だけを実行したい場合に使います。
