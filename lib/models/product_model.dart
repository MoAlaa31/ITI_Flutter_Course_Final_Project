class ProductModel {
  int? id;
  double? price;
  String? title;
  String? thumbnail;
  String? description;
  int? reviewsCount;
  double? rating;
  List<String>? images;

  ProductModel({
    this.id,
    this.price,
    this.title,
    this.thumbnail,
    this.description,
    this.reviewsCount,
    this.rating,
    this.images,
  });

  // Dummy JSON
  factory ProductModel.fromDummyJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: (json['reviews'] as List<dynamic>?)?.length,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  // Fake Store
  factory ProductModel.fromFakeStore(Map<String, dynamic> json) {
    final ratingJson = json['rating'] as Map<String, dynamic>?;

    return ProductModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      thumbnail: json['image'] as String?,
      description: json['description'] as String?,
      rating: (ratingJson?['rate'] as num?)?.toDouble(),
      reviewsCount: ratingJson?['count'] as int?,
      images: json['image'] != null ? [json['image'] as String] : null,
    );
  }
}
