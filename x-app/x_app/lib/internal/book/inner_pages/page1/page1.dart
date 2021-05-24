import 'package:x_app/internal/book/layout/inner_layout.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';

class Page1Page extends BasePage {
  Page1Page(animationController)
      : super(stateConnective: PageState(), authority: "page1") {
    print(this.toStringShort() + " Başlatıldı");
  }
}

class PageState extends State<Page1Page> {
  String te = "asd";

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
      child: <Widget>[
        Text(te),
      ],
      pageName: "OrnekPage",
      onBtn: (s) {
        setState(() {
          te = s;
        });
      },
    );
  }
}
