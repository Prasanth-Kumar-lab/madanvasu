import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:madhanvasu_app/madhanvasu_lib/aswini_screens/views/login_screen.dart';
// import 'package:real_estate/aswini_screens/views/login_screen.dart';
import 'dart:ui'; 
import '../auth/login_view/loginScreen.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: [
            //   //Color(0xFFfab783), // Soft peach
            //   Color(0xFFFFF5E4),
            //   Color(0xFFFFF5E4), // Light cream
            // ],
            colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],

          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            child: Column(
              children: <Widget>[
                FadeInUp(
                  duration: const Duration(milliseconds: 1800),
                  child: Image.asset(
                    'assets/App_logo.png',
                    height: 150,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20), 
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: Duration(milliseconds: 1800),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0), 
                            child: Container(
                              padding: EdgeInsets.all(2), 
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF5E4),
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Color(0xFFfab783), 
                                  width: 1.5,
                                ),
                              ),
                              child: _buildTextField(
                                controller: _emailController,
                                hintText: "Email or Phone number",
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email or phone number";
                                  }
                                  if (value.contains('@') &&
                                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value)) {
                                    return "Please enter a valid email";
                                  }
                                  if (!value.contains('@') && value.length < 10) {
                                    return "Phone number must be at least 10 digits";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FadeInUp(
                          duration: Duration(milliseconds: 1800),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF5E4),
                                borderRadius: BorderRadius.circular(30.0), 
                                border: Border.all(
                                  color: Color(0xFFfab783), 
                                  width: 1.5,
                                ),
                              ),
                              child: _buildTextField(
                                controller: _passwordController,
                                hintText: "New Password",
                                icon: Icons.lock,
                                obscureText: _obscurePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a new password";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFFe57c42),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), 
                        FadeInUp(
                          duration: Duration(milliseconds: 1800),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              padding: EdgeInsets.all(2), 
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF5E4), 
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Color(0xFFfab783), // Border color
                                  width: 1.5,
                                ),
                              ),
                              child: _buildTextField(
                                controller: _confirmPasswordController,
                                hintText: "Confirm New Password",
                                icon: Icons.lock_outline,
                                obscureText: _obscureConfirmPassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please confirm your password";
                                  }
                                  if (value != _passwordController.text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFFe57c42),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword = !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Password successfully updated for ${_emailController.text}"),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login_Screen(toggleTheme: () {  },)),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFe57c42),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                minimumSize: Size(double.infinity, 50),
                                elevation: 5,
                              ),
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Login_Screen(toggleTheme: () {  },)),
                                );
                              },
                              child: Text(
                                "Back to Login",
                                style: TextStyle(
                                  color: Color(0xFFe57c42),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.all(4.0), 
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(
            icon,
            color: Color(0xFFe57c42),
          ),
          suffixIcon: suffixIcon,
          errorStyle: TextStyle(
            color: Colors.red, 
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}