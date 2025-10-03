class ItemEntity {
  final String id;
  final String title;
  final String image;
  final String description;
  final String category;
  final double price;
  final bool isFavorite;

  ItemEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.category,
    required this.price,
    this.isFavorite = false,
  });

  ItemEntity copyWith({
    String? id,
    String? title,
    String? image,
    String? description,
    String? category,
    double? price,
    bool? isFavorite,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemEntity &&
        other.id == id &&
        other.title == title &&
        other.image == image &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        isFavorite.hashCode;
  }

  @override
  String toString() {
    return 'ItemEntity(id: $id, image: $image, title: $title, category: $category, price: $price, isFavorite: $isFavorite)';
  }
}
