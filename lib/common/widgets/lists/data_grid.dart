import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class DataGridColumnSetting {
  DataGridColumnSetting({
    required this.name,
    this.tooltip,
    this.width = 50,
  });
  final String name;
  final String? tooltip;
  final double width;
}

class DataGridRow {
  DataGridRow({
    required this.cells,
    this.onTap,
  });
  final List<Widget> cells;
  final Function()? onTap;
}

class DataGrid extends StatefulWidget {
  DataGrid({
    required this.columns,
    required this.rows,
    this.showIndex = true,
    super.key,
  }) : assert(!rows.any((r) => r.cells.length != columns.length));
  // All rows have the same number of columns

  final List<DataGridColumnSetting> columns;
  final List<DataGridRow> rows;

  final bool showIndex;
  static const double _indexColumnWidth = 30;

  @override
  State<DataGrid> createState() => _DataGridTestState();
}

class _DataGridTestState extends State<DataGrid> {
  final ScrollController vertical = ScrollController();
  final ScrollController horizontalHeader = ScrollController();
  late final List<ScrollController> horizontalControllers;
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    horizontalControllers = widget.rows.map((_) => ScrollController()).toList();
    horizontalHeader.addListener(() async {
      if(_isAutoScrolling) return;
      _isAutoScrolling = true;
      for (var c in horizontalControllers) {
        c.jumpTo(horizontalHeader.offset);
      }
      _isAutoScrolling = false;
    });
    for(var controller in horizontalControllers){
      controller.addListener(() async {
        if(_isAutoScrolling) return;
        _isAutoScrolling = true;
        horizontalHeader.position.jumpTo(controller.offset);
        horizontalHeader.jumpTo(controller.offset);
        for (var c in horizontalControllers) {
          c.jumpTo(controller.offset);
        }
        _isAutoScrolling = false;
      });
    }
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
              const SizedBox(
                width: DataGrid._indexColumnWidth,
                child: Text("#"),
              ),
            ],
            Expanded(
              child: Scrollbar(
                //key: UniqueKey(),
                scrollbarOrientation: ScrollbarOrientation.top,
                controller: horizontalHeader,
                child: SingleChildScrollView(
                  key: UniqueKey(),
                  scrollDirection: Axis.horizontal,
                  controller: horizontalHeader,
                  child: Row(
                    children: [
                      ...widget.columns.map((c) => _columnHeader(context, c)),
                    ],
                  ),
                ),
              ),
            ),
            //...widget.columns.map((c) => _columnHeader(context, c)),
          ],
        ),
      ),
    );
  }

  Widget _columnHeader(BuildContext context, DataGridColumnSetting column) {
    Widget header = Text(
      column.name,
      textAlign: TextAlign.center,
    );
    if (column.tooltip != null) {
      header = Tooltip(message: column.tooltip, child: header);
    }
    return SizedBox(width: column.width, child: header);
  }

  Widget _rows(BuildContext context) {
    List<Widget> _rows = [];
    for (int i = 0; i < widget.rows.length; i++) {
      DataGridRow r = widget.rows[i];
      Widget row = TapContainer(
        onTap: r.onTap,
        padding:
            EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Row(
          children: [
            if (widget.showIndex) ...[
              SizedBox(
                width: DataGrid._indexColumnWidth,
                child: Text((i + 1).toString()),
              ),
            ],
            Expanded(
              child: SingleChildScrollView(
                key: UniqueKey(),
                scrollDirection: Axis.horizontal,
                primary: false,
                controller: horizontalControllers[i],
                child: Row(
                  children: _rowCells(r),
                ),
              ),
            ),
          ],
        ),
      );
      _rows.add(row);
    }
    return Column(
      children: _rows.insertBetweenItems(
        () => Margin.vertical(context.constants.smallSpacing),
      ),
    );
  }

  List<Widget> _rowCells(DataGridRow row) {
    List<Widget> cells = [];
    for (int i = 0; i < row.cells.length; i++) {
      cells.add(SizedBox(
        width: widget.columns[i].width,
        child: row.cells[i],
      ));
    }
    return cells;
  }
}
