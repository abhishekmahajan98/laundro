import 'package:flutter/material.dart';
import 'package:laundro/components/home_screen.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/screen_model.dart';

import 'package:laundro/pages/cart_page.dart';
import 'package:laundro/pages/my_account.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _pageTitles = [
    'Home',
    'Cart',
    'My Account',
  ];

  final List<Widget> _pages = [
    HomeScreen(),
    CartPage(),
    MyAccount(),
  ];

  BottomNavigationBarItem _buildNavigationItem(
      int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.blueGrey[200],
      ),
      activeIcon: Icon(
        iconData,
        color: mainColor,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: HomeIdx.selectedIndex == index
                ? Colors.blue
                : Colors.blueGrey[200]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              HomeIdx.selectedIndex = index;
            });
          },
          currentIndex: HomeIdx.selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            _buildNavigationItem(0, Icons.home, _pageTitles[0]),
            _buildNavigationItem(1, Icons.shopping_cart, _pageTitles[1]),
            _buildNavigationItem(2, Icons.person, _pageTitles[2]),
          ],
        ),
        body: _pages[HomeIdx.selectedIndex],
      ),
    );
  }
}
