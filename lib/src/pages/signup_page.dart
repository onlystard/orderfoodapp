import 'package:flutter/material.dart';
import 'package:testproject/src/enums/auth_mode.dart';
import 'package:testproject/src/pages/signin_page.dart';
import 'package:testproject/src/scoped-model/main_model.dart';
import 'package:testproject/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  // bool _toggleConfirmVisibility = true;

  String _email;
  String _username;
  String _password;
  // String _confirmPassword;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String email) {
        _email = email;
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Email nhập sai";
        }
        if (email.isEmpty) {
          errorMessage = "Vui lòng nhập email";
        }

        return errorMessage;
      },
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Tài khoản",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String username) {
        _username = username.trim();
      },
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "Vui lòng nhập tên tài khoản";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Mật khẩu",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (String password) {
        _password = password;
      },
      validator: (String password) {
        String errorMessage;

        if (password.isEmpty) {
          errorMessage = "Vui lòng nhập mật khẩu";
        }
        return errorMessage;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Đăng ký",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildUsernameTextField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildEmailTextField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _buildSignUpButton(),
                Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Bạn đã có tài khoản?",
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()));
                      },
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ScopedModelDescendant(
        builder: (BuildContext sctx, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () {
          showLoadingIndicator(context, "Đăng ký...");
          onSubmit(model.authenticate);
        },
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(25.0)),
          child: Center(
            child: Text(
              "Đăng ký",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Map<String, dynamic> userInfo = {
        "email": _email,
        "username": _username,
        "userType": "customer",
      };

      authenticate(_email, _password,
              authMode: AuthMode.SignUp, userInfo: userInfo)
          .then((final response) {
        Navigator.of(context).pop();
        if (!response['hasError']) {
          // Todo - Navigate to the homepage
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed("/mainscreen");
        } else {
          // todo - display the error message in the snackbar
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
              content: Text(response['message']),
            ),
          );
        }
      });
    }
  }
}