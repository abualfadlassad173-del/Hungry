
// save order
class SaveOrderRequest {
  final List<SaveOrderItemModel> items;

  SaveOrderRequest({required this.items});

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}

class SaveOrderItemModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  SaveOrderItemModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": spicy,
      "toppings": toppings,
      "side_options": sideOptions,
    };
  }
}

// Get order
class GetOrderResponse {
  final int code;
  final String message;
  final List<OrderData> orders;

  GetOrderResponse({
    required this.code,
    required this.message,
    required this.orders,
  });

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) {
    return GetOrderResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? "",
      orders: (json['data'] as List?)
              ?.map((e) => OrderData.fromJson(e))
              .toList() ??
          [],
    );
  }
}
class OrderData {
  final int id;
  final String status;
  final String totalPrice;
  final String created_at;
  final String product_image;

  OrderData({
    required this.id,
    required this.totalPrice,
    required this.status,
    required this.created_at,
    required this.product_image,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] ?? 0,
      totalPrice: json['total_price'].toString(),
      status: json['status'] ?? "",
      created_at: json['created_at'] ?? "2026-06-10",
      product_image: json['product_image'] ?? "",
    );
  }
}