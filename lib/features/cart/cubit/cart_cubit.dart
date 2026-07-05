import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/cubit/cart_state.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<int> quantity = [];
  GetcardResponse? cartResponse;
  CartRepo cartRepo = CartRepo();

  // Get Cart

  Future<void> getCartData() async {
    try {
      emit(CartLoading());
      final res = await cartRepo.GetCartData();
      cartResponse = res;
      quantity = List.generate(res!.cartData.items.length, (_) => 1);
      emit(CartSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(CartError(message: errorMessage));
    }
  }

  // Remove Cart

  Future<void> removeCart(int itemId) async {
    try {
      emit(RemoveCartLoading(itemId));
      await cartRepo.removeFromCart(itemId);
      await getCartData();
      emit(RemoveCartSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(RemoveCartError(message: errorMessage));
    }
  }

  // Add quantity
  void onAdd(int index) {
    quantity[index]++;
    emit(CartSuccess());
  }

  // mun quantity
  void onMun(int index) {
    if (quantity[index] > 1) {
      quantity[index]--;
    }
    emit(CartSuccess());
  }
}
