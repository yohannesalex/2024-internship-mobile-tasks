class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;

  set name(String _name) {
    if (name.isNotEmpty) {
      _name = name;
    }
  }

  String get description => _description;

  set description(String _description) {
    if (description.isNotEmpty) {
      _description = description;
    }
  }

  double get price => _price;

  set price(double price) {
    if (price >= 0) {
      _price = price;
    }
  }

  @override
  String toString() {
    return 'Name: $name, Description: $description, Price: $price';
  }
}
