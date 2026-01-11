import 'package:dio/dio.dart';
import 'package:final_project/cores/network/dio_helper.dart';
import 'package:final_project/cores/network/endpoints.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();

  Future<void> getSearchResults(String query) async {
    try {
      emit(SearchLoading());
      final finalQuery = query.trim();
      if (finalQuery.isEmpty) return;

      print(query);
      final Response response = await DioHelper.getRequest(
        endPoint: AppEndPoints.productBase + AppEndPoints.search,
        query: {
          'q': finalQuery,
        },
      );

      final List productsJson = response.data['products'];
      final products = productsJson
          .map((e) => ProductModel.fromDummyJson(e))
          .toList();

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SearchSuccess(products));
      }
    } on DioException catch (e) {
      emit(SearchFailure(e.message ?? "Network error"));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }

}