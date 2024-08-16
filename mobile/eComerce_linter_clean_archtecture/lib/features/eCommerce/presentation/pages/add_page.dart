import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class Add extends StatefulWidget {
  const Add({
    super.key,
  });

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Add Product',
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
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('The Product is created Successfully')));
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.pushNamed(context, '/');
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to create a product')));
          }
        },
        child: SingleChildScrollView(
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
                        _pickImage();
                      },
                    ),
                    const Text('Upload Image')
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('name',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(243, 243, 243, 1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
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
                      'category',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(243, 243, 243, 1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('price',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(243, 243, 243, 1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('description',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(243, 243, 243, 1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_image != null && _priceController.text.isNotEmpty) {
                        context.read<ProductBloc>().add(CreateProductEvent(
                            ProductEntity(
                                id: '',
                                name: _nameController.text,
                                description: _descriptionController.text,
                                price: double.tryParse(_priceController.text) ??
                                    0.0,
                                imageUrl: _image!.path)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please fill all fields and upload an image')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F51F3),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Button shape
                      ),
                    ),
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.red),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
