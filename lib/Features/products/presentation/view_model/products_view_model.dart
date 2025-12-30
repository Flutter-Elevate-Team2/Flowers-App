
import 'dart:async';

import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flowers_app/Features/products/domain/use_cases/products_usecase.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsViewModel  extends Cubit<ProductsStates>{
 final ProductsUseCase _getProductsUseCase;


 bool isSearchFocused = false;
  String? _categoryId;
  String? _occasionId;
  String? _sort;
  String? _search;


  ProductsViewModel(this._getProductsUseCase ): super(ProductsStates());

    void doIntent(ProductsEvent event) {
      if (event is FetchProductsEvent) {
        _categoryId = event.categoryId;
        _occasionId = event.occasionId;
        _sort = event.sort;
        _search = event.search;

          _getAllProducts( _categoryId ,
              _occasionId ,
              _sort ,
              // _search
              );
      }
    }

  void onSearchFocusChanged(bool focused) {
    emit(state.copyWith(isSearchFocused: focused));
    if (!focused && state.searchText.isNotEmpty) {
      _getAllProducts(_categoryId, _occasionId, state.searchText);
    }
  }

  void onSearchSubmitted(String value) {
    final query = value.trim();
    emit(
      state.copyWith(
        searchText: query,
        productsState: BaseState<List<ProductsEntity>>(isLoading: true),
        isSearchFocused: false,

      ),
    );

    _getAllProducts(_categoryId, _occasionId, query);
  }

  Future<void> _getAllProducts(
      String? categoryId,
      String? occasionId,
       String? sort,
      //String? search
      ) async {
    emit(state.copyWith(productsState: BaseState<List<ProductsEntity>>(isLoading: true)));

    BaseResponse<List<ProductsEntity>> result;

    if (categoryId != null && categoryId.isNotEmpty) {
      result = await _getProductsUseCase.getProducts(categoryId: categoryId, sort: sort);
    } else if (occasionId != null && occasionId.isNotEmpty) {
      result = await _getProductsUseCase.getProducts(occasionId: occasionId, sort: sort);
    } else {
      result = await _getProductsUseCase.getProducts(sort: sort);
    }

    if (isClosed) return;
    if (result is SuccessResponse<List<ProductsEntity>>) {
        emit(
          state.copyWith(
            productsState: BaseState<List<ProductsEntity>>(data: result.data),
          ),
        );
    } else if (result is ErrorResponse<List<ProductsEntity>>) {        emit(
          state.copyWith(
            productsState:BaseState<List<ProductsEntity>>(errorMessage: result.errorMessage),
          ),
        );
    }
  }

}