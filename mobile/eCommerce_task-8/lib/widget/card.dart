import 'package:flutter/material.dart';

class CardShoes {
  Card displayCard(name, category, price, description) {
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
                child: SizedBox(
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
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$name',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Row(children: [
                          const Text(
                            '\$',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text('$price',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                        ])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$category',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            Text('  (4.5)')
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
