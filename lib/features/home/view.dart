import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/features/Detailed/view.dart';
import 'package:final_project/features/Products/view.dart';
import 'package:final_project/features/home/home_cubit.dart';
import 'package:final_project/features/navigator/nav_cubit.dart';
import 'package:final_project/features/profile/profile_cubit.dart';
import 'package:final_project/features/widgets/home_item.dart';
import 'package:final_project/features/widgets/slider_item.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.watch<ProfileCubit>();
    final profile = profileCubit.profile;

    return BlocProvider(
      create: (_) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: profileCubit.state is ProfileLoading
            ? Center(child: Lottie.asset("assets/json/splash_loading.json"))
            : profileCubit.state is ProfileFailure
            ? Center(child: Text("Error"))
            : profile == null
            ? SizedBox()
            : BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(
                      child: Lottie.asset("assets/json/splash_loading.json"),
                    );
                  }
                  if (state is HomeFailure) {
                    return Container(child: Text(state.errMsg));
                  }
                  if (state is HomeSuccess) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(
                                        profile.avatar ?? AppImage.userImage,
                                        fit: BoxFit.fitWidth,
                                        width: 48,
                                        height: 48,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Hello!",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          profile.name ?? "User",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Color(0xffF8F7F7),
                                  radius: 24,
                                  child: Icon(
                                    Icons.notifications,
                                    size: 25,
                                    color: Color(0xff7C7979),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18),
                            GestureDetector(
                              onTap: () {
                                context.read<NavCubit>().changeTab(1);
                              },
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  enabled: false,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: Color(0xff7C7979),
                                      size: 30,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Color(0xffF8F7F7),
                                  hintText: "Search here",
                                  hintStyle: TextStyle(
                                    color: AppColors.subColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                            ImageCarousel(),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Featured",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProductList(products: state.categories,);
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "See All",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            SizedBox(
                              height: 143,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categories.length,
                                itemBuilder: (c, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DetailedPage(
                                              model: state.categories[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: HomeItem(title: state.categories[index].title ?? "null", image: state.categories[index].thumbnail ?? "null", price: state.categories[index].price ?? 0.0,),
                                    ),
                                  );
                                }
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Most Popular",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ProductList(products: state.products);
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "See All",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            SizedBox(
                              height: 143,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.products.length,
                                  itemBuilder: (c, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DetailedPage(
                                                model: state.products[index],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: HomeItem(title: state.products[index].title ?? "null", image: state.products[index].thumbnail ?? "null", price: state.products[index].price ?? 0.0,),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(child: Text("No state"));
                },
              ),
      ),
    );
  }
}
