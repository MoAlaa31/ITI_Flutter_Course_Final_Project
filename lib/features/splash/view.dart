import 'package:final_project/cores/resources/cache_helper.dart';
import 'package:final_project/features/login/view.dart';
import 'package:final_project/features/navigator/view.dart';
import 'package:final_project/features/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      CacheHelper.getToken().then((value) {
        if (value.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ProfileCubit()..getProfileData(),
                child: const NavPage(),
              ),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          child: Lottie.asset(
            "assets/json/splash_loading.json",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
