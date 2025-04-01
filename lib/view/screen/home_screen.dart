import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:unier/utils/colors.dart';
import 'package:unier/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 250,
            ),
            const GradientAnimationText(
              text: Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              colors: [AppColors.blue, AppColors.red],
              duration: Duration(seconds: 2),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "to Unier",
              style: TextStyle(fontSize: 45),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.chatScreen);
                },
                child: const Text(
                  "Start a new chat",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
