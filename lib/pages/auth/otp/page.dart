import 'package:final_dacta/constants/app_colors.dart';
import 'package:final_dacta/pages/auth/controller.dart';
import 'package:final_dacta/pages/auth/otp/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.back(closeOverlays: true);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: AppColors.primaryColor,
                    size: 32,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            leadingWidth: 100,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('We have sent the code verification to'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '+${controller.phoneNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10,),
                const OtpForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}
