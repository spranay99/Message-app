import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_messages_clone/models/message.dart';
import 'utility/HexColor.dart';
import 'OptionMenu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Message> messages = <Message>[];
  List<MaterialColor> myCustomMaterialColors = <MaterialColor>[];
  final random = Random();
  double _width = 56.0;
  bool isExtended = false;
  double appBarElevation = 0;

  @override
  void initState() {
    createSomePredefinedColors();
    createDummyData();
    super.initState();
  }

  // Predefined colors for random selection
  void createSomePredefinedColors() {
    myCustomMaterialColors.add(Colors.yellow);
    myCustomMaterialColors.add(Colors.orange);
    myCustomMaterialColors.add(Colors.purple);
    myCustomMaterialColors.add(Colors.pink);
    myCustomMaterialColors.add(Colors.blue);
  }

  // Dummy Messages
  void createDummyData() {
    messages.add(Message(
        from: "Tejas Trivedi",
        message: "Hey,wassup..!!",
        isRead: false,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Smit Shah",
        message: "Sorry,was busy",
        isRead: false,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Mom",
        message: "Where are you?",
        isRead: false,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "963808326",
        message: "Got it",
        isRead: true,
        isInContactList: false,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Pranay",
        message: "I'll be there",
        isRead: true,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "7854862541",
        message: "2 Missed call",
        isRead: true,
        isInContactList: false,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Karan Sheth",
        message: "Thank you so much ::)",
        isRead: true,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Dad",
        message: "Call me later",
        isRead: true,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "Barabarbaaz",
        message: "Got new earphones..",
        isRead: false,
        isInContactList: true,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
    messages.add(Message(
        from: "8779296718",
        message: "Where were u? Tried calling u..",
        isRead: true,
        isInContactList: false,
        backgroundColor: myCustomMaterialColors[
            random.nextInt(myCustomMaterialColors.length)]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',
            style: TextStyle(
              letterSpacing: -1,
              color: Colors.grey[800],
            )),
        elevation: appBarElevation,
        centerTitle: true,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.search,
                color: Colors.grey[800],
              )),
          Container(
            child: OptionMenu(),
          )
        ],
      ),
      body: Container(
          color: Colors.white,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is UserScrollNotification) {
                switch (scrollNotification.direction) {
                  case ScrollDirection.reverse:
                    _extendFab(true);
                    break;
                  case ScrollDirection.forward:
                    _extendFab(false);
                    break;
                  case ScrollDirection.idle:
                    break;
                }
              }
            },
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: messages[index].backgroundColor.withOpacity(0.3),
                      radius: 23,
                      child: messages[index].isInContactList
                          ? Text(
                              '${messages[index].from.substring(0, 1)}',
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      messages[index].backgroundColor.shade800),
                            )
                          : Icon(
                              Icons.person,
                              size: 30,
                              color: messages[index].backgroundColor.shade800,
                            ),
                    ),
                    title: Text(
                      '${messages[index].from}',
                      style: TextStyle(
                          fontWeight: messages[index].isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: messages[index].isRead ? null : Colors.black),
                    ),
                    subtitle: Text(
                      '${messages[index].message}',
                      style: TextStyle(
                          fontWeight: messages[index].isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: messages[index].isRead ? null : Colors.black),
                    ),
                  );
                }),
          )),
      floatingActionButton: AnimatedContainer(
        height: 56,
        width: _width,
        duration: Duration(milliseconds: 180),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: HexColor("1A73E8"),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: isExtended
                      ? Text(
                          'Start chat',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      : SizedBox.shrink(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _extendFab(bool isExtend) {
    setState(() {
      isExtended = isExtend;
      _width = isExtended ? 135 : 56;
      appBarElevation = isExtend ? 5 : 0;
    });
  }
}





//TODO library match coding standard with pedro
//Different option for color
