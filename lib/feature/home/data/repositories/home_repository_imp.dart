import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/home/data/datasources/home_remote_datasource.dart';
import 'package:mock_api_practice/feature/home/domain/entities/home.dart';
import 'package:mock_api_practice/feature/home/domain/entities/products.dart';
import 'package:mock_api_practice/feature/home/domain/respositories/home_repositories.dart';

class HomeRepositoryImp extends HomeRepository {

 final HomeRemoteDatasource _homeRemoteDatasource;

  HomeRepositoryImp({required HomeRemoteDatasource homeRemoteDatasource}) : _homeRemoteDatasource = homeRemoteDatasource;

  @override
  Future<DataState<List<CategoriesEntity>>> categoriesRepository() async {
    try {
      return await _homeRemoteDatasource.getProductCategories();
    }catch (e){
      return const DataError("Something went wrong");
    }
  }

  @override
  Future<DataState<Products>> productsRepository() async {
    try{
      return await _homeRemoteDatasource.getProducts();
    }catch(e) {
      return const DataError("Something went wrong");
    }
  }

}