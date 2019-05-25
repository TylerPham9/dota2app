import 'package:flutter/material.dart';
import 'package:dota2app/style.dart';

TableCell statsTableCell(String text, bool bold) {
  return TableCell(
      child: Padding(
    padding: CellPadding,
    child: Text(text, style: (bold) ? boldTextStyle : null),
  ));
}
