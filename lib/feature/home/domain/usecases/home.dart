import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/core/usecase/usecase.dart';
import 'package:mock_api_practice/feature/home/domain/entities/home.dart';
import 'package:mock_api_practice/feature/home/domain/entities/products.dart';
import 'package:mock_api_practice/feature/home/domain/respositories/home_repositories.dart';

class CategoriesUseCase implements UseCase<DataState<List<CategoriesEntity>>,NoParams>{
 final HomeRepository repository;

  CategoriesUseCase({required this.repository});

  @override
  Future<DataState<List<CategoriesEntity>>> call({required NoParams params}) async => await repository.categoriesRepository();
}


class ProductsUseCase implements UseCase<DataState<Products>,NoParams>{
 final HomeRepository repository;

 ProductsUseCase({required this.repository});

 @override
 Future<DataState<Products>> call({required NoParams params}) async => await repository.productsRepository();
}