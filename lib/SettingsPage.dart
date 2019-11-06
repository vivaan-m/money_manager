import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:money_manager/Constants/Percentages.dart';
import 'package:money_manager/Utils/Colors.dart';
import 'package:money_manager/Widgets/Widgets.dart';
import 'package:money_manager/Widgets/Widgets.dart' as prefix1;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _taxvalue = prefix0.double.parse("$taxPercentage");
  var _wantsvalue = prefix0.double.parse("$wantsPercentage");
  var _needsvalue = prefix0.double.parse("$needPercentage");

  SharedPreferences preferences;

  prefix0.bool error = false;

  prefix0.bool success = false;

  getPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                backButton(context),
                Expanded(
                    child: Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: black(), fontSize: 18),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    color: transparent(),
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Save percentage",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FluidSlider(
                        value: _taxvalue,
                        labelsTextStyle:
                            TextStyle(fontSize: 15, color: white()),
                        valueTextStyle: TextStyle(fontSize: 15, color: blue()),
                        sliderColor: blue(),
                        onChanged: (double newValue) {
                          setState(() {
                            _taxvalue = newValue;
                          });
                        },
                        min: 0.0,
                        max: 100.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Needs percentage",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FluidSlider(
                        value: _needsvalue,
                        labelsTextStyle:
                            TextStyle(fontSize: 15, color: white()),
                        valueTextStyle: TextStyle(fontSize: 15, color: blue()),
                        sliderColor: blue(),
                        onChanged: (double newValue) {
                          setState(() {
                            _needsvalue = newValue;
                          });
                        },
                        min: 0.0,
                        max: 100.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Wants percentage",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FluidSlider(
                        value: _wantsvalue,
                        labelsTextStyle:
                            TextStyle(fontSize: 15, color: white()),
                        valueTextStyle: TextStyle(fontSize: 15, color: blue()),
                        sliderColor: blue(),
                        onChanged: (double newValue) {
                          setState(() {
                            _wantsvalue = newValue;
                          });
                        },
                        min: 0.0,
                        max: 100.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(visible:true,child: Text("Total Percentage : ${_taxvalue.toInt()+_wantsvalue.toInt()+_needsvalue.toInt()}",textAlign: TextAlign.center,style: TextStyle(color: _taxvalue.toInt()+_wantsvalue.toInt()+_needsvalue.toInt()<=100?blue():red()),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(visible:error,child: Text("Failed To Save This Setting \nError: You Cannot Exceed From 100%\nSolution: Choose only those values whose sum will be evaluated less than or eqaul to 100%",textAlign: TextAlign.center,style: TextStyle(color: red()),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(visible:success,child: Text("Successfuly Saved This Setting",textAlign: TextAlign.center,style: TextStyle(color: green()),)),
                ),
                SizedBox(height: 50,),
                prefix1.button(context, title: Text("Save These Settings",style: TextStyle(color: white()),),
                    onTap: () {
                  if(_taxvalue.toInt()+_wantsvalue.toInt()+_needsvalue.toInt()<=100.0){
                  preferences.setInt("tax", _taxvalue.toInt());
                  preferences.setInt("need", _needsvalue.toInt());
                  preferences.setInt("want", _wantsvalue.toInt());
                  taxPercentage = _taxvalue.toInt();
                  wantsPercentage = _wantsvalue.toInt();
                  needPercentage = _needsvalue.toInt();
                  setState(() {
                    error = false;
                    success = true;
                  });}else{
                    setState(() {
                      error = true;
                    });
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
