import 'package:get/get.dart';
import 'package:mediaverse/app/pages/detail/view.dart';
import 'package:mediaverse/app/pages/home/state.dart';
import 'package:mediaverse/app/pages/home/view.dart';
import 'package:mediaverse/app/pages/login/view.dart';
import 'package:mediaverse/app/pages/otp/view.dart';
import 'package:mediaverse/app/pages/search/state.dart';
import 'package:mediaverse/app/pages/search/view.dart';
import 'package:mediaverse/app/pages/signup/view.dart';
import 'package:mediaverse/app/pages/splash/state.dart';
import 'package:mediaverse/app/pages/wrapper/state.dart';
import 'package:mediaverse/app/pages/wrapper/view.dart';

import '../pages/splash/view.dart';


class PageRoutes {
  static const SPLASH = '/Splash';
  static const HOME = '/';
  static const LOGIN = '/Login';
  static const OTP = '/otp';
  static const SIGNUP = '/Signup';
  static const WRAPPER = '/Wrapper';
  static const SEARCH = '/Search';
  static const DETAIL = '/Detail';


  static List<GetPage> routes = [
    GetPage(
      name: PageRoutes.SPLASH,
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
      binding: SplashState(),

    ),
    GetPage(
      name: PageRoutes.WRAPPER,
      transition: Transition.noTransition,
      page: () => MainWrapperScreen(),
      binding: WrapperState(),
    ),

    GetPage(
      name: PageRoutes.HOME,
      transition: Transition.noTransition,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: PageRoutes.LOGIN,
      transition: Transition.noTransition,
      page: () => LoginScreen(),

    ),
    GetPage(
      name: PageRoutes.OTP,
      transition: Transition.noTransition,
      page: () => OTPScreen(),

    ),
    GetPage(
      name: PageRoutes.SIGNUP,
      transition: Transition.noTransition,
      page: () => SignupScreen(),


    ),
    GetPage(
      name: PageRoutes.SEARCH,
      transition: Transition.downToUp,
      page: () => SearchScreen(),
      binding: SearchState(),


    ),
    GetPage(
      name: PageRoutes.DETAIL,
      transition: Transition.downToUp,
      page: () => DetailScreen(),



    ),

  ];
}

class ServerRoute {
  static const SIGNIN = 'general/signin';

}
