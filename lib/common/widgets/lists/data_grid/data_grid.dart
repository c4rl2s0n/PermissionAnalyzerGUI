import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

part 'data_grid_column.dart';


class DataGrid<T> extends StatefulWidget {
  const DataGrid({
    required this.columns,
    required this.data,
    this.onDataTap,
    this.onDataSecondaryTap,
    this.onDataSelected,
    this.initialSelectedIndex,
    this.rowActions,
    this.showIndex = true,
    this.provideHorizontalScrollbarSpace = true,
    this.rowHeight,
    this.indexColumnWidth = 42,
    super.key,
  }) : assert(onDataTap == null || onDataSelected == null);

  final List<DataGridColumn<T, Object?>> columns;
  final DataGridActionColumn<T>? rowActions;
  final List<T> data;
  final Function(T, [Offset?])? onDataTap;
  final Function(T, [Offset?])? onDataSecondaryTap;
  final Function(T?, int?)? onDataSelected;
  final int? initialSelectedIndex;

  final bool showIndex;
  final bool provideHorizontalScrollbarSpace;
  final double? rowHeight;
  final double indexColumnWidth;
  static const double _sortIconSize = 17;

  @override
  State<DataGrid<T>> createState() => _DataGridTestState<T>();
}

class _DataGridTestState<T> extends State<DataGrid<T>> {
  late List<T> data;
  List<DataGridColumn<T, Object?>> columns = [];
  final ScrollController vertical = ScrollController();
  final ScrollController horizontalHeader = ScrollController();
  double horizontalScrollOffset = 0;
  late List<ScrollController> horizontalControllers;
  T? selectedItem;
  bool _isAutoScrolling = false;

  void syncScrollControllers(
      ScrollController source, List<ScrollController> targets) {
    if (source.offset == horizontalScrollOffset || _isAutoScrolling) return;
    _isAutoScrolling = true;
    horizontalScrollOffset = source.offset;
    for (var target in targets) {
      if (target.hasClients && target != source) {
        target.jumpTo(source.offset);
      }
    }
    _isAutoScrolling = false;
  }

  void _sort(
    DataGridColumn<T, Object?> column, {
    bool toggleSort = true,
  }) {
    if (!column.canSort) return;
    if (toggleSort) {
      _toggleSort(column);
    }
    if (column.sortDesc == null) return;

    // sort the list asc/desc
    int compare(Object? a, Object? b) =>
        column.sortDesc! ? column.compare!(b, a) : column.compare!(a, b);
    data.sort((a, b) => compare(column.getValue!(a), column.getValue!(b)));

    // update state
    setState(() {});
  }

  void _toggleSort(DataGridColumn<T, Object?> column) {
    // get the desired sort direction of the current column
    bool sortAsc = !(column.sortDesc ?? false);
    // reset all sortings
    for (var c in columns) {
      c.sortDesc = null;
    }
    // apply the sorting to the current column
    column.sortDesc = sortAsc;
  }

  void _selectItemByIndex(int? index){
    if(index == null || index < 0 || index >= widget.data.length) {
      _selectItem(null);
    } else {
      _selectItem(widget.data[index]);
    }
  }
  void _selectItem(T? entry) {
    if(widget.onDataSelected == null) return;
    setState(() {
      selectedItem = entry;
    });
    widget.onDataSelected!(
      entry,
      entry != null ? widget.data.indexOf(entry) : null,
    );
  }

  @override
  void didUpdateWidget(covariant DataGrid<T> oldGrid) {
    setupDataColumns();
    setupScrollControllers();
    _selectItemByIndex(widget.initialSelectedIndex);
    super.didUpdateWidget(oldGrid);
  }

  void setupDataColumns() {
    // copy data from widget
    data = List.of(widget.data);
    // copy columns from widget and apply sorting if it was sorted before
    var sortedColumn = columns.where((c) => c.sortDesc != null).firstOrNull;
    columns = List.of(widget.columns);
    if (sortedColumn != null) {
      var newSortedColumn =
          columns.where((c) => c.name == sortedColumn.name).firstOrNull;
      if (newSortedColumn != null) {
        newSortedColumn.sortDesc = sortedColumn.sortDesc;
        _sort(newSortedColumn, toggleSort: false);
      }
    }
  }

  void setupScrollControllers() {
    // TODO: do I need to remove listeners?
    // synchronize horizontal scrolling
    horizontalControllers = [];
    for(int i=0;i<data.length;i++){
      horizontalControllers.add(ScrollController(onAttach: (pos){
        // when a new ScrollPosition is attached, create PostFrameCallback to perform initial Scroll once Widget is created
        ScrollController sc = horizontalControllers[i];
        if(sc.hasClients && horizontalScrollOffset != 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) => pos.jumpTo(horizontalScrollOffset));
        }
      }));
    }
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
    _selectItemByIndex(widget.initialSelectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap:
          widget.onDataSelected != null ? () => _selectItem(null) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _columnHeaders(context),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Expanded(
              child: Scrollbar(
                controller: vertical,
                scrollbarOrientation: ScrollbarOrientation.right,
                child: ListView.builder(
                  controller: vertical,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemExtent: widget.rowHeight,
                  itemBuilder: _buildRow,
                ),
              ),
            ),
          ),
        ],
      ),
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
                child: SizedBox(
                  width: widget.indexColumnWidth,
                  child: const Text("#"),
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
    DataGridColumn<T, Object?> column,
  ) {
    double width = column.width;
    if (column.sortDesc != null) {
      width += DataGrid._sortIconSize;
    }
    Widget header = TapContainer(
      onTap: column.canSort ? (_) => _sort(column) : null,
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
                  fontWeight: column.sortDesc != null ? FontWeight.bold : null),
            ),
          ),
          if (column.sortDesc == true)
            Icon(
              context.icons.sortAsc,
              size: DataGrid._sortIconSize,
            ),
          if (column.sortDesc == false)
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

  Widget _buildRow(BuildContext context, int index) {
      T entry = data[index];
      ScrollController scrollController = horizontalControllers[index];
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.constants.smallSpacing/2),
        child: TapContainer(
          onTap: widget.onDataTap != null
              ? (_) => widget.onDataTap!(entry)
              : widget.onDataSelected != null
                  ? (_) => _selectItem(entry)
                  : null,
          onSecondaryTap: widget.onDataSecondaryTap != null ? (p) => widget.onDataSecondaryTap!(entry, p) : null,
          backgroundColor: entry == selectedItem
                  ? context.colors.highlight.withOpacity(0.3)
                  : context.colors.onBackground.withOpacity(0.1),
          padding:
              EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
          child: Row(
            children: [
              // index-header
              if (widget.showIndex) ...[
                SizedBox(
                  width: widget.indexColumnWidth,
                  child: Text((index + 1).toString()),
                ),
              ],
              // data columns
              if (data.isNotEmpty) ...[
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    controller: scrollController,
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
        ),
      );
  }

  List<Widget> _rowCells(T entry) {
    List<Widget> cells = [];
    for (var column in columns) {
      double width = column.width;
      if (column.sortDesc != null) {
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
