

import 'package:camera_ocr_scanner/constants/App_Colors.dart';
import 'package:camera_ocr_scanner/models/UserModel.dart';
import 'package:camera_ocr_scanner/routes/Route_Name.dart';
import 'package:camera_ocr_scanner/services/NavigatorServices.dart';
import 'package:camera_ocr_scanner/services/SharedPrefenceService.dart';
import 'package:camera_ocr_scanner/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Create Account',
        style: TextStyle(
            color: Colors.white
        ),

        ),
        centerTitle: true,
        backgroundColor: AppColors.BackgroundColor,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please create your account',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),


            _buildTextField(controller: nameController, label: 'Name'),

            const SizedBox(height: 16),


            _buildTextField(controller: emailController, label: 'Email'),

            const SizedBox(height: 16),


            _buildTextField(
                controller: passwordController,
                label: 'Password',
                isPassword: true),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.BackgroundColor,
              ),
              onPressed: () async {

                   if(emailController.text.isEmpty && passwordController.text.isEmpty && nameController.text.isEmpty){
                  showSnackBar(context, "detail missing  unsuccessful",
                      isSuccess: false);
                }
                else {
                  UserModel user = UserModel(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    sessionactive: false,
                    username: nameController.text.trim(),
                  );

                  bool success = await SharedPrefencesService.boolsetSignup(user);

                  if (success) {
                    showSnackBar(context, "Sign up successful");
                  } else {
                    showSnackBar(context, "Sign up unsuccessful",
                        isSuccess: false);
                  }
                }


              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                color: Colors.white
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                NavigatorServices.GoTo(RoutesName.login_route);
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
