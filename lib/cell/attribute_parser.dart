import 'package:flutter/material.dart';

EdgeInsetsGeometry parseEdgeInsetsGeometry(String edgeInsetsGeometryString) {
  if (edgeInsetsGeometryString == null ||
      edgeInsetsGeometryString.trim() == '') {
    return null;
  }
  var values = edgeInsetsGeometryString.split(",");
  return EdgeInsets.only(
      left: double.parse(values[0]),
      top: double.parse(values[1]),
      right: double.parse(values[2]),
      bottom: double.parse(values[3]));
}

MainAxisAlignment parseMainAxisAlignment(String mainAxisAlignmentString) {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
  switch (mainAxisAlignmentString) {
    case 'spaceAround':
      mainAxisAlignment = MainAxisAlignment.spaceAround;
      break;
    case 'center':
      mainAxisAlignment = MainAxisAlignment.center;
      break;
    case 'end':
      mainAxisAlignment = MainAxisAlignment.end;
      break;
    case 'spaceBetween':
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
      break;
    case 'spaceEvenly':
      mainAxisAlignment = MainAxisAlignment.spaceEvenly;
      break;
    case 'start':
      mainAxisAlignment = MainAxisAlignment.start;
      break;
  }
  return mainAxisAlignment;
}

CrossAxisAlignment parseCrossAxisAlignment(String crossAxisAlignmentString) {
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  switch (crossAxisAlignmentString) {
    case 'center':
      crossAxisAlignment = CrossAxisAlignment.center;
      break;
    case 'end':
      crossAxisAlignment = CrossAxisAlignment.end;
      break;
    case 'start':
      crossAxisAlignment = CrossAxisAlignment.start;
      break;
  }
  return crossAxisAlignment;
}

IconData parseIcon(String typeString) {
  IconData type = Icons.add;
  switch (typeString) {
    case 'add':
      type = Icons.add;
      break;
    case 'remove':
      type = Icons.remove;
      break;
  }
  return type;
}