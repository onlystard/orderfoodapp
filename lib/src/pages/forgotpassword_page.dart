import 'package:flutter/material.dart';
import 'package:testproject/src/pages/signin_page.dart';

class ForgotPassword extends StatelessWidget {
  static String id = 'forgot-password';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Your Email',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email của bạn',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text('Send'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Đăng nhập'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
