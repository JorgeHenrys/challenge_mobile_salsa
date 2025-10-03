import '../../domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.id,
    required super.title,
    required super.image,
    required super.description,
    required super.category,
    required super.price,
    super.isFavorite,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description,
      'category': category,
      'price': price,
      'isFavorite': isFavorite,
    };
  }

  ItemEntity toEntity() {
    return ItemEntity(
      id: id,
      title: title,
      image: image,
      description: description,
      category: category,
      price: price,
      isFavorite: isFavorite,
    );
  }

  factory ItemModel.fromEntity(ItemEntity entity) {
    return ItemModel(
      id: entity.id,
      title: entity.title,
      image: entity.image,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      isFavorite: entity.isFavorite,
    );
  }

  @override
  ItemModel copyWith({
    String? id,
    String? title,
    String? image,
    String? description,
    String? category,
    double? price,
    bool? isFavorite,
  }) {
    return ItemModel(
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
  String toString() {
    return 'ItemModel(id: $id, title: $title, image: $image, description: $description, category: $category, price: $price, isFavorite: $isFavorite)';
  }
}
