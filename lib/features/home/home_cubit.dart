import 'package:dio/dio.dart';
import 'package:final_project/cores/network/dio_helper.dart';
import 'package:final_project/cores/network/endpoints.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class ApiResult<T> {
  final T data;
  final int statusCode;

  ApiResult({
    required this.data,
    required this.statusCode,
  });
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());

      final dummyProducts = await _getDummyProducts();
      final fakeProducts = await _getFakeStoreProducts();

      if ((dummyProducts.statusCode == 200 ||
          dummyProducts.statusCode == 201) &&
          (fakeProducts.statusCode == 200 ||
              fakeProducts.statusCode == 201)) {
        emit(
          HomeSuccess(
            products: dummyProducts.data,
            categories: fakeProducts.data,
          ),
        );
      }
    } on DioException catch (e) {
      print(e.message);
      emit(HomeFailure("Failed to load home data"));
    }
  }

  Future<ApiResult<List<ProductModel>>> _getDummyProducts() async {
    final response = await DioHelper.getRequest(
      endPoint: AppEndPoints.productBase + AppEndPoints.products,
    );

    final List productsJson = response.data['products'];
    final products = productsJson
        .map((e) => ProductModel.fromDummyJson(e))
        .toList();

    return ApiResult(
      data: products,
      statusCode: response.statusCode ?? 0,
    );
  }

  Future<ApiResult<List<ProductModel>>> _getFakeStoreProducts() async {
    final response = await DioHelper.getRequest(
      endPoint: AppEndPoints.registerBase + AppEndPoints.products,
    );

    final products = (response.data as List)
        .map((e) => ProductModel.fromFakeStore(e))
        .toList();

    return ApiResult(
      data: products,
      statusCode: response.statusCode ?? 0,
    );
  }

}