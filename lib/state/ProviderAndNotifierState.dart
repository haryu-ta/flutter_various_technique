class ProviderAndNotifierState {
  const ProviderAndNotifierState({this.counter = 0});
  final int counter;

  ProviderAndNotifierState copyWith(int counter) {
    return ProviderAndNotifierState(
      counter: counter
    );
  }
}