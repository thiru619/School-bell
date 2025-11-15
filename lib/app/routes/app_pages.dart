import 'package:get/get.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/menu/bindings/menu_bindings.dart';
import '../modules/menu/view/menu_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.signIn;

  static final routes = [
    GetPage(name: '/menu', page: () => MenuPageView(), binding: MenuBinding()),

    GetPage(
      name: Routes.signIn,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(name: Routes.chat, page: () => ChatView(), binding: ChatBinding()),
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
