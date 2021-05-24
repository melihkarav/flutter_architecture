import 'package:x_app/internal/book/helper_pages/greeting_page.dart';
import 'package:x_app/internal/book/helper_pages/login_page.dart';
import 'package:x_app/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      // navigation bar color
      statusBarColor: Colors.transparent,
      // status bar color
      statusBarIconBrightness: Brightness.dark,
      // status ba
      systemNavigationBarIconBrightness:
          Brightness.dark, //navigation bar icons' color
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GreetingPage(),
      theme: ThemeData(
        fontFamily: "LifeSavers",
      ),
      onGenerateRoute: (RouteSettings settings) {
        return NavigatorIncepter.Route(settings);
      },
    );
  }
}
