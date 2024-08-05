import 'dart:io';

import 'Product-manager.dart';

void main() {
  Product_manager manager = Product_manager();
  print("=========wellcome to ecomerce command application========");
  var flag = true;
  while (flag == true) {
    print("1. Add New Product");
    print("2. View Products");
    print("3. View Single Product");
    print("4. Edit Product");
    print("5. Delete Product");
    print("0. To exit");
    var num = stdin.readLineSync();
    int? choice = int.tryParse(num ?? '');
    switch (choice) {
      case 1:
        print("Enter the product name:  ");
        String? name = stdin.readLineSync();
        if (name == "") {
          print("you cant name a product empty!");
          break;
        }
        print("Enter the description of the product:  ");
        String? description = stdin.readLineSync();
        print("Enter the price of the product:  ");
        var value = stdin.readLineSync() ?? "";

        if (double.tryParse(value) == null) {
          print("invalid price format");
          break;
        }

        manager.addProduct(name!, description!, double.parse(value));
      case 2:
        manager.viewAllProduct();
      case 3:
        print("Enter the product name:  ");
        String? name = stdin.readLineSync();
        if (name == "") {
          print("you cant name a product empty!");
          break;
        }
        manager.viewSingleProduct(name!);
      case 4:
        print("Enter the product name you want to edit:  ");
        String? name = stdin.readLineSync();
        if (name == "") {
          print("There is no product with the empty name!");
          break;
        }
        print("Enter the new name of the product:  ");
        String? newName = stdin.readLineSync();
        print("Enter the new description of the product:  ");
        String? newDescription = stdin.readLineSync();
        print("Enter the new price of the product:  ");
        var value = stdin.readLineSync() ?? "";
        if (double.tryParse(value) == null) {
          print("invalid price format");
          break;
        }
        manager.editProduct(
            name!, newName!, newDescription!, double.parse(value));

      case 5:
        print("Enter the name of the product you want to delete:  ");
        String? name = stdin.readLineSync();
        manager.deleteProdudct(name!);
      case 0:
        flag = false;
    }
  }
}
