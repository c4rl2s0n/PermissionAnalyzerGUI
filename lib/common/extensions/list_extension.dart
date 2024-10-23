
extension ListExtensions<T> on List<T>{
  List<T> get distinct => toSet().toList();

  List<T> insertBetweenItems(T Function() getObject) {
    if(isEmpty) return [];
    return [
      for (int i = 0; i < length - 1; i++) ...[this[i], getObject()],
      last,
    ];
  }

}

