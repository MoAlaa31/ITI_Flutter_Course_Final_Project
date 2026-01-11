import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/cores/resources/cache_helper.dart';
import 'package:final_project/features/cart/cart_cubit.dart';
import 'package:final_project/features/login/view.dart';
import 'package:final_project/features/profile/profile_cubit.dart';
import 'package:final_project/features/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.watch<ProfileCubit>();
    final profile = profileCubit.profile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: profileCubit.state is ProfileLoading
          ? Center(
            child: Lottie.asset("assets/json/splash_loading.json"),
          )
          : profileCubit.state is ProfileFailure
          ? Center(child: Text("Error"))
          : profile == null
          ? SizedBox()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          profile.avatar ?? AppImage.userImage,
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      profile.name ?? "User",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                    ProfileItem(text: "Profile", icon: AppImage.userIcon),
                    SizedBox(height: 15),
                    ProfileItem(text: "Setting", icon: AppImage.settingIcon),
                    SizedBox(height: 15),
                    ProfileItem(text: "Contact", icon: AppImage.mailIcon),
                    SizedBox(height: 15),
                    ProfileItem(text: "Share App", icon: AppImage.shareIcon),
                    SizedBox(height: 15),
                    ProfileItem(text: "Help", icon: AppImage.helpIcon),
                    SizedBox(height: 100),
                    GestureDetector(
                      onTap: () async {
                        context.read<CartCubit>().removeAllFromCart();
                        await CacheHelper.deleteToken();
                        if (!context.mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => LoginPage()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffF55F1F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
