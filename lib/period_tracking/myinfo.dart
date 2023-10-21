
import 'package:flutter/material.dart';
import 'package:shesync/period_tracking/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shesync/period_tracking/aboutus.dart';
import 'package:shesync/period_tracking/addPeriod.dart';
import 'package:shesync/period_tracking/feedback.dart';
import 'package:shesync/period_tracking/community.dart';
import 'package:shesync/period_tracking/healthtips.dart';
import 'package:shesync/period_tracking/logs.dart';


var valueArray = [];
var dateArray = [];
Map<String, dynamic> ?map;
String? value;
String? date;

// ignore: must_be_immutable
class MyInfo extends StatelessWidget {
  String text;
  MyInfo({Key? key, required this.text}) : super(key: key);
  // _getData(String text) async{
  //   return {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          new SizedBox(
            height: 100.0,
            width: 80.0,
            child: new IconButton(
                icon: Image.asset('assets/logo.png'), onPressed: () => {}),
          ),
        ],
        title: Text(
          "My Logs",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
        ),
        backgroundColor: Colors.pink[900],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              stops: [
                0.0,
                0.1,
                0.1,
                0.2,
                0.2,
                0.3,
                0.3,
                0.4,
                0.4,
                0.5,
                0.5,
                0.6,
                0.6,
                0.7,
                0.7,
                0.8,
                0.8,
                0.9,
                0.9,
                1
              ],
              colors: [
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
                Colors.pink[100]!,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Divider(),
              Divider(),
              Text(
                text.toUpperCase(),
                style: TextStyle(
                    color: Colors.pink[900],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 25, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              Divider(),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink[900]!)),
                  onPressed: () {
                    valueArray.clear(); // Clear the arrays before adding new data
                    dateArray.clear();
                    FirebaseFirestore.instance
                        .collection(text)
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        print(result.data());
                        map = result.data();
                        value = map?['Value'];
                        valueArray.add(value);
                        print(valueArray);
                        date = map?['Date'];
                        dateArray.add(date);
                        print(dateArray);
                      });
                    });
                  },
                  child: Text('Get Data',
                      style: TextStyle(color: Colors.pink[50], fontSize: 30, fontFamily: 'Poppins'))),
              Divider(
                thickness: 3,
                color: Colors.pink[900],
              ),
              ListUI(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListUI extends StatefulWidget {
  @override
  _ListUIState createState() => _ListUIState();
}

class _ListUIState extends State<ListUI> {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Add this Expanded widget
      child: ListView(
        shrinkWrap: true, // Added this line
        children: <Widget>[
          for (var i = 0; i < valueArray.length; i++)
            ListTile(
              leading: Icon(
                Icons.fiber_manual_record,
                color: Colors.pink[900],
              ),
              title: Text(
                ' Date: ' + dateArray[i],
                style: TextStyle(
                  color: Colors.pink[900],
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text(
                ' Record: ' + valueArray[i] + ' ',
                style: TextStyle(
                  color: Colors.pink[100],
                  backgroundColor: Colors.pink[900],
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          Divider(
            thickness: 2,
            color: Colors.pink[900]?.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
