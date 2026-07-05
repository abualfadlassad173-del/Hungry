// sent to backend
class CartModel {
  final int productid;
  final double Spicy;
  final List<int> Toppings;
  final List<int> sideOptions;
  final int quantity;

  CartModel({
    required this.productid,
    required this.Spicy,
    required this.Toppings,
    required this.sideOptions,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productid,
      "quantity": quantity,
      "spicy": Spicy,
      "toppings": Toppings,
      "side_options": sideOptions,
    };
  }
}

class CartRequestModel {
  final List<CartModel> items;
  CartRequestModel({required this.items});
  Map<String, dynamic> toJson() {
    return {"items": items.map((item) => item.toJson()).toList()};
  }
}

// get from backend

class GetcardResponse {
  final int code;
  final String message;
  final CartData cartData;

  GetcardResponse({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory GetcardResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] == null) {
      throw Exception("Cart data is null from server");
    }
    return GetcardResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? "",
      cartData: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final int id;
  final String TotalPrice;
  final List<CartItemModel> items;

  CartData({required this.items, required this.id, required this.TotalPrice});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'] ?? 0,
      TotalPrice: json['total_price'] ?? "",
      items: json['items'] != null
          ? List<CartItemModel>.from(
              json['items'].map((items) => CartItemModel.fromJson(items)),
            )
          : [],
    );
  }
}

class CartItemModel {
  final int item_Id;
  final int product_id;
  final String name;
  final String image;
  final int quantity;
  final String price;
  final String spicy;
  final List<Topping> topping;
  final List<SideOption> sideOption;

  CartItemModel({
    required this.item_Id,
    required this.product_id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.topping,
    required this.sideOption,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      item_Id: json['item_id'] ?? 0,
      product_id: json['product_id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      quantity: json['quantity'] ?? 1,
      price: json['price'] ?? "0.0",
      spicy: (json['spicy'] ?? "0.0").toString(),
      topping:
          (json['toppings'] as List?)
              ?.map((e) => Topping.fromJson(e))
              .toList() ??
          [],

      sideOption:
          (json['side_options'] as List?)
              ?.map((e) => SideOption.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Topping {
  final int id;
  final String name;
  final String image;

  Topping({required this.id, required this.name, required this.image});

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
    );
  }
}

class SideOption {
  final int id;
  final String name;
  final String image;

  SideOption({required this.id, required this.name, required this.image});

  factory SideOption.fromJson(Map<String, dynamic> json) {
    return SideOption(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
