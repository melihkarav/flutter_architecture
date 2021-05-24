import 'package:x_app/internal/book/inner_pages/partial/navigation_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InnerLayout extends StatefulWidget {
  InnerLayout({
    Key key,
    @required this.child,
    @required this.pageName,
    @required this.onBtn,
  }) : super(key: key);

  String pageName;
  List<Widget> child;
  String nextPage;
  ValueChanged onBtn;

  @override
  PartialState createState() => PartialState();
}

class PartialState extends State<InnerLayout> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  double initial, distance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      // navigation bar color
      statusBarIconBrightness: Brightness.dark,
      // status ba
      systemNavigationBarIconBrightness: Brightness.dark,
      //navigation bar icons' color

      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      // navigation bar color
      statusBarColor: Colors.white,
    ));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.red,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              child: FlatButton(
                onPressed: () {
                  widget.onBtn("basıldı 1");
                },
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  widget.onBtn("basıldı 2");
                },
              ),
            ),
            Row(
              children: widget.child,
            )
          ],
        ),
      ),
    );
  }
}
