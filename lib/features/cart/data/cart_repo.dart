import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();

  //get cart
  Future<GetcardResponse?> GetCartData() async {
    try {
      final res = await _apiService.Get("/cart");
      print(res);
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      if (res == null) {
        return null;
      }
      return GetcardResponse.fromJson(res);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //remove from cart
  Future<void> removeFromCart(int itemId) async {
    try {
      final res = await _apiService.delete("/cart/remove/$itemId", {});
      if (res["code"] != 200 && res["data"] == null) {
        throw ApiError(message: "Remove Item From Cart : ${res["message"]}");
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
