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

class DataGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ScrollContainer(
      scrollDirection: Axis.horizontal,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _columnHeaders(context),
          Expanded(
            child: ScrollContainer(
              scrollDirection: Axis.vertical,
              child: _rows(context),
            ),
          ),
        ],
      ),
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
            if (showIndex) ...[
              const SizedBox(
                width: _indexColumnWidth,
                child: Text("#"),
              ),
            ],
            ...columns.map((c) => _columnHeader(context, c)),
          ],
        ),
      ),
    );
  }

  Widget _columnHeader(BuildContext context, DataGridColumnSetting column) {
    Widget header = Text(column.name, textAlign: TextAlign.center,);
    if (column.tooltip != null) {
      header = Tooltip(message: column.tooltip, child: header);
    }
    return SizedBox(width: column.width, child: header);
  }

  Widget _rows(BuildContext context) {
    List<Widget> _rows = [];
    for (int i = 0; i < rows.length; i++) {
      DataGridRow r = rows[i];
      Widget row = TapContainer(
        onTap: r.onTap,
        padding:
            EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Row(
          children: [
            if (showIndex) ...[
              SizedBox(
                width: _indexColumnWidth,
                child: Text((i + 1).toString()),
              ),
            ],
            ..._rowCells(r),
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
        width: columns[i].width,
        child: row.cells[i],
      ));
    }
    return cells;
  }
}
