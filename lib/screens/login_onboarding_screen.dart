import 'package:flutter/material.dart';
import '../colors.dart';
import '../components/widgets/curve_layout.dart';
import '../components/widgets/splash_button.dart';

class LoginOnboardingScreen extends StatefulWidget {
  const LoginOnboardingScreen({super.key});

  @override
  State<LoginOnboardingScreen> createState() => _LoginOnboardingScreenState();
}

class _LoginOnboardingScreenState extends State<LoginOnboardingScreen>{


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: greyWhiteBgColor,
      body: Stack(
        children: [
          CurveLayout(
            color: darkYellow,
            xOffset: 0,
            yOffset: size.height / 2 - 100,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SplashButtonCustom(
                  text: 'Login'.toUpperCase(),
                  borderRadius: 15,
                  onTap: () {
                    
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SplashButtonCustom(
                  text: 'Register'.toUpperCase(),
                  outlined: true,
                  outlineWidth: 3,
                  borderRadius: 15,
                  onTap: () {
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}