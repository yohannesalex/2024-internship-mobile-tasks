import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      width: 500,
                      height: 320,
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
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.asset(
                                        'Assets/shoes.jpg',
                                      ))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Men's shoes",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w300),
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
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Derby Leather Shoes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                    Text("\$120",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        
                children: [
                  const Text("Size: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("39",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("40",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF3F51F3),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text("41",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("42",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("43",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("44",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text("A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe"),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(onPressed: (){},style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          // Button shape
                        ),

                      ), child: const Text("DELETE", style: TextStyle(color: Colors.red),),),
                      ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F51F3),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            // Button shape
                          ),

                        ), child: const Text("UPDATE", style: TextStyle(color: Colors.white),),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
