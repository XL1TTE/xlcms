
extension RangeExtension on int {
  void times(void Function(int index) f) {
    for (int i = 0; i < this; i++) {
      f(i);
    }
  }
}