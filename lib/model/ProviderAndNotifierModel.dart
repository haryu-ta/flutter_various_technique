import 'package:flutter_state_controll/state/ProviderAndNotifierState.dart';
import 'package:state_notifier/state_notifier.dart';

class ProviderAndNotifierModel extends StateNotifier<ProviderAndNotifierState> {
  ProviderAndNotifierModel() : super(const ProviderAndNotifierState());

  void increment() {
    state = state.copyWith(state.counter + 1);
  }

  void reBuild(){
    state = const ProviderAndNotifierState();
  }
}