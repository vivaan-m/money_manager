import 'package:flutter/material.dart';

white() => Colors.white;

blue() => Colors.blue;

black() => Colors.black;

red() => Colors.red;

green() => Colors.green;

bluedark() => Colors.blue[900];

whiteLess() => Colors.white30;

yellow() => Colors.yellow;

blackLess() => Colors.black38;

fadedBlack() => Colors.black87;

transparent() => Colors.transparent;

screenHeight(context) => MediaQuery.of(context).size.height;

screenWidth(context) => MediaQuery.of(context).size.width;



Widget button(context, {title, onTap}) => SizedBox(
  width: screenWidth(context),
  child: Padding(
    padding: const EdgeInsets.all(5.0),
    child: RawMaterialButton(
      elevation: 4,
      padding: EdgeInsets.all(10),
      onPressed: onTap,
      animationDuration: Duration(milliseconds: 800),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      fillColor: blue(),
      child: Padding(padding: const EdgeInsets.all(8.0), child: title),
    ),
  ),
);

