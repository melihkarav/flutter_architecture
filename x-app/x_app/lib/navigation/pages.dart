import 'package:x_app/internal/book/helper_pages/log_out_page.dart';
import 'package:x_app/internal/book/helper_pages/login_page.dart';
import 'package:x_app/internal/book/inner_pages/main/main.dart';
import 'package:x_app/internal/vendor/base_page.dart';

class Pages {
  Map<String, BasePage> get = {
    '/login': new LoginPage(),
    '/main': new MainPage(),
    '/logout': new LogoutPage(),
  };
}
