import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationPart extends StatefulWidget {
  NavigationPart({
    Key key,
    this.pageName,
    this.animationController,
  }) : super(key: key);
  AnimationController animationController;
  String pageName;

  @override
  PartialState createState() => PartialState();
}

class PartialState extends State<NavigationPart>
    with SingleTickerProviderStateMixin {

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
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }
}
