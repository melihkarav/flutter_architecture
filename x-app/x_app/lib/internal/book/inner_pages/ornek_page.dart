import 'package:x_app/internal/book/layout/inner_layout.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';

class OrnekPage extends BasePage {
  OrnekPage(animationController)
      : super(stateConnective: PageState(), authority: "Ornek") {
    print(this.toStringShort() + " Başlatıldı");
  }
}

class PageState extends State<OrnekPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerLayout(
      child: <Widget>[],
      pageName: "OrnekPage",
    );
  }
}
