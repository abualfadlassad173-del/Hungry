import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/order_model.dart';
import 'package:hungry/features/cart/data/order_repo.dart';
import 'package:hungry/features/order/data/cubit/Order_State.dart';

class OrderCubit extends Cubit<OrderState>{
  OrderCubit() : super(OrderInitial());
  List<OrderData>? orders = [];
  OrderRepo orderRepo = OrderRepo();
  //get order
  Future<void> getOrder() async {
    try {
      emit(OrderLoading());
      final res = await orderRepo.getOrderDetails();
      orders = res?.orders ?? [];
      emit(OrderSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(OrderError(e.toString()));
    }
  }
}