import 'package:final_project/cores/network/dio_helper.dart';
import 'package:final_project/features/cart/cart_cubit.dart';
import 'package:final_project/features/splash/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();

  runApp(
      BlocProvider(
      create: (_) => CartCubit(),
      child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: SplashPage(),
    );
  }
}
