// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import '../model/product_manager.dart';

class Edit extends StatelessWidget {
  final String editName;
  final String editCategory;
  final String editPrice;
  final String editDescription;

  final TextEditingController _nameController;
  final TextEditingController _categoryController;
  final TextEditingController _priceController;
  final TextEditingController _descriptionController;
  final String orgionalName;
  Edit({
    super.key,
    this.editName = '',
    this.editCategory = '',
    this.editPrice = '',
    this.editDescription = '',
  })  : _nameController = TextEditingController(text: editName),
        _categoryController = TextEditingController(text: editCategory),
        _priceController = TextEditingController(text: editPrice),
        _descriptionController = TextEditingController(text: editDescription),
        orgionalName = editName;

  // File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Focus.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            onPressed: () {
              Navigator.pop(context);
            },
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 40,
                      ),
                      onPressed: () {
                        // _pickImage();
                      },
                    ),
                    const Text("Upload Image")
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            )),
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
                    onPressed: () {
                      print("the orginal name is $orgionalName");
                      Navigator.pushNamed(context, '/');

                      cartManager.editProduct(
                          orgionalName,
                          _nameController.text,
                          _categoryController.text,
                          _descriptionController.text,
                          _priceController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F51F3),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Button shape
                      ),
                    ),
                    child: const Text(
                      "EDIT",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
