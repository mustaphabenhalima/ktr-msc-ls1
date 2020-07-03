import 'package:flutter/material.dart';
import 'package:ktr_msc_ls1/core/services/localstorage_service.dart';
import 'package:ktr_msc_ls1/provider_setup.dart';
import 'package:ktr_msc_ls1/router.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_contstants.dart';
import 'core/models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = RoutePaths.Login;
  User user = await LocalStorageService().getUser();
  if(user!= null){
    initialRoute = RoutePaths.Library;
  }
  runApp(MyApp(initialRoute:initialRoute));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String initialRoute;
  MyApp({this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'ktr-msc-ls1 Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
