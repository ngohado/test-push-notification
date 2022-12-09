import 'package:auto_route/auto_route.dart';
import 'package:test_push_notification/features/home/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(page: HomePage, initial: true),
  ],
)
class $AppRouter {}
