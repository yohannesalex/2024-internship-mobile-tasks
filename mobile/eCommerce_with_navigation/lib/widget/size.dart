import 'package:flutter/material.dart';
class Size{
  displaySize(int num){
    return Container(

    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:  Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03), // Shadow color with opacity
          spreadRadius: 0.5,  // Spread radius
          blurRadius: 1,    // Blur radius
          offset: const Offset(0, 4), // Offset in x and y directions
        ),
      ],
    ),
    child:  Text("$num",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    );
  }
}
Size shoeSize = Size();