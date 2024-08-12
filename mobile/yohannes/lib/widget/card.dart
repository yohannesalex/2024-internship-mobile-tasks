import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardShoes {
  displayCard(name, category, price, description) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
          width: 366,
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 280 / 160,
                child: Container(
                  width: 366,
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      // Scale the image to fit the width
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'Assets/shoes.jpg',
                          ))),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Row(children: [
                          Text(
                            "\$",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text("$price",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                        ])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$category",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Text("  (4.5)")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

CardShoes cardHome = CardShoes();
