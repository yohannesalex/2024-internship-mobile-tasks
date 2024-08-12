import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yohannes/pages/detail.dart';
import '../widget/card.dart';
import '../model/product_manager.dart';

class Home extends StatelessWidget {
  final String _date = DateFormat('MMMM d, yyyy').format(DateTime.now());
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _date,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Row(
                          children: [
                            Text("Hello,  "),
                            Text(
                              "Yohannes",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(Icons.notifications_on_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Available Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/search");
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  String key = cart.keys.elementAt(index);

                  return GestureDetector(
                    child: cardHome.displayCard(
                      cart[key]?.name,
                      cart[key]?.category,
                      cart[key]?.price,
                      cart[key]?.description,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                              productName:
                                  cart[key]?.name ?? 'Unknown Product'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        backgroundColor: const Color(0xFF3F51F3),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
