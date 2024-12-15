import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/home/domain/entities/home.dart';
import 'package:mock_api_practice/feature/home/domain/entities/products.dart';

abstract class HomeState {}


class EmptyState extends HomeState{}

class ErrorLoadingCategories extends HomeState{}

class LoadingProductCategories extends HomeState {}

class ProductCategoriesLoaded extends HomeState {
  final ({DataSuccess<List<CategoriesEntity>> categories,DataSuccess<Products> products}) productCategories;
  ProductCategoriesLoaded({required this.productCategories});
}