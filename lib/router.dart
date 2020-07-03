import 'package:flutter/material.dart';
import 'package:ktr_msc_ls1/ui/interfaces/library_interface.dart';
import 'package:ktr_msc_ls1/ui/interfaces/login_interface.dart';
import 'package:ktr_msc_ls1/ui/interfaces/profile_interface.dart';

import 'core/constants/app_contstants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginInterface());

      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) => ProfileInterface());

      case RoutePaths.Library:
        return MaterialPageRoute(builder: (_) => LibraryInterface());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
