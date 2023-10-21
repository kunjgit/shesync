import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shesync/period_tracking/aboutus.dart';
import 'package:shesync/period_tracking/addPeriod.dart';
import 'package:shesync/period_tracking/community.dart';
import 'package:shesync/period_tracking/feedback.dart';
import 'package:shesync/period_tracking/healthtips.dart';
import 'package:shesync/period_tracking/logs.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

FirebaseFirestore fsi = FirebaseFirestore.instance;

const magenta = const Color(0x8e3a59);
int _currentIndex = 1;
int _pageIndex = 1;
DateTime now = DateTime.now();
DateTime firstDayOfPreviousMonth = DateTime(now.year, now.month - 1, 1);
DateTime lastDayOfNextMonth = DateTime(now.year, now.month + 2, 0);

var startDates = [];
var endDates = [];
Map<String, dynamic>? map;
Map<String, dynamic>? selectedDateValue;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCycles(),
    ),
  );
}

class MyCycles extends StatefulWidget {
  _MyCycleState createState() => _MyCycleState();
}

class _MyCycleState extends State<MyCycles> {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController _textFieldController = TextEditingController();
  final List<Widget> _children = [Community(), MyCycles(), AboutUs()];
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  // ignore: non_constant_identifier_names
  _OnTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => _children[_currentIndex]));
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
    _getPeriodData();
  }

  _getPeriodData() async {
    FirebaseFirestore.instance.collection("periodinfo").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        map = result.data();
        selectedDateValue = map?['Selected Date'];
        var temp1 = DateFormat('yyyy-MM-dd').parse(selectedDateValue?['start']);
        startDates.add(temp1);
        var temp2 = DateFormat('yyyy-MM-dd').parse(selectedDateValue?['end']);
        endDates.add(temp2);
        print(startDates);
        print(endDates);
      });
    });
  }

  _getStartDate() {
    if (startDates.isNotEmpty) {
      return startDates[0];
    } else {
      return firstDayOfPreviousMonth; // Provide a default date in case startDates is empty
    }
  }

  _getEndDate() {
    if (endDates.isNotEmpty) {
      return endDates[0];
    } else {
      return lastDayOfNextMonth; // Provide a default date in case endDates is empty
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 100.0,
            width: 80.0,
            child: IconButton(
                icon: Image.asset('assets/logo.png'), onPressed: () => {}),
          ),
        ],
        title: Text(
          "She Sync",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
        ),
        backgroundColor: Colors.pink[900],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: _getStartDate(),
                lastDay: _getEndDate(),
                calendarFormat: CalendarFormat.month,
                headerVisible: true,
                daysOfWeekVisible: true,
                pageAnimationEnabled: true,
                sixWeekMonthsEnforced: false,
                headerStyle: HeaderStyle(),
                daysOfWeekStyle: DaysOfWeekStyle(),
                calendarStyle: CalendarStyle(
                  outsideTextStyle: TextStyle(color: Colors.pink[900]),
                  todayDecoration: BoxDecoration(
                    color: Colors.pink[900],
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pink[900],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pink[900],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Divider(),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(100, 0, 40, 10),
                          child: Text("Add Period",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.pink[900],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPeriod()),
                            );
                          },
                          backgroundColor: Colors.pink[900],
                          child: Icon(Icons.add, color: Colors.pink[100]),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 392,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.pink[900]!),
                            ),
                            onPressed: () {
                              _displayTextInputDialog(context, "Temperature",
                                  "temperature");
                            },
                            child: Text(
                              "BODY TEMPERATURE",
                              style: TextStyle(
                                  color: Colors.pink[200],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 392,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.pink[900]!),
                            ),
                            onPressed: () {
                              _displayTextInputDialog(
                                  context, "Mood", "mood");
                            },
                            child: Text(
                              "MOOD",
                              style: TextStyle(
                                  color: Colors.pink[200],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 392,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.pink[900]!),
                            ),
                            onPressed: () {
                              _displayTextInputDialog(
                                  context, "Weight", "weight");
                            },
                            child: Text(
                              "WEIGHT",
                              style: TextStyle(
                                  color: Colors.pink[200],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink[100],
        selectedItemColor: Colors.pink[900],
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.escalator_warning),
            label: 'community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'About Us',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _OnTap();
        },
        elevation: 5,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors
              .pink[100], //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.fromLTRB(0, 2, 20, 2),
                decoration: BoxDecoration(
                  color: Colors.pink[900],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        iconSize: 100,
                        padding: EdgeInsets.fromLTRB(0.1, 2, 2, 2),
                        icon: Image.asset('assets/logo.png'),
                        onPressed: () => {}),
                    Text(
                      "She Sync",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 40,
                          color: Colors.pink[50]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.pink[900],
                trailing: Icon(
                  Icons.add_box,
                  color: Colors.pink[100],
                  size: 40,
                ),
                title: Text(
                  "Health Tips",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink[100],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HealthTips()));
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.pink[900],
                trailing: Icon(
                  Icons.plumbing,
                  color: Colors.pink[100],
                  size: 40,
                ),
                title: Text(
                  "Medicine",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink[100],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onTap: () {
                  _displayTextInputDialog(context, "Medicine", "medicine");
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.pink[900],
                trailing: Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.pink[100],
                  size: 40,
                ),
                title: Text(
                  "My Logs",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink[100],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Logs()));
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                tileColor: Colors.pink[900],
                trailing: Icon(
                  Icons.email,
                  color: Colors.pink[100],
                  size: 40,
                ),
                title: Text(
                  "Feedback",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink[100],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackForm()),
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 40,
                    ),
                    title: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late String codeDialog;
  late String valueText;

  _displayTextInputDialog(BuildContext context, String heading, String collection_name) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(heading),
          backgroundColor: Colors.pink[50],
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter your " + heading),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[900]!),
              ),
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.pink[50], fontFamily: 'Poppins'),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[900]!),
              ),
              child: Text('SUBMIT',
                  style: TextStyle(
                      color: Colors.pink[50], fontFamily: 'Poppins')),
              onPressed: () {
                DateTime now = DateTime.now();
                String dateValue = formatter.format(now);
                FirebaseFirestore.instance.collection(collection_name).add({
                  "Value": valueText,
                  "Date": dateValue,
                }).then((value) {
                  print(value.id);
                }).catchError((error) => print("Failed to add data: $error"));
                setState(() {
                  codeDialog = valueText;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
