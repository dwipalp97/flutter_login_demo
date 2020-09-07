import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_flutter_app/modules/forgotpassword/forgotpassword.dart';
import 'package:login_flutter_app/utils/BaseAlertDialog.dart';
import 'package:login_flutter_app/utils/ColorConstants.dart';
import 'package:login_flutter_app/utils/ProgressDIalog.dart';
import 'package:login_flutter_app/utils/Validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loginState();
}

class _loginState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  var progress = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'OverpassRegular', fontSize: 15.0);

    final FocusNode _passwordFocus = FocusNode();
    final FocusNode _emailFocus = FocusNode();
    progress = ProgressDialog(context);

    final emailField = TextFormField(
      controller: email,
      style: style,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        _passwordFocus.requestFocus();
      },
      onTap: () {
        _passwordFocus.unfocus();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          hintText: "Email",
          suffixIcon: Icon(Icons.email),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final passwordField = TextFormField(
      obscureText: true,
      controller: password,
      style: style,
      focusNode: _passwordFocus,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
        _emailFocus.unfocus();
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          hintText: "Password",
          suffixIcon: Icon(Icons.lock),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final loginButton = Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ThemeBlueDark,
                ThemeBlueLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            onPressed: () {
              //dismiss keyboard
              SystemChannels.textInput.invokeMethod('TextInput.hide');

              if (isValid()) {
                //progress.showProgress();
                simpleAlert("Login", "Congratulations!! you have logged in successfully", context);
              }
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );

    final signUpButton = Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ThemeBlueDark,
                ThemeBlueLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            onPressed: () {
              //dismiss keyboard
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Text("SignUp",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "assets/image/logo.png",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  child: Text("Login",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 20.0,
                ),
                loginButton,
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text("Forgot Password?",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: ThemeBlueLight,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*check given email and password is valid*/
  bool isValid() {
    if (email.text.isEmpty) {
      simpleAlert("Alert", "Please enter email id", context);
      return false;
    } else if (!isEmail(email.text)) {
      simpleAlert("Alert", "Please enter valid email id", context);
      return false;
    } else if (password.text.isEmpty) {
      simpleAlert("Alert", "Please enter password", context);
      return false;
    }
    return true;
  }
}
