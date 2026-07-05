import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/order_model.dart';

class OrderRepo {
  final ApiService _apiService = ApiService();
  
   // save order
Future<void> saveOrder(SaveOrderRequest order) async {
  try {
    final res = await _apiService.post(
      "/orders",
      order.toJson(),
    );

    if (res is ApiError) {
      throw ApiError(message: res.message);
    }
  } catch (e) {
    throw ApiError(message: e.toString());
  }
}
  // Get order
  Future<GetOrderResponse?> getOrderDetails() async {
    try {
      final res = await _apiService.Get("/orders");
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      return GetOrderResponse.fromJson(res);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}