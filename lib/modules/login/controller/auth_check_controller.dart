import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/modules/homepage/view/homepage_view.dart';
import 'package:mynotes/modules/login/view/login_view.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            var user = snapshot.data;
            if (user != null ||
                snapshot.connectionState == ConnectionState.done) {
              return HomePage();
            } else {
              return LoginView();
            }
          }
        },
      ),
    );
  }
}
