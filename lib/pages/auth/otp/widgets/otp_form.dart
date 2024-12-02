import 'package:flutter/material.dart';

import 'number_item.dart';
class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<String> _otpValues = List.filled(6, '');

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    _otpValues[index] = value;

    if (index == _otpValues.length - 1 && value.length == 1) {
      _submitOtp();
    }
  }

  void _submitOtp() {
    String otp = _otpValues.join();
    print("OTP Submitted: $otp");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return NumberItem(
            focusNode: _focusNodes[index],
            onChanged: (value) => _onChanged(value, index),
          );
        }),
      ),
    );
  }
}