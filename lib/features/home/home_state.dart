part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {
  final List<String>? categories;
  final int? selectedIndex;
  HomeLoading({this.selectedIndex, this.categories});
}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  final List<ProductModel> categories;

  HomeSuccess({required this.products, required this.categories});
}

class HomeFailure extends HomeState {
  final String errMsg;
  HomeFailure(this.errMsg);
}
