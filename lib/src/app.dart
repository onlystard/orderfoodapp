import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:testproject/src/pages/map_page.dart';
import 'package:testproject/src/pages/signin_page.dart';
import 'package:testproject/src/scoped-model/main_model.dart';
import 'package:testproject/src/screens/main_screen.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food Delivery App",
          theme: ThemeData(primaryColor: Colors.blueAccent),
          // home: GoogleMapDemo(),
          routes: {
            "/": (BuildContext context) => SignInPage(),
            "/mainscreen": (BuildContext context) => MainScreen(),
          },
        ));
  }
}
