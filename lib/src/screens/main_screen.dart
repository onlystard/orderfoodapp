import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testproject/src/admin/pages/add_food_item.dart';
import 'package:testproject/src/pages/signin_page.dart';
import 'package:testproject/src/scoped-model/main_model.dart';

//page
import '../pages/home_page.dart';

import '../pages/order_page.dart';

import '../pages/exprole_page.dart';

import '../pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;
  MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currenTabIndex = 0;

  //page
  List<Widget> page;
  Widget currentPage;
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  // MapsPage mapsPage;
  ProfilePage profilePage;

  @override
  void initState() {
    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage(model: widget.model);
    // mapsPage = MapsPage();
    profilePage = ProfilePage();

    page = [
      homePage,
      favoritePage,
      orderPage,
      // mapsPage,
      profilePage,
    ];
    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            currenTabIndex == 0
                ? "Food App"
                : currenTabIndex == 1
                    ? "Tất cả"
                    : currenTabIndex == 2
                        ? "Orders"
                        // : currenTabIndex == 3
                        //     ? "Map"
                        : "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                // size: 30.0,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            currenTabIndex == 3
                ? ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                    return IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()));
                        model.logout();
                      },
                    );
                  })
                : IconButton(
                    icon: _buildShoppingCart(),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => OrderPage()));
                    },
                  ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddFoodItem()),
                  );
                },
                leading: Icon(Icons.list),
                title: Text(
                  "Add food item",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currenTabIndex = index;
              currentPage = page[index];
            });
          },
          currentIndex: currenTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Order"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.location_on), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: currentPage,
      ),
    );
  }

  Widget _buildShoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart_outlined,
          // size: 30.0,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.red,
            ),
            child: Center(
              child: Text("1",
                  style: TextStyle(fontSize: 12.0, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
