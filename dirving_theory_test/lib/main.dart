import 'package:dirving_theory_test/view/theory_test_page.dart';
import 'package:flutter/material.dart';

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
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text("Theory Test"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TheoryTestMenuPage()));
                  },
                ),
                color: Colors.teal[100],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text("Hazard Perception"),
                  onPressed: () {},
                ),
                color: Colors.teal[200],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text("Highway code"),
                  onPressed: () {},
                ),
                color: Colors.teal[300],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text("Road signs"),
                  onPressed: () {},
                ),
                color: Colors.teal[400],
              ),
            ],
          ),
        ));
  }
}
