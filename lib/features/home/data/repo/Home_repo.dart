import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';

class HomeRepo {
  HomeRepo({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  // get products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiService.Get("/products/");
      return (response["data"] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // get toppings
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await _apiService.Get("/toppings");
      return (response["data"] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // get SideOptions

  Future<List<ToppingModel>> getSideOptions() async {
    try {
      final response = await _apiService.Get("/side-options");
      return (response["data"] as List)
          .map((option) => ToppingModel.fromJson(option))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //add to cart
  Future<void> addToCart({ required CartRequestModel cartData}) async {
    try {
      await _apiService.post("/cart/add", cartData.toJson());
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
