import 'package:flutter/material.dart';
import 'package:money_manager/Calculation.dart';
import 'package:money_manager/Constants/Percentages.dart';
import 'package:money_manager/SettingsPage.dart';
import 'package:money_manager/Utils/Colors.dart';
import 'package:money_manager/Utils/Colors.dart' as prefix0;
import 'package:money_manager/Widgets/Widgets.dart';
import 'package:money_manager/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController income = TextEditingController();
  TextEditingController needs = TextEditingController();

  check() {
    if (income.value.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  SharedPreferences preferences;

  getPref() async {
    preferences = await SharedPreferences.getInstance();
    taxPercentage = preferences.getInt("tax")==null?20:preferences.getInt("tax");
    needPercentage = preferences.getInt("need")==null?55:preferences.getInt("need");
    wantsPercentage = preferences.getInt("want")==null?25:preferences.getInt("want");
  }

  @override
  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white(),
      /*
      appBar: appBarCustom(context,title: Text(widget.title,style: TextStyle(color: black()),)),*/
      body: SafeArea(
          child: SizedBox(
        width: screenWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(onTap: navShift(context, SettingsPage()),child: Icon(Icons.settings,color: black(),)),
              ),
            ),
            Hero(tag: "Logo",child: Image.asset("Assets/Images/money.jpg")),
            SizedBox(
              height: 40,
            ),
            Column(
              children: <Widget>[
                rowInput(
                    fHint: "Enter Your Earning Here",
                    fcontroller: income,
                    prefixText: "₹",
                    fLabel: "Total Earning This Month",
                    inputType: TextInputType.number),
                prefix0.button(context,
                    title:
                        Text("Calculate It", style: TextStyle(color: white())),
                    onTap: navShift(
                        context, CalculationScreen(income.value.text),
                        IF: check()))
              ],
            )
          ],
        ),
      )),
    );
  }
}
