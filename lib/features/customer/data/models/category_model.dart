class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    this.productCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      icon: json['icon'] ?? 'category',
      productCount: json['product_count'] ?? 0,
    );
  }
}