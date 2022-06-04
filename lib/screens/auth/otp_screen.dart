import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifegram/screens/app/home_screen.dart';
import 'package:lifegram/shared/constants/env_constants.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen(this.phone, {Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 239, 241, 255)),
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Enter your OTP for ${widget.phone}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 1.0,
                  )
                ]),
                child: Pinput(
                  length: 6,
                  onCompleted: (pin) async {
                    try {
                      final response = await http.post(
                          Uri.parse(
                              '${EnvConstants.apiUrl}/auth/otp/phone/verify'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'phoneNumber': widget.phone,
                            'otp': pin
                          }));
                      if (response.statusCode == 200) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      } else {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('invalid OTP')));
                      }
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('invalid OTP')));
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textStyle:
                          const TextStyle(fontSize: 24, color: Colors.white)),
                  onPressed: () {
                    formKey.currentState?.save();
                  },
                  child: const Text('Sign In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
