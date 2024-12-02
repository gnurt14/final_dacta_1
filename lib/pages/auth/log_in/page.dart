import 'package:final_dacta/constants/app_colors.dart';
import 'package:final_dacta/pages/auth/controller.dart';
import 'package:final_dacta/pages/auth/otp/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(phoneFocusNode);
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder(
        init: AuthController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_iphone,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Your Phone',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Please confirm your country code\nand enter your phone number.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        controller.pickCountry(context);
                      },
                      child: Text((controller.country == null)
                          ? 'Choose your country'
                          : '${controller.country?.displayName}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              (controller.country == null)
                                  ? '+Phone Code'
                                  : '${controller.country?.countryCode} +${controller.country?.phoneCode}',
                              style: TextStyle(
                                fontSize:
                                    (controller.country == null) ? 12 : 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 256,
                            child: TextField(
                              focusNode: phoneFocusNode,
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(4.0),
                                hintText: 'Your phone number',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              onChanged: (val) {
                                controller.update();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.backgroundColor,
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: (phoneController.text.isEmpty)
                          ? null
                          : () {
                              if (controller.country == null) {
                                Get.snackbar(
                                    'Alert', 'Please confirm your country',
                                    colorText: AppColors.backgroundColor,
                                    animationDuration:
                                        const Duration(seconds: 2),
                                    backgroundColor: Colors.red);
                              } else {
                                Get.defaultDialog(
                                  titlePadding: const EdgeInsets.only(top: 24),
                                  contentPadding: const EdgeInsets.all(24),
                                  title:
                                      '+${controller.country!.phoneCode} ${phoneController.text.trim()}',
                                  titleStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  content: const Text(
                                    'Is this the correct number?',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  cancel: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor:
                                          AppColors.backgroundColor,
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () async {
                                      controller.showLoading.value = true;
                                      controller.phoneNumber =
                                          '${controller.country!.phoneCode}${phoneController.text.trim()}';
                                      await controller.signInWithPhone(
                                          controller.phoneNumber);
                                      await Future.delayed(
                                          const Duration(seconds: 3));
                                      if (mounted) {
                                        controller.showLoading.value = false;
                                        Get.to(() => const OtpPage());
                                      }
                                    },
                                    child: Obx(() => controller.showLoading.value
                                        ? const CircularProgressIndicator(
                                      color: AppColors.backgroundColor,
                                    )
                                        : const Text('Continue')),
                                  ),
                                );
                              }
                            },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
