import 'dart:io';

import 'package:animator/animator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/Calculation.dart';
import 'package:money_manager/Constants/Percentages.dart';
import 'package:money_manager/SettingsPage.dart';
import 'package:money_manager/Utils/Colors.dart';
import 'package:money_manager/Utils/Colors.dart' as prefix0;
import 'package:money_manager/Widgets/Widgets.dart';
import 'package:money_manager/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AnimationRoutes/SlideLeftRoute.dart';

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

  SharedPreferences preferences;

  getPref() async {
    preferences = await SharedPreferences.getInstance();
    taxPercentage =
        preferences.getInt("tax") == null ? 20 : preferences.getInt("tax");
    needPercentage =
        preferences.getInt("need") == null ? 55 : preferences.getInt("need");
    wantsPercentage =
        preferences.getInt("want") == null ? 25 : preferences.getInt("want");
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
                child: InkWell(
                    onTap: navShift(context, SettingsPage()),
                    child: Icon(
                      Icons.settings,
                      color: black(),
                    )),
              ),
            ),
            Hero(tag: "Logo", child: Image.asset("Assets/Images/money.jpg")),
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
                prefix0.button(
                  context,
                  title: Text("Calculate It", style: TextStyle(color: white())),
                  onTap: () {
                    if (income.value.text.isEmpty) {
                      Flushbar(
                        title: "Income Is Not Entered",
                        message: "Enter Your Income For Calculations",
                        overlayBlur: 0.4,
                        barBlur: 0.2,
                        leftBarIndicatorColor: Colors.blue[300],
                        icon: Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.blue[300],
                        ),
                        overlayColor: blackLess(),
                        borderRadius: 3,
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                        duration: Duration(seconds: 5),
                      )..show(context);
                    } else {
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              page: CalculationScreen(income.value.text)));
                    }
                  },
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Animator(
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 2),
              builder: (anim) => Transform.scale(
                scale: anim.value,
                child: Shimmer.fromColors(
                  baseColor: bluedark(),
                  highlightColor: blue(),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Flushbar(
                            mainButton:FlatButton(onPressed: (){openInsta();}, child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                    "https://instagram.fixc1-3.fna.fbcdn.net/vp/b5c86e50df9499909cb618b2cb3fb28e/5E547B1A/t51.2885-19/s150x150/61283099_197068924536135_5408262045059514368_n.jpg?_nc_ht=instagram.fixc1-3.fna.fbcdn.net"),
                              ),
                            ),),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            overlayBlur: 0.4,
                            barBlur: 0.2,
                            backgroundGradient: LinearGradient(colors: [Colors.purple,Colors.blue]),
                            overlayColor: blackLess(),
                            titleText: Text("@vi.va.an",textAlign: TextAlign.center,style: TextStyle(color: white(),fontSize: 16,fontWeight: FontWeight.w700),),
                            messageText: Text("Click On Picture To Open Profile",textAlign: TextAlign.center,style: TextStyle(color: white()),),
                            onTap: (ob){openInsta();},
                            duration: Duration(seconds: 20),
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            reverseAnimationCurve: Curves.bounceIn,
                          )..show(context);
                         //openInsta();
                        },
                        child: Text(
                          'Follow Us on Instagram',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

openInsta() async {
  if (Platform.isAndroid) {
    if (await canLaunch(
        "intent://instagram.com/_u/vi.va.an/#Intent;package=com.instagram.android;scheme=https;end")) {
      await launch(
          "intent://instagram.com/_u/vi.va.an/#Intent;package=com.instagram.android;scheme=https;end");
    } else {
      await launch("https://www.instagram.com/vi.va.an/");
    }
  } else if (Platform.isIOS) {
    if (await canLaunch("instagram://user?username=vi.va.an")) {
      await launch("instagram://user?username=vi.va.an");
    } else {
      await launch("https://www.instagram.com/vi.va.an/");
    }
  }
}
