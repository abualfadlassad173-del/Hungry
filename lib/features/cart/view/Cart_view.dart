import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/Guest_view.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/cart/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/cubit/cart_state.dart';
import 'package:hungry/features/cart/view/checkOut_view.dart';
import 'package:hungry/features/cart/data/Cart_item_view.dart';
import 'package:hungry/features/cart/widget/buttom_Check_view.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<CartCubit>();
    cubit.getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubitAuth = context.read<AuthCubit>();
        if (cubitAuth.isGuest == false) {
          return BlocConsumer<CartCubit, CartState>(
            listener: (BuildContext context, state) {
              if (state is RemoveCartError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(customSnackBarerror(state.message));
              }
              if (state is CartError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(customSnackBarerror(state.message));
              }
            },
            builder: (BuildContext context, state) {
              final cubit = context.read<CartCubit>();
              return RefreshIndicator(
                onRefresh: cubit.getCartData,
                child: Skeletonizer(
                  enabled: state is AutoLoginLoading,
                  child: Scaffold(
                    extendBody: true,
                    backgroundColor: Appcolors.surface,
                    appBar: AppBar(
                      backgroundColor: Appcolors.surface,
                      toolbarHeight: 0,
                    ),
                    body:
                        (cubit.cartResponse == null ||
                            cubit.cartResponse!.cartData.items.isEmpty)
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                CustomText(
                                  "Your cart is empty",
                                  style: Textstyle.text16bold,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 54),

                              Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    0,
                                    12,
                                    18,
                                  ),
                                  itemCount:
                                      cubit.cartResponse!.cartData.items.length,
                                  itemBuilder: (context, index) {
                                    final item = cubit
                                        .cartResponse!
                                        .cartData
                                        .items[index];

                                    return CartItemView(
                                      image: item.image,
                                      name: item.name,
                                      description: "Spicy:${item.spicy}",
                                      number: cubit.quantity[index],
                                      onAdd: () => cubit.onAdd(index),
                                      onMun: () => cubit.onMun(index),
                                      onRemove: () =>
                                          cubit.removeCart(item.item_Id),
                                      isLoading:
                                          state is RemoveCartLoading &&
                                          state.itemId == item.item_Id,
                                    );
                                  },
                                ),
                              ),

                              Container(
                                height: 86,
                                margin: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  100,
                                ),
                                decoration: BoxDecoration(
                                  color: Appcolors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Appcolors.black.withValues(
                                        alpha: 0.10,
                                      ),
                                      blurRadius: 24,
                                      offset: const Offset(0, -8),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          "Total",
                                          style: Textstyle.text14bold.copyWith(
                                            color: Appcolors.textSecondary,
                                          ),
                                        ),
                                        CustomText(
                                          "\$ ${cubit.cartResponse?.cartData.TotalPrice ?? "0.00"}",
                                          style: Textstyle.text20bold.copyWith(
                                            color: Appcolors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ButtomCheckView(
                                      text: "Check Out",
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutView(
                                            order: cubit
                                                .cartResponse!
                                                .cartData
                                                .TotalPrice
                                                .toString(),
                                            totalPrice: cubit
                                                .cartResponse!
                                                .cartData
                                                .TotalPrice
                                                .toString(),
                                            productId: cubit
                                                .cartResponse!
                                                .cartData
                                                .items[0]
                                                .product_id,
                                            quantity: cubit
                                                .cartResponse!
                                                .cartData
                                                .items[0]
                                                .quantity,
                                            Options: [],
                                            Topping: [],
                                            Spicy: double.parse(
                                              cubit
                                                  .cartResponse!
                                                  .cartData
                                                  .items[0]
                                                  .spicy,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        }
        return Skeletonizer(
          enabled: State is AutoLoginLoading,
          child: GuestView(),
        );
      },
    );
  }
}
