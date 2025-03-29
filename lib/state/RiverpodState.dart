class RiverpodState {
  const RiverpodState({this.counter = 0, this.cnt = 10});
  final int counter;
  final int cnt;

  RiverpodState copyWith(String kbn, int count) {
    if (kbn == 'increment') {
      return RiverpodState(
        counter: count,
        cnt: cnt,
      );
    } else if (kbn == 'decrement') {
      return RiverpodState(
        counter: counter,
        cnt: count,
      );
    } else {
      return RiverpodState(
        counter: counter,
        cnt: cnt,
      );
    }
  }
}
