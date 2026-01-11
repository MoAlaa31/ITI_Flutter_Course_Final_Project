import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/features/cart/view.dart';
import 'package:final_project/features/home/view.dart';
import 'package:final_project/features/navigator/nav_cubit.dart';
import 'package:final_project/features/profile/view.dart';
import 'package:final_project/features/search/search_cubit.dart';
import 'package:final_project/features/search/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BlocProvider(
    create: (_) => SearchCubit(),
    child: SearchPage(),
    ),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, int>(
          builder: (context, currentIndex) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: _widgetOptions.elementAt(currentIndex)),
              bottomNavigationBar: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      child: BottomNavigationBar(
                        backgroundColor: Color(0xffF8F7F7),
                        type: BottomNavigationBarType.fixed,
                        elevation: 0,
                        currentIndex: currentIndex,
                        onTap: (index) =>
                            context.read<NavCubit>().changeTab(index),
                        selectedItemColor: AppColors.primaryColor,
                        unselectedItemColor: Color(0xff9E9E9E),
                        showUnselectedLabels: false,
                        items: [
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppImage.homeIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                (currentIndex == 0)
                                    ? AppColors.primaryColor
                                    : Color(0xff9E9E9E),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: "Home",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppImage.searchIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                (currentIndex == 1)
                                    ? AppColors.primaryColor
                                    : Color(0xff9E9E9E),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: "Explore",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppImage.bagIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                (currentIndex == 2)
                                    ? AppColors.primaryColor
                                    : Color(0xff9E9E9E),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: "My Cart",
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppImage.userIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                (currentIndex == 3)
                                    ? AppColors.primaryColor
                                    : Color(0xff9E9E9E),
                                BlendMode.srcIn,
                              ),
                            ),
                            label: "Profile",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
