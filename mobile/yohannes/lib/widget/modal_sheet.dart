import 'package:flutter/material.dart';

class ModalSheet {
  diaplayModal() {
    return Positioned(
      bottom: 0,
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 30, 40, 20),
        color: Colors.white,
        height: 200,
        child: Column(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("      Category",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 35,
              margin: const EdgeInsets.fromLTRB(22, 0, 15, 0),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF3F3F3),
                ),
                obscureText: false,
              ),
            )
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "      Price",
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              RangeSlider(
                values: const RangeValues(15, 95), // Initial value
                min: 10.0, // Minimum value
                max: 100.0, // Maximum value
                onChanged: (value) {},
              ),
              const SizedBox(height: 5),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Button shape
                  ),
                ),
                child: const Text(
                  "APPLY",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }
}

ModalSheet modalSheet = ModalSheet();
