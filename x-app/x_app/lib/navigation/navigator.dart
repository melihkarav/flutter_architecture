import 'package:x_app/internal/book/helper_pages/page_not_found.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:x_app/navigation/pages.dart';
import 'package:x_app/navigation/router.dart';
import 'package:flutter/cupertino.dart';

class NavigatorIncepter {
  static PageRouter Route(RouteSettings settings) {
    Pages pages = new Pages();
    BasePage page;
    try {
      page = pages.get[settings.name];
      if (page == null)
        throw Exception(settings.name + " bu isimde bir sayfa bulunmadı.");
    } catch (ex) {
      page = PageNotFoundPage(
        pageName: settings.name,
      );
    }
    return new PageRouter(
      builder: (_) => page,
      settings: settings,
    );
  }

  static PageRouterSwiper({BuildContext context, String name}) {
    Pages pages = new Pages();
    print(name);
    BasePage page = pages.get[name];
    Navigator.of(context).push(CupertinoPageRoute<Null>(builder: (context) {
      return page;
    }));
  }
}
