import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/Guest_view.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/order/data/cubit/Order_State.dart';
import 'package:hungry/features/order/data/cubit/Order_cubit.dart';
import 'package:hungry/features/order/data/order_item_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with AutomaticKeepAliveClientMixin {
  bool _firstTime = true;

  @override
  void initState() {
    if (_firstTime) {
      _firstTime = false;
      final cubit = context.read<OrderCubit>();
      cubit.getOrder();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, State) {
        final cubitAuth = context.read<AuthCubit>();
        if (cubitAuth.isGuest == false) {
          return BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final cubit = context.read<OrderCubit>();
              return RefreshIndicator(
                onRefresh: cubit.getOrder,
                child: Skeletonizer(
                  enabled: state is OrderLoading,
                  child: Scaffold(
                    backgroundColor: Appcolors.surface,
                    body: (cubit.orders!.isEmpty || cubit.orders == null)
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                CustomText(
                                  "Your Order is empty",
                                  style: Textstyle.text16bold,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 60),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Orders",
                                  style: TextStyle(
                                    color: Appcolors.textDark,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              cubit.orders?.isEmpty ?? false
                                  ? const Center(child: Text("No orders found"))
                                  : Expanded(
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          10,
                                          16,
                                          120,
                                        ),
                                        itemCount: cubit.orders!.length,
                                        itemBuilder: (context, index) {
                                          final order = cubit.orders![index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 7,
                                            ),
                                            child: OrderItemView(
                                              orderImage: order.product_image,
                                              orderCreatedAt: order.created_at
                                                  .substring(0, 10),
                                              orderStatus: order.status,
                                              orderTotalPrice: order.totalPrice
                                                  .toString(),
                                            ),
                                          );
                                        },
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
          enabled: State is OrderLoading,
          child: GuestView(
            title: "Order",
            description: "Login to view your orders",
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
