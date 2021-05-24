import 'package:x_app/internal/executive/session_executive.dart';
import 'package:x_app/internal/model/DTO/user_dto.dart';
import 'package:x_app/internal/service/auth_service.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends BasePage {
  LoginPage() : super(stateConnective: PageState()) {
    print(this.toStringShort() + " Başlatıldı");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      // navigation bar color
      statusBarIconBrightness: Brightness.dark,
      // status ba
      systemNavigationBarIconBrightness: Brightness.dark,
      //navigation bar icons' color

      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarColor: Colors.white,
      // navigation bar color
      statusBarColor: Colors.white,
    ));
  }
}

class PageState extends State<LoginPage> {
  bool isGirisHoveredBtn = false;
  bool processStatu = false;

  String errorMessage = "";

  TextEditingController _usermail = new TextEditingController();
  TextEditingController _userpassword = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  login() async {
    try {
      setState(() {
        processStatu = true;
      });
      if (_usermail.text == "" || _userpassword.text == "") {
        errorMessage = "E-posta veya şifre boş geçilemez.";
        setState(() {
          processStatu = false;
        });
      } else {
        LoginService loginService = new LoginService();
        bool isOK = await loginService.auth(_usermail.text, _userpassword.text);
        if (isOK) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
        } else {
          setState(() {
            processStatu = false;
          });
          errorMessage = "Kullanıcı bulunamadı.";
        }
      }
    } on Exception catch (_) {
      setState(() {
        processStatu = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      //navigation bar icons' color
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.black,
      // navigation bar color
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_template.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.99,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                  decoration: BoxDecoration(),
                  child: processStatu
                      ? Text("Giriş Yapılıyor...")
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new TextFormField(
                              controller: _usermail,
                              decoration: new InputDecoration(
                                labelText: "E-POSTA",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                ),
                                border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(203, 93, 34, 1),
                                      width: 5,
                                      style: BorderStyle.solid),
                                ),
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.blue,
                                      width: 5,
                                      style: BorderStyle.solid),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "E-POSTA boş geçilemez!";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                  fontFamily: "Poppins", color: Colors.white),
                            ),
                            Text(""),
                            new TextFormField(
                              controller: _userpassword,
                              obscureText: true,
                              decoration: new InputDecoration(
                                labelText: "Şifre",
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                ),
                                border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color.fromRGBO(203, 93, 34, 1),
                                      width: 5,
                                      style: BorderStyle.solid),
                                ),
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.blue,
                                      width: 5,
                                      style: BorderStyle.solid),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Şifre boş geçilemez!";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                  fontFamily: "Poppins", color: Colors.white),
                            ),
                            Text(""),
                            Text(
                              errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Text(""),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              onPressed: () {
                                login();
                              },
                              onHighlightChanged: (s) {
                                setState(() {
                                  isGirisHoveredBtn = s;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 0),
                                decoration: BoxDecoration(
                                  color: !isGirisHoveredBtn
                                      ? Color.fromRGBO(203, 93, 34, 1)
                                      : Colors.deepOrange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Giriş yap",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
