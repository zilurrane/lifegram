import 'package:flutter/material.dart';
import 'package:lifegram/widgets/mobile_number_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text("Welcome",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w900))),
              const Text("Enter your mobile number here",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
              Container(
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
                child: const MobileNumberInput(),
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
                    debugPrint('Received click');
                  },
                  child: const Text('Get OTP'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
