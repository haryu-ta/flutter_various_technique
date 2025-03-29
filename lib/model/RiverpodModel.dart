import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_controll/state/RiverPodState.dart';

class RiverpodModel extends StateNotifier<RiverpodState> {
  RiverpodModel() : super(const RiverpodState());

  void increment() {
    state = state.copyWith('increment',state.counter + 1);
  }

  void decrement() {
    state = state.copyWith('decrement',state.cnt - 1);
  }

  void reBuild(){
    state = const RiverpodState();
  }
}