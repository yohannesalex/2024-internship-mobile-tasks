import 'package:flutter/material.dart';

import '../widget/card.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final double _value = 50.0;
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
          onPressed: () {},
        ),
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: SingleChildScrollView(
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
                        onPressed: () {},
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
                  height: 20,
                ),
                p.displayCard(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.white,
                        height: 200,
                        child: Column(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("      Category",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 35,
                                  margin:
                                      const EdgeInsets.fromLTRB(22, 0, 15, 0),
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
                                values:
                                    const RangeValues(15, 95), // Initial value
                                min: 10.0, // Minimum value
                                max: 100.0, // Maximum value
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3F51F3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Button shape
                                  ),
                                ),
                                child: const Text(
                                  "APPLY",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                          ),
                        ]),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
