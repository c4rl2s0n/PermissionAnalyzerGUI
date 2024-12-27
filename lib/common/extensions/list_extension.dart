import 'dart:math' as math;

extension ListExtensions<T> on List<T> {
  List<T> get distinct => toSet().toList();
  List<T> sortedCopy(int Function(T a, T b) compare) {
    List<T> copy = List.of(this);
    copy.sort(compare);
    return copy;
  }

  List<T> insertBetweenItems(T Function() getObject) {
    if (isEmpty) return [];
    return [
      for (int i = 0; i < length - 1; i++) ...[this[i], getObject()],
      last,
    ];
  }

}

extension NumberListExtensions<T extends num> on List<T>{
  num get min => isEmpty ? 0 : reduce(math.min);
  num get max => isEmpty ? 0 : reduce(math.max);
  double get avg => isEmpty ? 0 : fold(0.0, (total,v) => total+v)/length;
}
