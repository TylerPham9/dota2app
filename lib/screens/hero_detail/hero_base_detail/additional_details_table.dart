import 'package:flutter/material.dart';
import 'package:dota2app/screens/hero_detail/hero_base_detail/stats_table_cell.dart';
import 'package:dota2app/style.dart';

class AdditionalDetailTable extends StatelessWidget {
  final List<List<String>> _details;

  AdditionalDetailTable(this._details);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
        left: TableBorderWidth,
        right: TableBorderWidth,
        bottom: TableBorderWidth,
        horizontalInside: TableBorderWidth,
        verticalInside: TableBorderWidth,
      ),
      children: []..addAll(_details
          .map((detail) => _additionalDetailTableRow(detail[0], detail[1]))),
    );
  }

  TableRow _additionalDetailTableRow(String text, String value) {
    return TableRow(children: [
      statsTableCell(text, true),
      statsTableCell(value, false),
    ]);
  }
}
