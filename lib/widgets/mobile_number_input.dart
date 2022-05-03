import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MobileNumberInput extends StatefulWidget {
  const MobileNumberInput({Key? key}) : super(key: key);

  @override
  _MobileNumberInputState createState() => _MobileNumberInputState();
}

class _MobileNumberInputState extends State<MobileNumberInput> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 5,
        useEmoji: true,
      ),
      ignoreBlank: false,
      maxLength: 10,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: controller,
      formatInput: false,
      spaceBetweenSelectorAndTextField: 0,
      inputBorder: InputBorder.none,
      inputDecoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 0.0, top: 7.5),
          hintText: 'Phone Number',
          border: InputBorder.none,
          isDense: true),
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
