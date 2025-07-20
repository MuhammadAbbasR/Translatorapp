import 'package:camera_ocr_scanner/constants/App_Colors.dart';
import 'package:camera_ocr_scanner/models/UserModel.dart';
import 'package:camera_ocr_scanner/routes/Route_Name.dart';
import 'package:camera_ocr_scanner/services/SharedPrefenceService.dart';
import 'package:camera_ocr_scanner/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import '../services/NavigatorServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Login',
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
            const SizedBox(height: 40),
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Login to continue',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Email Field
            _buildTextField(controller: emailController, label: 'Email'),

            const SizedBox(height: 16),

            // Password Field
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
              onPressed: () {

                if(emailController.text.isEmpty && passwordController.text.isEmpty){
                  showSnackBar(context, "detail missing  unsuccessful",
                      isSuccess: false);
                }
                else{
                  bool success = SharedPrefencesService.setlogin(UserModel(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ));

                  if (success) {
                    NavigatorServices.GoTo(RoutesName.home_route);
                  } else {
                    showSnackBar(context, "No user found", isSuccess: false);
                  }
                }


              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                color: Colors.white
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(

              onPressed: () {
                NavigatorServices.NavigationTo(RoutesName.signup_route);
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
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
