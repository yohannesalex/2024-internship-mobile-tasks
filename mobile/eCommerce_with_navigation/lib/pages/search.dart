import 'package:flutter/material.dart';

import '../model/product_manager.dart';
import '../widget/card.dart';
import '../widget/modal_sheet.dart';
import 'detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void showModal(BuildContext context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (BuildContext context) {
          return modalSheet.diaplayModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Search Product",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins'),
        )),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.blue,
            size: 18,
            weight: 100,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 300,
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -6,
                        right: 0,
                        bottom: 5,
                        child: IconButton(
                          onPressed: () {},
                          color: Color(0xFF3F51F3),
                          icon: const Icon(Icons.arrow_forward_sharp),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F51F3),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModal(context);
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
                            productName: cart[key]?.name ?? 'Unknown Product'),
                      ),
                    );
                  },
                );
              },
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
