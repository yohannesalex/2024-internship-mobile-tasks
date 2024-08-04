import 'Product.dart';

class Product_manager {
  Map<String, Product> cart = {};
  void addProduct(String name, String description, double price) {
    Product product = Product(name, description, price);
    cart[name] = (product);
  }

  void viewAllProduct() {
    if (cart.isEmpty) {
      print("No product is avaliable");
    } else {
      cart.forEach((key, product) {
        print(product);
      });
    }
    print("listing Done!");
  }

  void viewSingleProduct(String name) {
    if (cart.containsKey(name)) {
      print(cart[name]);
      print("product desplayed");
    } else {
      print("No product is avaliable with this name");
    }
  }

  void editProduct(
      String name, String newName, String newDescription, double newPrice) {
    if (!cart.containsKey(name)) {
      print("product with the this nmae is does not exixt");
    } else {
      cart[name]!.name = newName;
      cart[name]!.description = newDescription;
      cart[name]!.price = newPrice;
      Product cur = cart.remove(name)!;
      cart[newName] = cur;
    }
    print("Product edited");
  }

  void deleteProdudct(String name) {
    if (cart.containsKey(name)) {
      cart.remove(name);
      print("Product with the name ${name} is deleted");
    } else {
      print("Product with this name is not found");
    }
  }
}
