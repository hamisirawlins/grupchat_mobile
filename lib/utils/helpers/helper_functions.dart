import 'package:flutter/material.dart';

class UtilHelper {
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.skip(i).take(rowSize).toList();
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }

  static List<Widget> wrapWidgetsInColumn(
      List<Widget> widgets, int columnSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += columnSize) {
      final columnChildren = widgets.skip(i).take(columnSize).toList();
      wrappedList.add(Column(
        children: columnChildren,
      ));
    }
    return wrappedList;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
