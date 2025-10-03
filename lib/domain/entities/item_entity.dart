class ItemEntity {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  ItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  ItemEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
