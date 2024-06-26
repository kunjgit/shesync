
import 'package:contactus/contactus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shesync/period_tracking/main.dart';

import 'myinfo.dart';

const magenta = const Color(0x8e3a59);
void main() async {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MyCycles()),
  );
}

class Logs extends StatefulWidget {
  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  // ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();
  }

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
          style: TextStyle(fontFamily: 'Poppins', fontSize: 30, ),
        ),
        backgroundColor: Colors.pink[900],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: new Container(
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
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: AssetImage('assets/logimg.jpg'), fit: BoxFit.cover),
                Divider(),
                Text("My Record: ",
                    style: TextStyle(
                      color: Colors.pink[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,fontFamily: 'Poppins'
                    ),
                    textAlign: TextAlign.center),
                Divider(),
                Material(
                  child: ListTile(
                      tileColor: Colors.pink[900]?.withOpacity(0.7),
                      title: Text("Temperature Records",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3, fontFamily: 'Poppins')),
                      trailing: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyInfo(
                                text: 'temperature',
                              ),
                            )),
                      )),
                ),
                Divider(),
                Material(
                  child: ListTile(
                      tileColor: Colors.pink[900]?.withOpacity(0.7),
                      title: Text(
                        "Mood Records",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3, fontFamily: 'Poppins'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyInfo(
                                text: 'mood',
                              ),
                            )),
                      )),
                ),
                Divider(),
                Material(
                  child: ListTile(
                      tileColor: Colors.pink[900]?.withOpacity(0.7),
                      title: Text("Weight Records",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3, fontFamily: 'Poppins')),
                      trailing: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyInfo(
                                text: 'weight',
                              ),
                            )),
                      )),
                ),
                Divider(),
                Material(
                  child: ListTile(
                      tileColor: Colors.pink[900]?.withOpacity(0.7),
                      title: Text("Medicine Records",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3, fontFamily: 'Poppins')),
                      trailing: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyInfo(
                                text: 'medicine',
                              ),
                            )),
                      )),
                )
              ]),
        ),
      ),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
