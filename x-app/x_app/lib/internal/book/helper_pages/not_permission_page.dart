import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';

class NotPermissionPageState extends State<BasePage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            margin: EdgeInsets.only(bottom: 20, top: 30),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset("resources/enexacloud_logo_yesil.png"),
          ),
          Text(
            "Bu sayfa için yetkiniz yok.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Geri dön",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          Image.asset(
            "resources/niltek_logo.jpg",
            fit: BoxFit.fitWidth,
            width: 100,
          ),
        ],
      ),
    );
  }
}
