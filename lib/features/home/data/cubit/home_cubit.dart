import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/home/data/cubit/home_state.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/features/home/data/repo/Home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  TextEditingController searchController = TextEditingController();
  HomeRepo homeRepo = HomeRepo();
  List<ProductModel>? products;
  List<ProductModel>? allproducts;
  List<ToppingModel>? Toppings;
  List<ToppingModel>? SideOptions;

  //get products
  Future getProducts() async {
    emit(HomeLoading());
    try {
      products = await homeRepo.getProducts();
      allproducts = products;
      emit(HomeSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(HomeError(errorMessage));
    }
  }

  //add to cart
  Future addToCart({required CartRequestModel cartData}) async {
    emit(AddToCartLoading());
    try {
      await homeRepo.addToCart(cartData: cartData);
      emit(AddToCartSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(AddToCartError(errorMessage));
    }
  }

  // get toppings
  Future getToppings() async {
    emit(GetToppingsLoading());
    try {
      Toppings = await homeRepo.getToppings();
      emit(GetToppingsSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(GetToppingsError(errorMessage));
    }
  }

   // get side options
  Future getSideOptions() async {
    emit(GetSideOptionsLoading());
    try {
      SideOptions = await homeRepo.getSideOptions();
      emit(GetSideOptionsSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(GetSideOptionsError(errorMessage));
    }
  }
}
