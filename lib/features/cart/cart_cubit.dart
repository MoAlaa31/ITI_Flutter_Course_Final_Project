import 'package:final_project/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<ProductModel>> {
  CartCubit() : super([]);

  void addToCart(ProductModel product) {
    emit([...state, product]);
  }

  void removeFromCart(ProductModel product) {
    emit(state.where((item) => item.id != product.id).toList());
  }
}
