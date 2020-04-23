import 'package:flutter/material.dart';
import 'api/country_api.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:searchable_dropdown/searchable_dropdown.dart';

void main() => runApp( MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData(
        primarySwatch: Colors.red,
      ),
      home:  MyHomePage(title: 'Learning Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text(widget.title),
      ),
      body:Container(
          child:CountryApi()

        
      


        
      ),
    );
  
  }
}

