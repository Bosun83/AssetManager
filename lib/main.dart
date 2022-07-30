import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widget/appbar.dart';
import '../widget/body_grouped_listview.dart';
import '../widget/bottom_navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Show Your Vision',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        primaryColor: Colors.white,
        // fontFamily: 'Arial',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarPage(context),
      drawer: Drawer(),
      body: bodyGroupedListView(),
      bottomNavigationBar: bottomPage(),
    );
  }
}