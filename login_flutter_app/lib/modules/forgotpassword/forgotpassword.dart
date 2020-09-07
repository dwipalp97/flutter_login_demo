import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_flutter_app/utils/BaseAlertDialog.dart';
import 'package:login_flutter_app/utils/ColorConstants.dart';
import 'package:login_flutter_app/utils/ProgressDIalog.dart';
import 'package:login_flutter_app/utils/Validation.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController();
  final password = TextEditingController();
  var progress = null;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Raleway', fontSize: 15.0);
    final FocusNode _emailFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();
    progress = ProgressDialog(context);

    final emailField = TextFormField(
      obscureText: false,
      controller: email,
      style: style,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
        _fieldFocusChange(context, _emailFocus, _passwordFocus);
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
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          hintText: "Password",
          suffixIcon: Icon(Icons.lock),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    final sendButton = Column(
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

              if (isValid()) {
                progress.showProgress();
                // callLoginApi();
                /* Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Home")
              ));*/
              }
            },
            child: Text("Send",
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
                  child: Text("Forgot Password?",
                      textAlign: TextAlign.center,
                      style: style.copyWith(color: Colors.black, fontWeight: FontWeight.w700)),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(
                  height: 20.0,
                ),
                sendButton,
                SizedBox(
                  height: 20.0,
                ),
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

  /*pass focus to the next formfield*/
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

/*call login api*/
/*Future<LoginBaseResponseModel> callLoginApi() async {
    final loginBodyParam = {
      "username": email.text,
      "password": password.text,
      "is_social": "false"
    };

    final response = await http.post(
        'https://www.studycloud.in/api/v1/accounts/login/',
        body: loginBodyParam);
    progress.hideProgress();

    if (response.statusCode == 200) {

      LoginBaseResponseModel loginResponse = LoginBaseResponseModel.fromJson(json.decode(response.body));;

      // If the serverdid return a 200 OK response, then parse the JSON.
      debugPrint("login Response===" + response.body.toString());
      if(loginResponse.status ==200){
        SharedPreference().storeLoginUserData(
            LoginBaseResponseModel.fromJson(json.decode(response.body)));

        SharedPreference().setUserLogin(true);

        debugPrint("login GetResponse===" +SharedPreference().getLoginUserDetails().toString());

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: "Home")
        ));
      }else{
        SimpleAlertDialog("Alert", loginResponse.message, context)
            .simpleAlert();
      }

    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to login');
    }
  }*/
}
