import 'package:flutter/material.dart';
import 'package:yohannes/pages/detail.dart';
import 'package:yohannes/pages/home.dart';
import 'package:yohannes/pages/search.dart';
import 'package:yohannes/widget/card.dart';
import 'pages/update.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AddUpdate(),
    );
  }
}

