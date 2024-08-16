import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widget/detail_card.dart';
import '../widget/size.dart';
import 'edit_page.dart';

class Detail extends StatelessWidget {
  final ProductEntity product;

  const Detail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The Product is deleted')));
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.pushNamed(context, '/');
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to delete the product')));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                detailItem.displayDetailCard(product.name, 'Category',
                    product.price, product.description, product.imageUrl),
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
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(product.description)),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(DeleteProductEvent(product.id));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
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
                                id: product.id,
                                editName: product.name,
                                editCategory: 'Category',
                                editPrice: product.price.toString(),
                                editDescription: product.description,
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
    ));
  }
}
