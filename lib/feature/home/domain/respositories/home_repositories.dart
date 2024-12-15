
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/home/domain/entities/home.dart';
import 'package:mock_api_practice/feature/home/domain/entities/products.dart';

abstract class HomeRepository {
  Future<DataState<List<CategoriesEntity>>> categoriesRepository();

  Future<DataState<Products>> productsRepository();
}