import 'package:flutter/material.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/widgets/Appbar_back.dart';
import 'package:hungry/core/widgets/visa_view.dart';
import 'package:hungry/features/cart/data/checkOut_detils_view.dart';
import 'package:hungry/features/cart/data/order_model.dart';
import 'package:hungry/features/cart/data/order_repo.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/cart/widget/buttom_Check_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snack.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.order,
    required this.totalPrice,
    required this.productId,
    required this.quantity,
    required this.Options,
    required this.Topping,
    required this.Spicy,
  });
  final String order;
  final String totalPrice;
  final int productId;
  final double Spicy;
  final int quantity;
  final List<int> Options;
  final List<int> Topping;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView>
    with AutomaticKeepAliveClientMixin {
  bool _firstTime = true;
  UserModel? userModel;
  bool isLoading = true;
  AuthRepo authRepo = AuthRepo();
  OrderRepo orderRepo = OrderRepo();
  String selectedPaymentMethod = "Cash";
  //Save order
  Future<void> saveOrder() async {
    try {
      if (!mounted) return;
      await orderRepo.saveOrder(
        SaveOrderRequest(
          items: [
            SaveOrderItemModel(
              productId: widget.productId,
              quantity: widget.quantity,
              spicy: widget.Spicy,
              toppings: widget.Topping,
              sideOptions: widget.Options,
            ),
          ],
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBarSuccess("Order saved successfully"));
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// get profile data
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      String errorMsg = e.toString();

      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: CustomText(errorMsg)));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void initState() {
    if (_firstTime) {
      _firstTime = false;
      getProfileData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Appcolors.grey,
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("   Total", style: Textstyle.text14bold),
                    SizedBox(height: 5),
                    CustomText(
                      "💲 ${(double.parse(widget.totalPrice) + 1.8).toStringAsFixed(2)}",
                      style: Textstyle.text20bold,
                    ),
                  ],
                ),
                ButtomCheckView(
                  text: "Pay Now",
                  onTap: () {
                    saveOrder();
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Appcolors.background,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(height: 20),
                                CustomText(
                                  "Success !",
                                  style: Textstyle.text30bold.copyWith(
                                    color: Appcolors.background,
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomText(
                                  "Your payment was successful.       A receipt for this purchase has been sent to your email.",
                                  textAlign: TextAlign.center,
                                  style: Textstyle.text14bold.copyWith(
                                    color: Appcolors.grey,
                                  ),
                                ),
                                SizedBox(height: 24),
                                ButtomCheckView(
                                  text: "Close",
                                  onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Root(),
                                    ),
                                    (_) => false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(),
          ],
        ),
      ),
      backgroundColor: Appcolors.white,
      appBar: AppbarBack(
        background: Appcolors.white,
        onTap: () => Navigator.pop(context),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                CustomText("Order Summary", style: Textstyle.text18bold),
                SizedBox(height: 10),
                CheckoutDetilsView(
                  order: "\$ ${widget.order}",
                  taxes: '\$ 0.3',
                  deliveryFees: '\$ 1.5',
                  totalPrice: (double.parse(widget.totalPrice) + 1.8)
                      .toStringAsFixed(2),
                ),
                SizedBox(height: 40),
                CustomText("Payment method", style: Textstyle.text18bold),
                SizedBox(height: 10),
                ListTile(
                  tileColor: Color(0xFF3C2F2F),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Image.asset("assets/image/cash.png"),
                  title: CustomText(
                    "Cash on Delivery",
                    style: Textstyle.text16bold.copyWith(
                      color: Appcolors.white,
                    ),
                  ),
                  trailing: Radio<String>(
                    activeColor: Appcolors.white,
                    value: "Cash",
                    groupValue: selectedPaymentMethod,
                    onChanged: (v) =>
                        setState(() => selectedPaymentMethod = v!),
                  ),
                  onTap: () => setState(() => selectedPaymentMethod = "Cash"),
                ),

                SizedBox(height: 20),
                userModel?.visa != null
                    ? VisaView(
                        numberVisa: userModel!.visa.toString(),
                        onTap: () =>
                            setState(() => selectedPaymentMethod = "Visa"),
                        groupValue: selectedPaymentMethod,
                        onChanged: (v) =>
                            setState(() => selectedPaymentMethod = v!),
                        ActiveVisa: true,
                        creditCard: true,
                      )
                    : SizedBox.shrink(),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (v) {},
                      activeColor: Color(0xFFEF2A39),
                    ),
                    CustomText(
                      "Save card details for future payments",
                      style: Textstyle.text14bold.copyWith(
                        color: Appcolors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
