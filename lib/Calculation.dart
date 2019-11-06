import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:money_manager/Constants/Percentages.dart';
import 'package:money_manager/Utils/Colors.dart' as prefix0;
import 'package:money_manager/Widgets/Widgets.dart';
import 'package:screenshot/screenshot.dart';

import 'Utils/Colors.dart';

class CalculationScreen extends StatefulWidget {
  String income;
  var tax;
  var wants;
  var needs;

  CalculationScreen(this.income);

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white(),
      /*
      appBar: appBarCustom(context,title: Text(widget.title,style: TextStyle(color: black()),)),*/
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
                width: screenWidth(context),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: backButton(context)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Money Manager",
                          style: TextStyle(color: black(), fontSize: 18),
                        ),
                      ),
                      Text(
                        "Manage Your Money Smartly",
                        style: TextStyle(color: blackLess(), fontSize: 12),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: <Widget>[
                          Divider(
                            color: blackLess(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Money",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Text(
                            "₹${widget.income}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          Divider(
                            color: blackLess(),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Money To Save",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "₹${widget.tax.toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: blackLess(),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Money For needs",
                                  textAlign: TextAlign.start,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "₹${widget.needs.toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: blackLess(),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Money For wants",
                                  textAlign: TextAlign.start,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "₹${widget.wants.toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: blackLess(),
                          ),
                        /*  prefix0.button(context,
                              title: Text(
                                "ScreenShot This Page",
                                style: TextStyle(color: prefix0.white()),
                              ), onTap: () {
                            _imageFile = null;
                            screenshotController
                                .capture()
                                .then((File image) async {
                              print("Capture Done");
                              setState(() {
                                _imageFile = image;
                              });
                              final result = await ImageGallerySaver.saveImage(
                                  image.readAsBytesSync());
                              print("File Saved to Gallery");
                            }).catchError((onError) {
                              print(onError);
                            });
                          }),
                          _imageFile != null ? Image.file(_imageFile) : Container(),*/
                        ],
                      )
                    ]))),
      ),
    );
  }

  @override
  void initState() {
    calculations();
  }

  calculations() {
    var income_in_int = int.parse(widget.income);
    widget.tax = income_in_int / 100 * taxPercentage;
    widget.wants = income_in_int / 100 * wantsPercentage;
    widget.needs = income_in_int / 100 * needPercentage;
    setState(() {});
  }
}
