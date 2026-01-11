part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState{}
class SearchLoading extends SearchState{}
class SearchSuccess extends SearchState{
  final List<ProductModel> model;
  SearchSuccess(this.model);
}

class SearchFailure extends SearchState{
  final String errMsg;
  SearchFailure(this.errMsg);
}