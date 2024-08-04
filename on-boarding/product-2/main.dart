import 'Product-manager.dart';

void main() {
  Product_manager manager = Product_manager();
  manager.addProduct('pen', "for writing", 7);
  manager.addProduct('book', 'for taking notes', 12);
  manager.addProduct('pc', 'hp envy', 800000);
  manager.viewAllProduct();
  manager.viewSingleProduct("pc");
  manager.viewSingleProduct("");
  manager.editProduct('pc', 'laptop', 'macbook', 100000);
  manager.viewAllProduct();
  manager.deleteProdudct("pen");
  manager.viewAllProduct();
}
