part of 'data_grid.dart';

class DataGridColumn<T, V extends Object?> {
  DataGridColumn({
    required this.name,
    this.getCell,
    this.getValue,
    this.compare,
    this.tooltip,
    this.headerAlign = TextAlign.left,
    this.defaultCellTextAlign = TextAlign.left,
    this.width = 50,
  }) : assert(getCell != null || getValue != null) {
    _initDefaultCell();
    _initDefaultComparison();
  }

  // displayed text of column header
  final String name;

  // tooltip text of column header
  final String? tooltip;

  // column width
  final double width;

  // text alignment of column header
  final TextAlign headerAlign;

  // text alignment if no getCell function is provided
  final TextAlign defaultCellTextAlign;

  // custom cell creator
  Widget Function(T)? getCell;

  // get the represented value of the data entry
  final V Function(T)? getValue;

  // compare two values of the data list
  int Function(Object?, Object?)? compare;

  // sort direction (null = no sorting, true = ascending, false = descending)
  bool? sortDesc;

  bool get canSort => getValue != null && compare != null;

  // if not provided, getCell creates a Text widget with value.toString
  void _initDefaultCell() {
    if (getCell != null) return;
    assert(getValue != null);
    getCell = (e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            getValue!(e).toString(),
            textAlign: defaultCellTextAlign,
          ),
        );
  }

  // setup comparison for default types
  void _initDefaultComparison() {
    if (compare != null) return;
    int? compareNulls(Object? a, Object? b) => a == null
        ? 1
        : b == null
            ? -1
            : null;
    if (isNullableSubtype<V, num>()) {
      compare = (Object? a, Object? b) =>
          compareNulls(a, b) ?? (a as num).compareTo((b as num));
    } else if (isNullableSubtype<V, String>()) {
      compare = (Object? a, Object? b) =>
          compareNulls(a, b) ??
          (a as String).toLowerCase().compareTo((b as String).toLowerCase());
    } else if (isNullableSubtype<V, bool>()) {
      compare = (Object? a, Object? b) {
        if (a == null || b == null) return compareNulls(a, b)!;
        bool x = (a as bool);
        bool y = (b as bool);
        if (x && !y) return 1;
        if (!x && y) return -1;
        return 0;
      };
    } else if (isNullableSubtype<V, DateTime>()) {
      compare = (Object? a, Object? b) =>
          compareNulls(a, b) ?? (a as DateTime).compareTo((b as DateTime));
    }
  }
}



class DataGridActionColumn<T> {
  DataGridActionColumn({
    this.width = 50,
    required this.actions,
  });
  final double width;
  final List<Widget Function(T)> actions;
}