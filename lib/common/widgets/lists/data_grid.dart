import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class DataGridColumnSetting<T, V extends Object?> {
  DataGridColumnSetting({
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
  bool? sortAsc;
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

class DataGridActionColumnSetting<T> {
  DataGridActionColumnSetting({
    this.width = 50,
    required this.actions,
  });
  final double width;
  final List<Widget Function(T)> actions;
}

class DataGrid<T> extends StatefulWidget {
  const DataGrid({
    required this.columns,
    required this.data,
    this.onDataTap,
    this.rowActions,
    this.showIndex = true,
    this.provideHorizontalScrollbarSpace = true,
    super.key,
  });

  final List<DataGridColumnSetting<T, Object?>> columns;
  final DataGridActionColumnSetting<T>? rowActions;
  final List<T> data;
  final Function(T)? onDataTap;

  final bool showIndex;
  final bool provideHorizontalScrollbarSpace;
  static const double _indexColumnWidth = 30;
  static const double _sortIconSize = 17;

  @override
  State<DataGrid<T>> createState() => _DataGridTestState<T>();
}

class _DataGridTestState<T> extends State<DataGrid<T>> {
  late List<T> data;
  List<DataGridColumnSetting<T, Object?>> columns = [];
  final ScrollController vertical = ScrollController();
  final ScrollController horizontalHeader = ScrollController();
  late List<ScrollController> horizontalControllers;
  bool _isAutoScrolling = false;

  void syncScrollControllers(
      ScrollController source, List<ScrollController> targets) {
    if (_isAutoScrolling) return;
    _isAutoScrolling = true;
    for (var target in targets) {
      if (target.hasClients && target != source) {
        target.jumpTo(source.offset);
      }
    }
    _isAutoScrolling = false;
  }

  void _sort(DataGridColumnSetting<T, Object?> column, {bool toggleSort=true,}) {
    if (!column.canSort) return;
    if(toggleSort) {
      _toggleSort(column);
    }
    if(column.sortAsc == null) return;

    // sort the list asc/desc
    int compare(Object? a, Object? b) =>
        column.sortAsc! ? column.compare!(a, b) : column.compare!(b, a);
    data.sort((a, b) => compare(column.getValue!(a), column.getValue!(b)));

    // update state
    setState(() {});
  }
  void _toggleSort(DataGridColumnSetting<T, Object?> column){
    // get the desired sort direction of the current column
    bool sortAsc = !(column.sortAsc ?? false);
    // reset all sortings
    for (var c in columns) {
      c.sortAsc = null;
    }
    // apply the sorting to the current column
    column.sortAsc = sortAsc;
  }

  @override
  void didUpdateWidget(covariant DataGrid<T> oldGrid) {
    setupDataColumns();
    setupScrollControllers();
    super.didUpdateWidget(oldGrid);
  }

  void setupDataColumns() {
    // copy data from widget
    data = List.of(widget.data);
    // copy columns from widget and apply sorting if it was sorted before
    var sortedColumn = columns.where((c) => c.sortAsc != null).firstOrNull;
    columns = List.of(widget.columns);
    if (sortedColumn != null) {
      var newSortedColumn = columns.where((c) => c.name == sortedColumn.name).firstOrNull;
      if(newSortedColumn != null) {
        newSortedColumn.sortAsc = sortedColumn.sortAsc;
        _sort(newSortedColumn, toggleSort: false);
      }
    }
  }

  void setupScrollControllers() {
    // TODO: do I need to remove listeners?
    // synchronize horizontal scrolling
    horizontalControllers = data.map((_) => ScrollController()).toList();
    horizontalHeader.addListener(
        () => syncScrollControllers(horizontalHeader, horizontalControllers));
    for (var controller in horizontalControllers) {
      controller.addListener(() => syncScrollControllers(
          controller, [horizontalHeader, ...horizontalControllers]));
    }
  }

  @override
  void initState() {
    setupDataColumns();
    setupScrollControllers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _columnHeaders(context),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Expanded(
            child: Scrollbar(
              controller: vertical,
              scrollbarOrientation: ScrollbarOrientation.right,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: vertical,
                child: _rows(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _columnHeaders(BuildContext context) {
    // spacing for horizontal scrollbar
    double topPaddingValue =
        context.themeData.scrollbarTheme.thickness?.resolve({}) ?? 0;
    topPaddingValue *= 1.6;
    return Padding(
      padding: EdgeInsets.only(bottom: context.constants.spacing),
      child: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(color: context.colors.onBackground),
          ),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Row(
          children: [
            if (widget.showIndex) ...[
              Padding(
                padding: widget.provideHorizontalScrollbarSpace
                    ? EdgeInsets.only(top: topPaddingValue)
                    : EdgeInsets.zero,
                child: const SizedBox(
                  width: DataGrid._indexColumnWidth,
                  child: Text("#"),
                ),
              ),
            ],
            Expanded(
              child: Scrollbar(
                scrollbarOrientation: ScrollbarOrientation.top,
                controller: horizontalHeader,
                child: Padding(
                  padding: widget.provideHorizontalScrollbarSpace
                      ? EdgeInsets.only(top: topPaddingValue)
                      : EdgeInsets.zero,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: horizontalHeader,
                    child: Row(
                      children: [
                        ...columns.map((c) => _columnHeader(context, c)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.rowActions != null) ...[
              SizedBox(width: widget.rowActions!.width),
            ],
          ],
        ),
      ),
    );
  }

  Widget _columnHeader(
    BuildContext context,
    DataGridColumnSetting<T, Object?> column,
  ) {
    double width = column.width;
    if (column.sortAsc != null) {
      width += DataGrid._sortIconSize;
    }
    Widget header = TapContainer(
      onTap: column.canSort ? () => _sort(column) : null,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              column.name,
              textAlign: column.headerAlign,
              style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: column.sortAsc != null ? FontWeight.bold : null),
            ),
          ),
          if (column.sortAsc == true)
            Icon(
              context.icons.sortAsc,
              size: DataGrid._sortIconSize,
            ),
          if (column.sortAsc == false)
            Icon(
              context.icons.sortDesc,
              size: DataGrid._sortIconSize,
            ),
        ],
      ),
    );
    if (column.tooltip != null) {
      header = Tooltip(message: column.tooltip, child: header);
    }
    return SizedBox(width: width, child: header);
  }

  Widget _rows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      T entry = data[i];
      Widget row = TapContainer(
        onTap: widget.onDataTap != null ? () => widget.onDataTap!(entry) : null,
        backgroundColor: context.colors.onBackground.withOpacity(0.1),
        padding:
            EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Row(
          children: [
            // index-header
            if (widget.showIndex) ...[
              SizedBox(
                width: DataGrid._indexColumnWidth,
                child: Text((i + 1).toString()),
              ),
            ],
            // data columns
            if (data.isNotEmpty) ...[
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  controller: horizontalControllers[i],
                  child: Row(children: _rowCells(entry)),
                ),
              ),
            ],
            // trailing column with actions
            if (widget.rowActions != null) ...[
              SizedBox(
                width: widget.rowActions!.width,
                child: Row(
                  children: widget.rowActions!.actions
                      .map((aw) => aw(entry))
                      .toList(),
                ),
              ),
            ]
          ],
        ),
      );
      rows.add(row);
    }
    return Column(
      children: rows.insertBetweenItems(
        () => Margin.vertical(context.constants.smallSpacing),
      ),
    );
  }

  List<Widget> _rowCells(T entry) {
    List<Widget> cells = [];
    for (var column in columns) {
      double width = column.width;
      if (column.sortAsc != null) {
        width += DataGrid._sortIconSize;
      }
      cells.add(SizedBox(
        width: width,
        child: column.getCell!(entry),
      ));
    }
    return cells;
  }
}
