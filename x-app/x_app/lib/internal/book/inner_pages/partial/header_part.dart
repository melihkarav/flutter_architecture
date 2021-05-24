import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderPart extends StatefulWidget {
  HeaderPart({
    Key key,
    this.onBirimChanged,
  }) : super(key: key);

  ValueChanged onBirimChanged;

  @override
  PartialState createState() => PartialState();
}

class PartialState extends State<HeaderPart>
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
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          "resources/enexacloud_logo_yesil.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
