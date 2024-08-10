class Product {
  final String _name;
  final String _category;
  final String _description;
  String _price;

  Product(
    this._name,
    this._category,
    this._price,
    this._description,
  );

  String get name => _name;

  set name(String name) {
    if (name.isNotEmpty) {
      name = name;
    }
  }

  String get category => _category;

  set category(String category) {
    if (category.isNotEmpty) {
      category = category;
    }
  }

  String get description => _description;

  set description(String description) {
    if (description.isNotEmpty) {
      description = description;
    }
  }

  String get price => _price;

  set price(String price) {
    if (price.isNotEmpty) {
      _price = price;
    }
  }

  @override
  String toString() {
    return 'Name: $name, Category: $category Description: $description, Price: $price';
  }
}
