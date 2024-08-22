import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextWidget {
  Column displayTextField(
      String lable, String hint, TextEditingController control) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        lable,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
      const SizedBox(
        height: 3,
      ),
      SizedBox(
        width: 300,
        height: 35,
        child: TextField(
          controller: control,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(
                      255, 90, 1, 1), // Slightly visible border color
                  width: 0.1, // Border width
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 195, 183, 183))),
        ),
      ),
    ]);
  }
}

TextWidget textWidget = TextWidget();
