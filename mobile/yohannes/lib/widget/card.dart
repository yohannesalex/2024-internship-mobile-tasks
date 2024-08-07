import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardShoes {
  displayCard() {
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
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Derby Leather Shoes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text("\$120",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Men's shoes",
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

CardShoes p = CardShoes();
