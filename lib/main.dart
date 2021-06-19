import 'package:flutter/material.dart';
import './screens/homeScreen.dart';

void main() => runApp(BookMyMovieApp());

class BookMyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Book My Movie",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xffff0000),
        primarySwatch: (Colors.red),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}