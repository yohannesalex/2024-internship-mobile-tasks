import 'package:flutter/material.dart';

class DetailItem {
  Column displayDetailCard(name, category, price, description, image) {
    return Column(children: [
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
            width: 500,
            height: 366,
            child: Column(
              children: [
                SizedBox(
                  width: 350,
                  height: 250,
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$category',
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
                    ],
                  ),
                )
              ],
            )),
      ),
    ]);
  }
}

DetailItem detailItem = DetailItem();
