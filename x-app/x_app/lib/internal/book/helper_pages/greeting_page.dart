import 'package:x_app/internal/executive/session_executive.dart';
import 'package:x_app/internal/model/DTO/user_dto.dart';
import 'package:x_app/internal/service/auth_service.dart';
import 'package:x_app/internal/vendor/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class GreetingPage extends BasePage {
  GreetingPage() : super(stateConnective: PageState()) {
    print(this.toStringShort() + " Başlatıldı");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      // navigation bar color
      statusBarIconBrightness: Brightness.light,
      // status ba
      systemNavigationBarIconBrightness: Brightness.light,
      //navigation bar icons' color

      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.black,
      // navigation bar color
      statusBarColor: Colors.black54,
    ));
  }
}

class PageState extends State<GreetingPage> {
  VideoPlayerController _controller;
  bool videoOpen = false;

  @override
  void initState() {
    super.initState();
    login();
  }

  login() async {
    UserDTO _storyUser = await Session.getStoryUser();
    if (_storyUser != null) {
      LoginService loginService = new LoginService();
      bool isOK =
          await loginService.auth(_storyUser.username, _storyUser.password);
      if (isOK) {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
      } else {
        videoControl();
      }
    } else {
      videoControl();
    }
  }

  videoControl() {
    Session.isADBVideo().then((value) {
      if (value) {
        this.next(false);
      } else {
        setState(() {
          videoOpen = true;
        });
        _controller = VideoPlayerController.asset('assets/greeting.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            _controller.play();
            setState(() {});
          });
        _controller.addListener(checkVideo);
      }
    });
  }

  void checkVideo() {
    if (_controller.value.position >= _controller.value.duration) {
      SharedPreferences.getInstance().then((value) {
        value.setString("adb_video", Session.aDBVideo);
      });
      setState(() {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      });
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void next(bool isInit) async {
    if (!isInit) {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("adb_video", Session.aDBVideo);
      setState(() {
        _controller.pause();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
          child: videoOpen
              ? (_controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container())
              : Container()),
      floatingActionButton: false //videoOpen
          ? FloatingActionButton(
              onPressed: () {
                this.next(true);
              },
              child: Icon(Icons.skip_next),
            )
          : null,
    );
  }
}
