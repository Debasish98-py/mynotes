import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mynotes/modules/login/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = Get.context!.height;
    var _width = Get.context!.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _height * 0.15,
            ),
            Container(
              child: Center(
                child: Text(
                  "My Notes",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0A1747),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.35,
            ),
            Container(
              child: Center(
                child: Text(
                  "Login ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0A1747),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            GetBuilder<LoginController>(
                init: LoginController(),
                builder: (_login) {
                  return GestureDetector(
                    onTap: () async {
                      await _login.signInWithGoogle();
                    },
                    child: Container(
                      padding: EdgeInsets.all(14).copyWith(top: 5, bottom: 5),
                      width: _width * 0.8,
                      height: _height * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.indigo),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FaIcon(FontAwesomeIcons.google),
                          Text(
                            "Sign in with google",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
