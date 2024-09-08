import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:codeedextask/screens/loginScreen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  OTPVerificationScreen({required this.email});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://prethewram.pythonanywhere.com/api/verify-otp/'),
        body: {
          'otp': otpController.text,
          'email': widget.email,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Page Title
                Text(
                  'Verify Your OTP',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Enter the OTP sent to your email to verify your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: verifyOTP,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
