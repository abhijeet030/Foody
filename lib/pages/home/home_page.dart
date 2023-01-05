import 'package:flutter/material.dart';
import 'package:foody/pages/auth/sign_in_page.dart';
import 'package:foody/pages/auth/sign_up_page.dart';
import 'package:foody/pages/cart/cart_history.dart';
import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/pages/profile/profile_screen.dart';
import 'package:foody/utils/colors.dart';
import 'package:foody/utils/dymansion.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _page = <Widget>[
    MainFoodPage(),
    Container(
      child: Center(child: BigText(text: "page 2")),
    ),
    CartHistory(),
    AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _page.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFe8e8e8),
              blurRadius: 5.0,
              offset: Offset(5, 0),
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(5, 0),
            )
          ],
        ),
        child: GNav(
            tabBorderRadius: Dimensions.corner30,
            curve: Curves.easeInSine,
            backgroundColor: Colors.white,
            color: AppColors.yellowColor,
            activeColor: AppColors.mainColor,
            tabBackgroundColor: Colors.white,
            gap: Dimensions.height10,
            tabShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.03),
                spreadRadius: Dimensions.font5,
                blurRadius: Dimensions.height7,
                offset:
                    Offset(0, Dimensions.size3), // changes position of shadow
              ),
            ],
            haptic: true,
            padding: EdgeInsets.all(Dimensions.height20),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.archive_outlined,
                text: 'History',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
      ),
    );
  }
}
