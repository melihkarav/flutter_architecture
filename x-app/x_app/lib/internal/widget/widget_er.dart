import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WigetERWidget extends StatefulWidget {
  WigetERWidget({
    Key key,
  }) : super(key: key);

  @override
  ComponentState createState() => ComponentState();
}

class ComponentState extends State<WigetERWidget>
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
    return Center(
      child: Container( ),
    );
  }
}