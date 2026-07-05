class ProductModel {
  final int id;
  final String name;
  final String nameEn;
  final String description;
  final int price;
  final String imageUrl;
  final String categoryId;
  final bool isNew;
  final bool isSuggested;
  final bool isAvailable;

  const ProductModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isNew = false,
    this.isSuggested = false,
    this.isAvailable = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      categoryId: json['category_id'] ?? '',
      isNew: json['is_new'] == 1 || json['is_new'] == true,
      isSuggested: json['is_suggested'] == 1 || json['is_suggested'] == true,
      isAvailable: json['is_available'] != 0 && json['is_available'] != false,
    );
  }

  String get formattedPrice {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} تومان';
  }
}

class CartItemModel {
  final ProductModel product;
  int quantity;
  String? note;

  CartItemModel({
    required this.product,
    this.quantity = 1,
    this.note,
  });

  int get totalPrice => product.price * quantity;
}