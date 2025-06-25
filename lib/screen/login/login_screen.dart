import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicer_pro_flutter/component/text_styles.dart';
import 'package:invoicer_pro_flutter/component/ui/progress_dialog.dart';
import 'package:invoicer_pro_flutter/constants/asset_constants.dart';
import 'package:invoicer_pro_flutter/router/routing_constants.dart';
import 'package:invoicer_pro_flutter/screen/login/logic/login_cubit.dart';
import 'package:invoicer_pro_flutter/theme/color_constant.dart';
import 'package:invoicer_pro_flutter/utils/custom_snack_bar.dart';

import '../../service/google_signin_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              ProgressDialog.show(context);
            } else if (state is LoginFailed) {
              Navigator.of(context).pop(); //pop dialog
              showSnackBarRed(context, "Login Failed");
            } else if (state is LoginSuccess) {
              Navigator.of(context).pop(); //pop dialog
              showSnackBarGreen(context, "Succesfully Logged in");
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Center(
                        child: Image.asset(
                      AssetsConstants.splashImage,
                      width: 120,
                      height: 100,
                    )),

                    const SizedBox(height: 16),

                    // App Title
                    Text(
                      'Invoicer Pro',
                      textAlign: TextAlign.center,
                      style: TextStyles.customFont(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    const Text(
                      'Your seamless invoicing solution',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Email Input Field
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        // Dark background
                        labelText: 'Email Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF666666),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF404040), // Light border color
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF5C6BC0),
                            // Focused border color (optional)
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Password Input Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        // Dark background
                        label: Text(
                          'Password',
                          style: TextStyles.customFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Color(0xFF666666)),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF666666),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF666666),
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF404040), // Light grey border
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF5C6BC0),
                            // Highlight border on focus
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //Forgot Password
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Log In Button
                    ElevatedButton(
                      onPressed: () async {
                        if (loginFormKey.currentState?.validate() ?? false) {
                          Map<String, dynamic> loginMap = {
                            "type": "email",
                            "email": emailController.text,
                            "password": passwordController.text
                          };
                          context.read<LoginCubit>().callLoginApi(loginMap);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C6BC0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Create Account Button
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed(signupScreenRoute);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5C6BC0),
                        side: const BorderSide(
                          color: Color(0xFF5C6BC0),
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Or Divider
                    Text(
                      'or',
                      textAlign: TextAlign.center,
                      style: TextStyles.customFont(
                        color: const Color(0xFF9E9E9E),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Continue with Google Button
                    OutlinedButton(
                      onPressed: () async {
                        final userCredential =
                            await GoogleSignInService().signInWithGoogle();
                        if (userCredential != null) {
                          showSnackBarGreen(context,
                              "Successfully signed in with ${userCredential.user?.email ?? ''}");
                          print(
                              "Successfully signed in with ${userCredential.user?.email ?? ''}");
                          // Navigate to home screen or update UI
                        } else {
                          showSnackBarYellow(
                              context, "Google SignIn cancelled");
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF404040),
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.g_mobiledata,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // // Continue with Apple Button
                    // OutlinedButton(
                    //   onPressed: () {
                    //     // Handle Apple sign in
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //     foregroundColor: Colors.white,
                    //     side: const BorderSide(
                    //       color: Color(0xFF404040),
                    //       width: 1,
                    //     ),
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    //   child: const Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Icon(
                    //         Icons.apple,
                    //         size: 24,
                    //         color: Colors.white,
                    //       ),
                    //       SizedBox(width: 12),
                    //       Text(
                    //         'Continue with Apple',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
