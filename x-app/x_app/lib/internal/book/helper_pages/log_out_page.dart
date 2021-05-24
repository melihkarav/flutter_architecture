import 'package:x_app/internal/executive/session_executive.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogoutPage extends BasePage {
  LogoutPage() : super(stateConnective: PageState()) {
    print(this.toStringShort() + " Başlatıldı");
  }
}

class PageState extends State<LogoutPage> {
  @override
  void initState() {
    super.initState();
    logOutFunc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  logOutFunc() {
    Session.removeUser().then((value) {
      if (value) {
        Fluttertoast.showToast(
          msg: "Çıkış işlemi başarılı!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurpleAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushNamed(context, '/login');
      } else {
        Fluttertoast.showToast(
          msg: "Çıkış işlemi başarısız!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Text("Merhaba"),
      ),
    );
  }
}
