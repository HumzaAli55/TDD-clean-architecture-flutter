import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_api_practice/core/resources/datastate.dart';
import 'package:mock_api_practice/core/usecase/usecase.dart';
import 'package:mock_api_practice/feature/home/domain/entities/home.dart';
import 'package:mock_api_practice/feature/home/domain/entities/products.dart';
import 'package:mock_api_practice/feature/home/domain/usecases/home.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_events.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvents,HomeState>{
  final CategoriesUseCase _homeUseCase;
  final ProductsUseCase _productsUseCase;

  HomeBloc(this._homeUseCase, this._productsUseCase):super(EmptyState()){
    on<LoadProductCategories>((loadCategories));
  }

  Future<void>loadCategories(HomeEvents events, Emitter emit) async {

    emit(LoadingProductCategories());

   //final dataState = await _homeUseCase.call(params: NoParams());

    final dataState = await Future.wait([_homeUseCase.call(params: NoParams()), _productsUseCase.call(params: NoParams())]);

   if(dataState.any((element) => element is DataError)){
     emit(ErrorLoadingCategories());
   }
    else{
      emit(ProductCategoriesLoaded(productCategories: (categories: dataState.first as DataSuccess<List<CategoriesEntity>>,products:dataState.last as DataSuccess<Products>)));
   }
  }



}