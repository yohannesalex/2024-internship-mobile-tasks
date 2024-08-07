import 'package:flutter/material.dart';

class AddUpdate extends StatefulWidget {
  const AddUpdate({super.key});

  @override
  State<AddUpdate> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Add Product",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: double.infinity,
              height: 120,
              color: const Color(0xFFF3F3F3),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 40,
                  ),
                  Text("Upload Image")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("name",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF3F3F3),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: false,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "category",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFF3F3F3),
                      ),
                      obscureText: false,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("price",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF3F3F3),
                        border: OutlineInputBorder(),
                        hintText: "\$",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,)

                      ),
                      obscureText: false,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("description",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        filled: false,
                        fillColor: Color(0xFFF3F3F3),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 60.0, horizontal: 10.0)),
                    obscureText: false,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Button shape
                    ),
                  ),
                  child: const Text(
                    "ADD",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      // Button shape
                    ),
                  ),
                  child: const Text(
                    "DELETE",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.red),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
