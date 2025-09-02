import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo animation
                Lottie.asset(
                  'assets/Thunderstorm.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                //Maring and app name
                const SizedBox(height: 16),
                Text(
                  "Weather App",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                // Username and password fields
                _buildTextField(
                  controller: userController,
                  label: "Username",
                  obscure: false,
                  validatorMsg: 'Please enter your username',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: passwordController,
                  label: "Password",
                  obscure: true,
                  validatorMsg: 'Please enter your password',
                ),
                //Login button
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(username: userController.text),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required String validatorMsg,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }
}
