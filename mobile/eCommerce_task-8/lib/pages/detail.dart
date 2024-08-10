import 'package:flutter/material.dart';

import '../model/product_manager.dart';
import '../widget/detail_card.dart';
import '../widget/size.dart';
import 'edit.dart';

class Detail extends StatelessWidget {
  final String productName;

  const Detail({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                detailItem.displayDetailCard(
                    productName,
                    cart[productName]?.category,
                    cart[productName]?.price,
                    cart[productName]?.description),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                  const Text('Size: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      shoeSize.displaySize(39),
                      shoeSize.displaySize(40),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF3F51F3),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Text('41',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      shoeSize.displaySize(42),
                      shoeSize.displaySize(43),
                      shoeSize.displaySize(44)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('${cart[productName]?.description}'),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                          cartManager.deleteProdudct(productName);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            // Button shape
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Edit(
                                editName: cart[productName]!.name,
                                editCategory: cart[productName]!.category,
                                editPrice: cart[productName]!.price,
                                editDescription: cart[productName]!.description,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F51F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            // Button shape
                          ),
                        ),
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
