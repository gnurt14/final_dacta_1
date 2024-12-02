import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Country? country;
  RxBool showLoading = false.obs;
  String? phoneNumber;

  void pickCountry(BuildContext context) {
    showCountryPicker(
      showPhoneCode: true,
      context: context,
      onSelect: (Country val) {
        country = val;
        update();
      },
    );
  }

  Future<void> signInWithPhone(String? phoneNumber) async{

  }
}
