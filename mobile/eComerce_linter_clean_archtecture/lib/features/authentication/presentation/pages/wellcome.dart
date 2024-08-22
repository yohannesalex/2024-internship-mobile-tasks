import 'dart:async';

import 'package:flutter/material.dart';

class Wellcome extends StatefulWidget {
  const Wellcome({super.key});

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 5 seconds
    Timer(const Duration(seconds: 5), () {
      // Navigate to the LoginPage after 5 seconds
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/photo.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF3F51F3).withOpacity(1.0), // Full opacity
                    Color(0xFF3F51F3).withOpacity(0.5), // 50% opacity
                  ],
                ),
              ),
            ),
          ),
          // Center the Column within the screen
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'ECOM',
                    style: TextStyle(
                      fontFamily: 'CaveatBrush', // Specify the font family
                      fontSize: 100.89, // Font size
                      fontWeight: FontWeight.w400, // Font weight
                      color: Color.fromARGB(255, 59, 86, 243), // Text color
                      height: 117.41 /
                          100.89, // Line height (multiplier of font size)
                      letterSpacing:
                          0.02 * 100.89, // Letter spacing (converted to px)
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Adds space between texts
                const Text(
                  "ECOMERCE APP",
                  style: TextStyle(
                    fontSize: 24, // Example font size for the subtitle
                    color: Colors.white, // Example color for the subtitle
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
