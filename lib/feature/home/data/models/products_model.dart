// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

import 'package:mock_api_practice/feature/home/domain/entities/products.dart';

ProductsModel productsFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel extends Products {
  @override
 final List<Product>? products;
 final int? total;
 final int? skip;
 final int? limit;

  const ProductsModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  }):super(products: products);

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product extends ETProduct {
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
 final Dimensions dimensions;
 final String warrantyInformation;
 final String shippingInformation;
 final String availabilityStatus;
 final List<Review> reviews;
 final String returnPolicy;
 final int minimumOrderQuantity;
 final Meta meta;
 final String thumbnail;
 final List<String> images;

  Product({
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
  }) : super(id: id, title: title, description: description, category: category, price: price, discountPercentage: discountPercentage, rating: rating, stock: stock, tags: tags,
      brand: brand, sku: sku, weight: weight, dimensions: dimensions,
      warrantyInformation: warrantyInformation, shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus, reviews: reviews, returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity, meta: meta, thumbnail: thumbnail, images: images);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    price: json["price"]?.toDouble(),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    brand: json["brand"] ?? 'N/A',
    sku: json["sku"],
    weight: json["weight"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    warrantyInformation: json["warrantyInformation"],
    shippingInformation: json["shippingInformation"],
    availabilityStatus: json["availabilityStatus"],
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    returnPolicy: json["returnPolicy"],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    meta: Meta.fromJson(json["meta"]),
    thumbnail: json["thumbnail"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "dimensions": dimensions.toJson(),
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus": availabilityStatus,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "returnPolicy": returnPolicy,
    "minimumOrderQuantity": minimumOrderQuantity,
    "meta": meta.toJson(),
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Dimensions extends ETDimensions {
 @override
  final double width;
 @override
  final double height;
 @override
  final double depth;

  const Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  }) : super(width: width, height: height, depth: depth);

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    width: json["width"]?.toDouble(),
    height: json["height"]?.toDouble(),
    depth: json["depth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "depth": depth,
  };
}

class Meta extends ETMeta {
 final DateTime createdAt;
 final DateTime updatedAt;
 final String barcode;
 final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  }) : super(createdAt: createdAt, updatedAt: updatedAt, barcode: barcode, qrCode: qrCode);

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    barcode: json["barcode"],
    qrCode: json["qrCode"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "barcode": barcode,
    "qrCode": qrCode,
  };
}

class Review extends ETReview {
 final int rating;
 final String comment;
 final DateTime date;
 final String reviewerName;
 final String reviewerEmail;

  const Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  }) : super(rating: rating, comment: comment, date: date, reviewerName: reviewerName, reviewerEmail: reviewerEmail);

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: json["rating"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    reviewerName: json["reviewerName"],
    reviewerEmail: json["reviewerEmail"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "date": date.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
  };
}
