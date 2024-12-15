import 'package:equatable/equatable.dart';

// Products Entity (Domain Layer)
class Products extends Equatable {
  final List<ETProduct>? products;

  const Products({
    required this.products,
  });

  @override
  List<Object?> get props => [products];
}

class ETProduct extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final ETDimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ETReview> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final ETMeta meta;
  final String thumbnail;
  final List<String> images;

  const ETProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.thumbnail,
    required this.images,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    sku,
    weight,
    dimensions,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    reviews,
    returnPolicy,
    minimumOrderQuantity,
    meta,
    thumbnail,
    images,
  ];
}

class ETDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;

  const ETDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  @override
  List<Object?> get props => [width, height, depth];
}

class ETMeta extends Equatable {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  const ETMeta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];
}

class ETReview extends Equatable {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  const ETReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  @override
  List<Object?> get props => [rating, comment, date, reviewerName, reviewerEmail];
}