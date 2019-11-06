import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/AnimationRoutes/SlideLeftRoute.dart';
import 'package:money_manager/Utils/Colors.dart';

Widget appBarCustom(context, {Widget title, iconTheme = false, onBack,actions,leading}) =>
    AppBar(
      actionsIconTheme: IconThemeData(color: iconTheme ? white() : black()),
      actions:actions,
      iconTheme: IconThemeData(color: iconTheme ? white() : black()),
      elevation: 0,
      leading: Animator(
          duration: Duration(seconds: 2),
          tween: Tween(begin: Offset(-300, 00), end: Offset(00, 00)),
          curve: Curves.linear,
          builder: (anim) => Transform.translate(
              offset: anim.value,
              child: InkWell(
                  onTap:onBack==null?() {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  }:onBack,
                  child: leading))),
      backgroundColor: iconTheme ? black() : white(),
      centerTitle: true,
      title: animationBody(title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
    );

shift(context, routeName) {
  return () {
    Navigator.pushNamed(context, routeName);
  };
}

void _snackBar(String text, _scaffoldKey) {
  final snackBar = SnackBar(
    content: Text('$text'),
    duration: Duration(seconds: 10),
    action: SnackBarAction(
      label: 'Close',
      textColor: white(),
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}

navShift(context, page, {IF = true, snackBarText, scaffoldKey}) {
  return () {
    if (IF) {
      Navigator.push(context, SlideLeftRoute(page: page));
    } else {
      _snackBar(snackBarText, scaffoldKey);
    }
  };
}

Widget button(context, {title, onTap}) => Animator(
    resetAnimationOnRebuild: false,
    duration: Duration(seconds: 2),
    tween: Tween(begin: Offset(-900, 00), end: Offset(00, 00)),
    curve: Curves.bounceIn,
    builder: (anim) => Transform.translate(
        offset: anim.value,
        child: SizedBox(
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
        )));

Widget row2Inputs(
    {fLabel,
      fHint,
      sLabel,
      sHint,
      fController,
      sController,
      fmaxword,
      smaxword,
      fobscure = false,
      sobscure = false}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(fLabel)),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Text(sLabel)),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: fController,
                  obscureText: fobscure,
                  maxLength: fmaxword,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: fHint,
                      hintStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black()))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: sController,
                  obscureText: sobscure,
                  maxLength: smaxword,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 13),
                      hintText: sHint,
                      counterText: "",

                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black()))),
                ),
              ),
            ],
          ),
        ],
      ),
    );

Widget rowInput({fLabel, fHint, fcontroller, inputType = TextInputType.text,prefixText}) =>
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(fLabel)),
                /*SizedBox(width: 10,),
                                      Expanded(
                                          child: Text("Stylist Phone Number")),*/
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: inputType,
                  controller: fcontroller,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    prefixText: prefixText,
                      hintStyle: TextStyle(fontSize: 13),
                      hintText: fHint,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black()))),
                ),
              ),
            ],
          )
        ]));

Widget coupon({fLabel, fHint, fcontroller, button}) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(fLabel)),
            /*SizedBox(width: 10,),
                                      Expanded(
                                          child: Text("Stylist Phone Number")),*/
          ],
        ),
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: TextField(
              controller: fcontroller,
              onChanged: (value) {},
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: fHint,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: black()))),
            ),
          ),
          Expanded(
            flex: 5,
            child: button,
          )
        ],
      )
    ]));

Widget profilePic(image) {
  return SizedBox(
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundColor: white(),
        backgroundImage: image == null
            ? AssetImage("assets/images/userpick.png")
            : FileImage(image),
      ));
}

Widget Spinner(List list) {
  var each;
  List<DropdownMenuItem> dropList = [];

  for (each in list) {
    dropList.add(DropdownMenuItem(
      child: Text(each),
      value: each,
    ));
  }
  return Theme(
    data: ThemeData(
        primaryTextTheme: TextTheme(
            button: TextStyle(color: black()),
            title: TextStyle(color: black()),
            subtitle: TextStyle(color: black()))),
    child: DropdownButton(
        value: "Choose",
        style: TextStyle(color: black()),
        items: dropList,
        onChanged: (value) {
          print(value);
        }),
  );
}

Widget imagePlusText({leftImg, text, rightImg,big=false}) => Animator(
    resetAnimationOnRebuild: false,
    duration: Duration(seconds: 1),
    tween: leftImg == null
        ? Tween(begin: Offset(700, 00), end: Offset(00, 00))
        : Tween(begin: Offset(-700, 00), end: Offset(00, 00)),
    curve: Curves.bounceIn,
    builder: (anim) => Transform.translate(
      offset: anim.value,
      child: Row(
        children: <Widget>[
          leftImg == null
              ? SizedBox()
              : Expanded(
              flex: 1,
              child: Image.asset(
                leftImg,
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: fadedBlack(), letterSpacing: 1, fontSize:big?25:10),
                ),
              )),
          rightImg == null
              ? SizedBox()
              : Expanded(
              flex: 1,
              child: Image.asset(
                rightImg,
              )),
        ],
      ),
    ));

Widget commonScaffold({context, String title, Widget child, onBack, key}) =>
    Scaffold(
        key: key,
        appBar: appBarCustom(
          context,
          onBack: onBack,
          title: Animator(
            tween: Tween(begin: Offset(-900, 00), end: Offset(00, 00)),
            curve: Curves.bounceIn,
            builder: (anim) => Transform.translate(
              offset: anim.value,
              child: Text(
                title,
                style:
                TextStyle(color: black(), letterSpacing: 1, fontSize: 20),
              ),
            ),
          ),
        ),
        backgroundColor: white(),
//  drawer: AppDrawer(),
        body: SingleChildScrollView(child: child));

const yesd = Text("Yes",
    style: TextStyle(
      color: Colors.white,
    ));
const nod = Text("No",
    style: TextStyle(
      color: Colors.white,
    ));

Widget quizLayout({
  title,
  context,
  ques,
  Widget yes = yesd,
  no = nod,
  onYes,
  onNo,
  row = false,
}) =>
    commonScaffold(
        context: context,
        title: title,
        child: SingleChildScrollView(
          child: Animator(
              tween: Tween(begin: 0.0, end: 1.0),
              curve: Curves.easeInQuart,
              duration: Duration(seconds: 1),
              builder: (anim) => Transform.scale(
                  scale: anim.value,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                ques,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: black(),
                                  fontSize: 20,
                                  letterSpacing: 1,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        row
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: button(context,
                                  title: yes,
                                  onTap: navShift(context, onYes)),
                            ),
                            Expanded(
                              child: button(context,
                                  onTap: navShift(context, onNo),
                                  title: no),
                            )
                          ],
                        )
                            : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            button(context,
                                title: yes,
                                onTap: navShift(context, onYes)),
                            button(context,
                                onTap: navShift(context, onNo), title: no)
                          ],
                        ),
                      ],
                    ),
                  ))),
        ));

animationBody(child) => Animator(
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.easeInQuart,
    duration: Duration(seconds: 1),
    builder: (anim) => Transform.scale(scale: anim.value, child: child));

pop(context) => Navigator.pop(context);

Widget backButton(context) => IconButton(
    icon: Icon(
      Icons.arrow_back,
      color: black(),
    ),
    onPressed: () {
      if (Navigator.of(context).canPop())
        Navigator.of(context).pop();
      else
        Navigator.of(context).pushNamed('/home');
    });
