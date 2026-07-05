abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeSuccess extends HomeState {}

// add to cart

class AddToCartLoading extends HomeState {}

class AddToCartError extends HomeState {
  final String message;
  AddToCartError(this.message);
}

class AddToCartSuccess extends HomeState {}

// get toppings

class GetToppingsLoading extends HomeState {}

class GetToppingsError extends HomeState {
  final String message;
  GetToppingsError(this.message);
}

class GetToppingsSuccess extends HomeState {}

// get side options

class GetSideOptionsLoading extends HomeState {}

class GetSideOptionsError extends HomeState {
  final String message;
  GetSideOptionsError(this.message);
}

class GetSideOptionsSuccess extends HomeState {}