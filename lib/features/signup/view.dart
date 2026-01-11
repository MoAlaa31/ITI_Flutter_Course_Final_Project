import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/cores/resources/snack_bar.dart';
import 'package:final_project/features/auth/auth_cubit.dart';
import 'package:final_project/features/login/view.dart';
import 'package:final_project/features/widgets/text_form_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignupFailure) {
              showMySnackBar(
                msg: state.errMsg,
                type: AnimatedSnackBarType.error,
                context: context,
              );
            }
            if (state is SignupSuccess) {
              showMySnackBar(
                msg: "Sign Up Success",
                type: AnimatedSnackBarType.success,
                context: context,
              );
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => LoginPage()));
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            if (state is SignupLoading) {
              return Center(
                child: Lottie.asset("assets/json/splash_loading.json"),
              );
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: AppColors.primaryColor,
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Get Winter Discount",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "\n20% Off",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "\nFor Childern",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 89,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    AppImage.homeImage,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormItem_(
                        label: "Email",
                        hintText: "Enter your email",
                        isPassword: false,
                        controller: cubit.emailController,
                      ),
                      SizedBox(height: 20),
                      TextFormItem_(
                        label: "Password",
                        hintText: "Enter your password",
                        isPassword: true,
                        controller: cubit.passwordController,
                      ),
                      SizedBox(height: 20),
                      TextFormItem_(
                        label: "Confirm Password",
                        hintText: "Renter your password",
                        isPassword: true,
                        controller: cubit.confirmPassController,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => cubit.signup(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            // fixedSize: Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Create account",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: AppColors.subColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginPage();
                                      },
                                    ),
                                  );
                                },
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
        ),
      ),
    );
  }
}
