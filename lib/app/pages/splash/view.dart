import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';

import 'package:mediaverse/app/widgets/logo_app_widget.dart';

import 'logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  final splashController = Get.find<SplashLogic>();

  @override
  void initState() {

    _mainFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Stack(
        children: [
          Opacity(
            opacity: _animation.value,
            child: Center(
              child: LogoAppWidget(),
            ),
          ),
          Positioned.fill(
            bottom: 14,
            child: Opacity(
              opacity: _animation.value,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.end,
                    children: [
                      SpinKitDoubleBounce(
                        color: Colors.white,
                        size: 30.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'v 0.0',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _mainFunction() async{
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (splashController.showSplash.value) {
          splashController.hideSplashAndNavigateToNextScreen();
        }
      }
    });
  }
}