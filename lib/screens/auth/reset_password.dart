import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_mart/screens/auth/forgot_password.dart';
import 'package:shop_mart/screens/auth/login.dart';
import '../../consts/validator.dart';
import '../../services/assets_manager.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          fontSize: 22,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              // Section 1 - Header
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.sendImage,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: TitlesTextWidget(
                  label: 'Password reset email sent',
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SubtitleTextWidget(
                  label: widget.email,
                  fontSize: 16,
                ),
              ),
              const Center(
                child: SubtitleTextWidget(
                  label: 'Please check your email to reset your password',
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.shieldDone),
                  label: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.arrowLeft2),
                  label: const Text(
                    "Return to reset your password",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ForgotPasswordScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
