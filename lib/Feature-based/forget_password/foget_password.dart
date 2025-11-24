import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import '../../utils/shared_pref_helper.dart';
import '../auth/login_view/loginScreen.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Controllers
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _email = '';
  String _userId = '';
  String _ciSession = '';
  bool _isLoading = false;

  final _emailFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  Future<void> _loadUserData() async {
    try {
      final userId = await SharedPrefHelper.getUserData('id');
      final ciSession = '1d3eb721f0aa674245ab3e7755c31effacbe3dd8';

      print('Loaded userId: $userId');
      print('Loaded ci_session: $ciSession');

      setState(() {
        _userId = userId ?? '';
        _ciSession = ciSession ?? '';
      });

      if (_userId.isEmpty || _ciSession.isEmpty) {
        print('Warning: userId or ci_session is missing in SharedPreferences');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }


  Future<void> _sendOtp() async {
    if (_ciSession.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session expired. Please login again.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = 'https://madanvasu.in/new/apis/api_forgot_password/send_otp';
    var headers = {'Cookie': 'ci_session=$_ciSession'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'email': _emailController.text.trim()});
    request.headers.addAll(headers);

    print('SEND OTP REQUEST:');
    print('URL: $url');
    print('Headers: $headers');
    print('Body: ${request.fields}');

    try {
      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 15));

      final respString = await response.stream.bytesToString();
      print('SEND OTP RESPONSE (${response.statusCode}): $respString');

      if (response.statusCode == 200) {
        final json = jsonDecode(respString);

        if (json['status'] == true) {
          final String userIdFromApi =
              json['data']['user_id']?.toString() ?? '';

          setState(() {
            _email = _emailController.text.trim();
            _userId = userIdFromApi;
          });

          _nextPage();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'OTP sent successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'Failed to send OTP')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('SEND OTP EXCEPTION: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyOtp() async {
    if (_ciSession.isEmpty || _userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session or user ID missing.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = 'https://madanvasu.in/new/apis/api_forgot_password/verify_otp';
    var headers = {'Cookie': 'ci_session=$_ciSession'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'user_id': _userId,
      'otp': _otpController.text.trim(),
    });
    request.headers.addAll(headers);

    print('VERIFY OTP REQUEST:');
    print('URL: $url');
    print('Headers: $headers');
    print('Body: ${request.fields}');

    try {
      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 15));

      final respString = await response.stream.bytesToString();
      print('VERIFY OTP RESPONSE (${response.statusCode}): $respString');

      if (response.statusCode == 200) {
        final json = jsonDecode(respString);

        if (json['status'] == true) {
          _nextPage();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'OTP verified')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'Invalid OTP')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('VERIFY OTP EXCEPTION: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  Future<void> _resetPassword() async {
    if (_ciSession.isEmpty || _userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session or user ID missing.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = 'https://madanvasu.in/new/apis/api_forgot_password/reset_password';
    var headers = {'Cookie': 'ci_session=$_ciSession'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'user_id': _userId,
      'new_password': _passwordController.text,
      'confirm_password': _confirmPasswordController.text,
    });
    request.headers.addAll(headers);

    print('RESET PASSWORD REQUEST:');
    print('URL: $url');
    print('Headers: $headers');
    print('Body: ${request.fields}');

    try {
      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 15));

      final respString = await response.stream.bytesToString();
      print('RESET PASSWORD RESPONSE (${response.statusCode}): $respString');

      if (response.statusCode == 200) {
        final json = jsonDecode(respString);

        if (json['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'Password updated successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Login_Screen(toggleTheme: () {})),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(json['message'] ?? 'Failed to reset password')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('RESET PASSWORD EXCEPTION: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],
          ),
        ),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentStep = index),
          children: [
            _buildEmailStep(),
            _buildOtpStep(),
            _buildPasswordStep(),
          ],
        ),
      ),
    );
  }


  Widget _buildEmailStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 100, bottom: 100),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: Image.asset('assets/App_logo.png', height: 150, width: 200),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Form(
              key: _emailFormKey,
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1800),
                    child: _buildTextField(
                      controller: _emailController,
                      hintText: "Email or Phone number",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email or phone number";
                        }
                        if (value.contains('@') &&
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        if (!value.contains('@') && value.length < 10) {
                          return "Phone number must be at least 10 digits";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                        if (_emailFormKey.currentState!.validate()) {
                          _sendOtp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFe57c42),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : const Text("Send OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildOtpStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: Image.asset(
              'assets/App_logo.png',
              height: 140,
              width: 180,
            ),
          ),

          const SizedBox(height: 30),

          // OTP Instruction Text
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            child: Text(
              'Enter the 6-digit code sent to\n$_email',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // OTP Input Form
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            child: Form(
              key: _otpFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "Enter OTP",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFe57c42), width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the OTP";
                    } else if (value.length != 6) {
                      return "OTP must be 6 digits";
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Verify Button
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                if (_otpFormKey.currentState!.validate()) {
                  _verifyOtp();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe57c42),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
                elevation: 5,
              ),
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                "Verify OTP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Resend OTP Button
          TextButton(
            onPressed: _isLoading ? null : _sendOtp,
            child: const Text(
              "Resend OTP",
              style: TextStyle(
                color: Color(0xFFe57c42),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Back Button
          TextButton(
            onPressed: _previousPage,
            child: const Text(
              "Back",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              // Rebuild OTP string
              String otp = '';
              for (int i = 0; i < 6; i++) {
                otp += (i < _otpController.text.length) ? _otpController.text[i] : '';
              }
              _otpController.text = otp + value;
              if (_otpController.text.length > 6) {
                _otpController.text = _otpController.text.substring(0, 6);
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFFFF5E4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFfab783), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFfab783), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFe57c42), width: 2),
              ),
            ),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }),
    );
  }

  Widget _buildPasswordStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 100, bottom: 100),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            child: Image.asset('assets/App_logo.png', height: 150, width: 200),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Form(
              key: _passwordFormKey,
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1800),
                    child: _buildTextField(
                      controller: _passwordController,
                      hintText: "New Password",
                      icon: Icons.lock,
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please enter a new password";
                        if (value.length < 6) return "Password must be at least 6 characters";
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFe57c42)),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1800),
                    child: _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm New Password",
                      icon: Icons.lock_outline,
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please confirm your password";
                        if (value != _passwordController.text) return "Passwords do not match";
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFe57c42)),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                        if (_passwordFormKey.currentState!.validate()) {
                          _resetPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFe57c42),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : const Text("Reset Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Login_Screen(toggleTheme: () {})),
                    ),
                    child: const Text("Back to Login", style: TextStyle(color: Color(0xFFe57c42), fontWeight: FontWeight.w600)),
                  ),
                  TextButton(
                    onPressed: _previousPage,
                    child: const Text("Back", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5E4),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: const Color(0xFFfab783), width: 1.5),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[700]),
            prefixIcon: Icon(icon, color: const Color(0xFFe57c42)),
            suffixIcon: suffixIcon,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}