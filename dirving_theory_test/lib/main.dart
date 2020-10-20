import 'package:dirving_theory_test/view/theory_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(DrivingTheoryTest());
}

class DrivingTheoryTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driving Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Driving Test")),
        body: Center(
          child: GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text("THEORY TEST\n\nТЕСТ ПО ТЕОРИИ", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, ),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TheoryTestMenuPage()));
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text("HAZARD PERCEPTION\n\nВОСПРИЯТИЕ ОПАСНОСТИ", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, ),),
                onPressed: () {},
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("HIGHWAY CODE\n\nПРАВИЛА ДОРОЖНОГО ДВИЖЕНИЯ", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, ),),
                onPressed: () {},
              ),
              RaisedButton(
                color: Colors.orange,
                child: Text("ROAD SIGNS\n\nДОРОЖНЫЕ ЗНАКИ", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, ),),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
