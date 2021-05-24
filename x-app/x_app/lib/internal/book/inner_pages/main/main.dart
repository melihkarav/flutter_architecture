import 'package:x_app/internal/book/layout/inner_layout.dart';
import 'package:x_app/internal/service/data_service.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';

class MainPage extends BasePage {
  MainPage() : super(stateConnective: PageState(), authority: "main") {
    print(this.toStringShort() + " Başlatıldı");
  }
}

class PageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
