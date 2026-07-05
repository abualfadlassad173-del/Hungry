abstract class CartState {}

class CartInitial extends CartState {}

//Get Cart
class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

// Remove From Cart
class RemoveCartLoading extends CartState {
  final int itemId;

  RemoveCartLoading(this.itemId);
}

class RemoveCartSuccess extends CartState {}

class RemoveCartError extends CartState {
  final String message;

  RemoveCartError({required this.message});
}
