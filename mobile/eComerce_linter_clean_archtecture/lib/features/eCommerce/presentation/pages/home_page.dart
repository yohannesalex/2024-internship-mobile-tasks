import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/product_bloc.dart';
import '../widget/card.dart';
import 'details_page.dart';

class Home extends StatelessWidget {
  final String _date = DateFormat('MMMM d, yyyy').format(DateTime.now());
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              'https://wallpapers.com/images/hd/messi-pictures-jzykf84saw6wbkd6.jpg',
              width: 45,
              height: 55,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                _date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Row(
              children: [
                Text(
                  'Hello, ',
                  style: TextStyle(color: Colors.black45, fontSize: 15),
                ),
                Text(
                  'Yohannes',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                )
              ],
            )
          ],
        ),
        actions: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                  onTap: () {},
                  splashColor: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                      const Icon(Icons.notifications_none_rounded),
                      Positioned(
                          top: 3,
                          right: 5,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 63, 81, 243)),
                          ))
                    ]),
                  ))),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Products',
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
                      context.read<ProductBloc>().add(LoadAllProductEvent());
                      Navigator.pushNamed(context, '/search');
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: Text('No product'));
            } else if (state is LoadedAllProductState) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: cardHome.displayCard(
                          state.productList[index].name,
                          'category',
                          state.productList[index].price,
                          state.productList[index].description,
                          state.productList[index].imageUrl),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(product: state.productList[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is ErrorState) {
              return const Center(
                child: Text('The products can not be loaded'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: const Color(0xFF3F51F3),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
