import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoicer_pro_flutter/component/text_styles.dart';
import 'package:invoicer_pro_flutter/screen/signup_screen/logic/signup_cubit.dart';
import 'package:invoicer_pro_flutter/utils/custom_snack_bar.dart';
import 'package:invoicer_pro_flutter/utils/input_formatter/uppercase_text_formatter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Widget create() {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: const SignupScreen(),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  File? selectedLogo;

  // Text controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'Business Setup',
          style: TextStyles.customFont(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Form(
            key: signupFormKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo Upload Section
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    margin: const EdgeInsets.only(bottom: 32.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFF3A3A3A)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Upload Business Logo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFF3A3A3A),
                          backgroundImage: selectedLogo != null
                              ? FileImage(selectedLogo!)
                              : null,
                          child: selectedLogo == null
                              ? Icon(Icons.image,
                                  size: 40, color: Colors.grey[400])
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'PNG, JPG up to 5MB.',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );

                            if (result != null) {
                              setState(() {
                                selectedLogo = File(result.files.single.path!);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3A3A3A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Choose File'),
                        ),
                      ],
                    ),
                  ),
                  signupFormField(
                      controller: fullNameController,
                      label: 'Full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                      hintText: "Please Enter your Full Name"),
                  const SizedBox(height: 20),

                  // Business Name
                  signupFormField(
                      controller: businessNameController,
                      label: 'Business Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Business name is required';
                        }
                        return null;
                      },
                      hintText: "Please enter your Business Name"),

                  const SizedBox(height: 20),

                  // Business Address
                  signupFormField(
                      controller: businessAddressController,
                      label: 'Business Address',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Business address is required';
                        }
                        return null;
                      },
                      hintText:
                          "e.g. 123 Business Street, Andheri East, Mumbai, MH - 400069"),

                  const SizedBox(height: 20),

                  // Contact Number
                  signupFormField(
                      controller: contactNumberController,
                      label: 'Contact Number',
                      keyboardType: TextInputType.phone,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contact number is required';
                        }
                        return null;
                      },
                      hintText: "e.g. +911234567890"),

                  const SizedBox(height: 20),

                  // Business Email
                  signupFormField(
                      controller: businessEmailController,
                      label: 'Business Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Business email is required';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      hintText: "e.g. support@companyname.in"),

                  const SizedBox(height: 20),

                  // Password
                  signupFormField(
                      controller: passwordController,
                      label: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[400],
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      hintText: ""),

                  const SizedBox(height: 20),

                  // GST Number (Optional)
                  signupFormField(
                      controller: gstNumberController,
                      label: 'GST Number (Optional)',
                      inputFormatter: [UpperCaseTextFormatter()],
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "e.g. 22AAAAA0000A1Z5"),

                  const SizedBox(height: 40),

                  // Signup Button
                  ElevatedButton(
                    onPressed: callSignupApi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Signup',
                      style: TextStyles.customFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> callSignupApi() async {
    if (selectedLogo == null) {
      showSnackBarRed(context, "Please Update your Logo");
    } else if (signupFormKey.currentState!.validate()) {
      // Create JSON-like payload
      FormData signupFormData = FormData.fromMap({
        "name": fullNameController.text,
        "email": businessEmailController.text,
        "password": passwordController.text,
        "phone": contactNumberController.text,
        "business_name": businessNameController.text,
        "gstn": gstNumberController.text
      });
      if (selectedLogo != null) {
        signupFormData.files.add(MapEntry(
            "business_logo",
            await MultipartFile.fromFile(
              selectedLogo?.path ?? '',
              contentType: DioMediaType('image', 'png'),
            )));
      }

      context.read<SignupCubit>().callSignupApi(signupFormData);
    }
  }

  Widget signupFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatter,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.customFont(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          inputFormatters: inputFormatter,
          style: TextStyles.customFont(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyles.customFont(
                color: Colors.white, fontWeight: FontWeight.w200),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    businessNameController.dispose();
    businessAddressController.dispose();
    contactNumberController.dispose();
    businessEmailController.dispose();
    passwordController.dispose();
    gstNumberController.dispose();
    super.dispose();
  }
}
