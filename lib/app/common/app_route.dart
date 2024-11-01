import 'package:get/get.dart';
import 'package:mediaverse/app/pages/change_password/view.dart';
import 'package:mediaverse/app/pages/channel/all_tools.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:mediaverse/app/pages/detail/pages/detail_text_screen.dart';
import 'package:mediaverse/app/pages/detail/state.dart';
import 'package:mediaverse/app/pages/detail/view.dart';
import 'package:mediaverse/app/pages/edit_profile/view.dart';
import 'package:mediaverse/app/pages/home/state.dart';
import 'package:mediaverse/app/pages/home/view.dart';
import 'package:mediaverse/app/pages/intro/view.dart';
import 'package:mediaverse/app/pages/live/state.dart';
import 'package:mediaverse/app/pages/live/view.dart';
import 'package:mediaverse/app/pages/login/view.dart';
import 'package:mediaverse/app/pages/massage/view.dart';
import 'package:mediaverse/app/pages/media_suit/state.dart';
import 'package:mediaverse/app/pages/media_suit/view.dart';
import 'package:mediaverse/app/pages/otp/view.dart';
import 'package:mediaverse/app/pages/plus_section/view.dart';
import 'package:mediaverse/app/pages/profile/view.dart';
import 'package:mediaverse/app/pages/search/state.dart';
import 'package:mediaverse/app/pages/search/view.dart';
import 'package:mediaverse/app/pages/setting/view.dart';
import 'package:mediaverse/app/pages/share_account/view.dart';
import 'package:mediaverse/app/pages/signup/view.dart';
import 'package:mediaverse/app/pages/splash/state.dart';
import 'package:mediaverse/app/pages/upload/view.dart';
import 'package:mediaverse/app/pages/video_editor/state.dart';
import 'package:mediaverse/app/pages/video_editor/view.dart';
import 'package:mediaverse/app/pages/wrapper/state.dart';
import 'package:mediaverse/app/pages/wrapper/view.dart';

import '../pages/detail/pages/comment_screen.dart';
import '../pages/detail/pages/detail_image_screen.dart';
import '../pages/detail/pages/detail_music_screen.dart';
import '../pages/detail/pages/detail_video_screen.dart';
import '../pages/splash/view.dart';
import '../pages/view_all/channel/state.dart';
import '../pages/view_all/channel/view.dart';


class PageRoutes {
  static const SPLASH = '/Splash';
  static const HOME = '/';
  static const LOGIN = '/Login';
  static const OTP = '/otp';
  static const SIGNUP = '/Signup';
  static const WRAPPER = '/Wrapper';
  static const SEARCH = '/Search';
  static const DETAILVIDEO = '/DetailVideo';
  static const DETAILIMAGE = '/DetailImage';
  static const DETAILTEXT = '/DetailText';
  static const DETAILMUSIC = '/DetailMusic';
  static const PROFILE = '/Profile';
  static const SETTING = '/Setting';
  static const MASSAGE = '/Massage';
  static const INTRO = '/Intro';
  static const PLUS = '/Plus';
  static const UPLOAD = '/Upload';
  static const COMMENT = '/Comment';
  static const LIVE = '/Live';
  static const ViewAllChannel = '/ViewAllChannel';
  static const VIDEOEDITOR = '/VideoEditor';
  static const ALLTOOLS = '/AllTools';
  static const EDITPROFILE = '/EditProfile';
  static const CHANGEPASSWORD = '/ChangePassword';
  static const MEDIASUIT = '/MediaSuite';
  static const SHAREACCOUNT = '/ShareAccount';


  static List<GetPage> routes = [
    GetPage(
      name: PageRoutes.SPLASH,
      page: () => const SplashScreen(),
      transition: Transition.upToDown,
      binding: SplashState(),

    ),
    GetPage(
      name: PageRoutes.PROFILE,
      page: () => ProfileScreen(),
      transition: Transition.noTransition,

    ),
    GetPage(
      name: PageRoutes.WRAPPER,
      transition: Transition.noTransition,
      page: () => MainWrapperScreen(),
    ),

    GetPage(
      name: PageRoutes.HOME,
      transition: Transition.noTransition,
      page: () =>  HomeScreen(),
      binding: HomeState()
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
      name: PageRoutes.DETAILIMAGE,
      transition: Transition.downToUp,
      page: () => DetailImageScreen(),
      bindings: [DetailState() ,         MediaSuitState()],
    ),

    GetPage(
      name: PageRoutes.DETAILMUSIC,
      transition: Transition.downToUp,
      page: () => DetailMusicScreen(),
      bindings: [DetailState() ,         MediaSuitState()],
    ),
    //
    GetPage(
      name: PageRoutes.DETAILTEXT,
      transition: Transition.downToUp,
      page: () => DetailTextScreen(),
      bindings: [DetailState() ,         MediaSuitState()],
    ),

    GetPage(
      name: PageRoutes.DETAILVIDEO,
      transition: Transition.downToUp,
      page: () => DetailVideoScreen(),
      bindings: [
        DetailState(),
        MediaSuitState()
      ]

    ),
    GetPage(
      name: PageRoutes.SETTING,
      transition: Transition.leftToRight,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: PageRoutes.MASSAGE,
      transition: Transition.leftToRight,
      page: () => MassageScreen(),
    ),
    GetPage(
      name: PageRoutes.INTRO,
      transition: Transition.downToUp,
      page: () => IntroPage(),
    ),
    GetPage(
      name: PageRoutes.UPLOAD,
      transition: Transition.noTransition,
      page: () => UploadScreen(),
    ),

    GetPage(
      name: PageRoutes.COMMENT,
      transition: Transition.downToUp,
      page: () => CommentScreen(),
      binding: DetailState(),
    ),
    GetPage(
      name: PageRoutes.PLUS,
      transition: Transition.downToUp,
      page: () => PlusSectionPage(),



    ),

    GetPage(
      name: PageRoutes.LIVE,
      transition: Transition.fadeIn,
      page: () => LiveScreen(),
      binding: LiveState(),
    ),

    GetPage(
      name: PageRoutes.ViewAllChannel,
      transition: Transition.rightToLeft,
      page: () => ViewAllChannelScreen(),
      binding: ViewAllChannelState(),
    ),
    GetPage(
      name: PageRoutes.ALLTOOLS,
      transition: Transition.rightToLeft,
      page: () => AllToolsScreen(),
    ),
    GetPage(
      name: PageRoutes.EDITPROFILE,
      transition: Transition.rightToLeft,
      page: () => EditProfilePage(),
    ),

    GetPage(
      name: PageRoutes.VIDEOEDITOR,
      transition: Transition.rightToLeft,
      page: () => VideoEditorScreen(),
      binding: VideoEditorState()
    ),
    GetPage(
      name: PageRoutes.CHANGEPASSWORD,
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: PageRoutes.MEDIASUIT,
        transition: Transition.rightToLeft,

        page: () => MediaSuitScreen(),
      bindings:       [  MediaSuitState() , DetailState()]
    ),
    GetPage(
      name: PageRoutes.SHAREACCOUNT,
      page: () => ShareAccountPage(),

    ),

  ];
}

class ServerRoute {
  static const SIGNIN = 'general/signin';

}
