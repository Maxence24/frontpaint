import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'player_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: Scaffold(
        appBar: AppBar(title: Text('InfiniColor')),
        body: HomePage(),
      ),
    );
  }
}
/*
class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String serverResponse = 'Server response';

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Send request to server'),
                onPressed: () {
                  _makeGetRequest();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverResponse),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _makeGetRequest() async {
    final url = Uri.parse(_localhost());
    Response response = await get(url);
    setState(() {
      serverResponse = response.body;
    });
  }

  String _localhost() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/bases/639a41502e913ad42408c1ef';
    } else {
      return 'http://localhost:3000';
    }
  }
}*/

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  Color mycolor = Colors.red;
  String serverResponse = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),/*pas encore trouver fonction*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            ElevatedButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            enableAlpha: false,
                            pickerColor: mycolor, //default color
                            onColorChanged: (Color color){ //on color picked
                              setState(() {
                                mycolor = color;
                              });
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Result'),
                            onPressed: () {
                              _makeGetRequest();
                              Navigator.of(context).pop();
                              //dismiss the color picker
                            },
                          ),
                        ],
                      );
                    }
                );
              },
              child: Text("Default Color Picker"),
            ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(serverResponse),
            //child: Text('Ma couleur', style : TextStyle(color: mycolor)
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomSection(),
    );
  }
  _makeGetRequest() async {
    final url = Uri.parse(_localhost());
    Response response = await get(url);
    setState(() {
      serverResponse = response.body;
    });
  }
  String _localhost() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3010/bases/color/'+ mycolor.toString().substring(10,16);
    } else {
      return 'http://localhost:3010';
    }
  }
}

//Pas encore de fonction trouver
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 23,
          ),
          onPressed: null,
        )
      ],
      backgroundColor: Colors.white.withOpacity(0),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: AssetImage('assets/images/magnus.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 30,
            child: Text(
              'InfiniColor',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 43,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pause,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text(
            "Imagine . Ariana Grande",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.arrow_circle_up,
            color: Colors.white,
          ),
          label: '',
        ),
      ],
    );
  }
}
