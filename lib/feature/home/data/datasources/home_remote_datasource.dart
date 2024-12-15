
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mock_api_practice/core/constants/api_constant.dart';
import 'package:mock_api_practice/core/http_client/http_interface/i_http_client.dart';
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/feature/home/data/models/home_model.dart';
import 'package:mock_api_practice/feature/home/data/models/products_model.dart';

abstract class HomeRemoteDatasource {
  Future<DataState<List<CategoriesModel>>> getProductCategories();
  Future<DataState<ProductsModel>> getProducts();
}

class HomeRemoteDatasourceImp implements HomeRemoteDatasource {

 final IHttpClient<Response> httpClient;

  HomeRemoteDatasourceImp({required this.httpClient});


  @override
  Future<DataState<List<CategoriesModel>>> getProductCategories() async {
    final response = await httpClient.getRequest(endPoint: ApiConstant.productCategoriesApi);

    if(response.statusCode == 200) {
      //final jsonData = jsonDecode(response.body);
      return DataSuccess(homeModelFromJson(response.body));
    }
    else {
      return DataError(response.reasonPhrase ?? "Api Failed to load with Unknown Reason");
    }
  }

  @override
  Future<DataState<ProductsModel>> getProducts() async {
    final response = await httpClient.getRequest(endPoint: ApiConstant.allProductsApi);

    if(response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return DataSuccess(ProductsModel.fromJson(jsonData));
    }
    else {
      return DataError(response.reasonPhrase ?? "Api Failed to load with Unknown Reason");
    }
  }

}