import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/home/data/cubit/home_cubit.dart';
import 'package:hungry/features/home/data/cubit/home_state.dart';
import 'package:hungry/features/home/widget/Home_Appbar_View.dart';
import 'package:hungry/features/home/data/Search_Items_View.dart';
import 'package:hungry/features/home/data/items_view.dart';
import 'package:hungry/features/home/widget/section_view.dart';
import 'package:hungry/features/home/view/product_detils_view.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool _firstTime = true;

  @override
  void initState() {
    super.initState();
    if (_firstTime) {
      _firstTime = false;
      final cubitAuth = context.read<AuthCubit>();
      cubitAuth.getProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return RefreshIndicator(
          onRefresh: cubit.getProducts,
          child: Skeletonizer(
            enabled: state is HomeLoading,
            child: Scaffold(
              backgroundColor: const Color(0xffF8F8F8),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is GetProfileError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(customSnackBarerror(state.message));
                        }
                      },
                      builder: (context, state) {
                        final cubitAuth = context.read<AuthCubit>();
                        return SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          expandedHeight: 260,
                          toolbarHeight: 260,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          backgroundColor: const Color(0xffF8F8F8),
                          flexibleSpace: HomeAppbarView(
                            userImage: cubitAuth.userModel?.image,
                            userAddress:
                                cubitAuth.userModel?.address ?? "Iraq, Baghdad",
                            onChane: (v) {
                              setState(() {
                                final search = cubit.searchController.text
                                    .trim()
                                    .toLowerCase();

                                if (search.isEmpty) {
                                  cubit.products = cubit.allproducts;
                                  return;
                                }

                                if (cubit.allproducts != null) {
                                  cubit.products = cubit.allproducts!
                                      .where(
                                        (element) => element.name
                                            .toLowerCase()
                                            .contains(search),
                                      )
                                      .toList();
                                }
                              });
                            },
                            search: cubit.searchController,
                          ),
                        );
                      },
                    ),

                    SliverToBoxAdapter(child: HomeAppbar()),

                    SliverToBoxAdapter(
                      child: Section(
                        title: "Popular",
                        action: cubit.products == null
                            ? "Loading..."
                            : "See all",
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 110),
                      sliver: cubit.products == null
                          ? SliverToBoxAdapter(
                              child: SizedBox(
                                height: 260,
                                child: Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                        color: Appcolors.background,
                                        size: 24,
                                      ),
                                ),
                              ),
                            )
                          : SliverGrid(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final product = cubit.products![index];

                                return ViewItems(
                                  name: product.name,
                                  desc: product.desc,
                                  image: product.image,
                                  rate: product.rating,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetilsView(
                                        image: product.image,
                                        productId: product.id,
                                        name: product.name,
                                        desc: product.desc,
                                        totalprice: product.price,
                                      ),
                                    ),
                                  ),
                                );
                              }, childCount: cubit.products!.length),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 0.55,
                                  ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
