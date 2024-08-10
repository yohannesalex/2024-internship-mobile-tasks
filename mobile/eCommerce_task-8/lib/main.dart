import 'package:flutter/material.dart';
import 'pages/add.dart';
import 'pages/detail.dart';
import 'pages/edit.dart';
import 'pages/home.dart';
import 'pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _buildPageRoute(Home());
          case '/details':
            return _buildPageRoute(
                const Detail(
                  productName: '',
                ),
                fromMiddleDown: true);
          case '/search':
            return _buildPageRoute(const Search());
          case '/add':
            return _buildPageRoute(Add());
          case '/edit':
            return _buildPageRoute(Edit());
          default:
            return null;
        }
      },
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page, {bool fromMiddleDown = false}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin =
            fromMiddleDown ? const Offset(0.0, 0.0) : const Offset(1.0, 0.0);
        final end = fromMiddleDown ? const Offset(0.0, 1.0) : Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
