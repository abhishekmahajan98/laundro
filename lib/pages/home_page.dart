import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/components/home_carousel.dart';
import 'package:laundro/components/home_screen.dart';
import 'package:laundro/components/square_button.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:laundro/pages/cart_page.dart';
import 'package:laundro/pages/my_account.dart';
import '../components/side_drawer.dart';

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(User.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.1,
          title: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/app_logo/LOGO1.png',
                width: 200,
              )),
          centerTitle: true,
          backgroundColor: Color(0XFF6bacde),
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
            ),
          ],
        ),
        //app drawer
        drawer: SideDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xfff2f3f7),
          child: Column(
            children: <Widget>[
              //carousel expanded
              Expanded(
                flex: 2,
                //from components/home_carousel
                child: ImageCarousel(),
              ),
              //rest of buttons
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          SquareButton(
                            marginL: 10,
                            marginT: 10,
                            marginR: 2,
                            marginB: 2,
                            imageRoute: 'images/icons/ii.png',
                            buttonTag: 'Ironing',
                            ontap: () => Navigator.pushNamed(context, '/iron'),
                            //Navigator.pushNamed(context, '/iron'),
                          ),
                          SquareButton(
                            marginL: 2,
                            marginT: 10,
                            marginR: 10,
                            marginB: 2,
                            imageRoute: 'images/icons/washing.png',
                            buttonTag: 'Washing',
                            ontap: () => Navigator.pushNamed(context, '/wash'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          SquareButton(
                            marginL: 10,
                            marginT: 2,
                            marginR: 2,
                            marginB: 2,
                            imageRoute: 'images/icons/dryclean.png',
                            buttonTag: 'Dry Cleaning',
                            ontap: () =>
                                Navigator.pushNamed(context, '/dry-clean'),
                          ),
                          SquareButton(
                            marginL: 2,
                            marginT: 2,
                            marginR: 10,
                            marginB: 2,
                            imageRoute: 'images/cloth_donate.png',
                            buttonTag: 'Donate Clothes',
                            ontap: () =>
                                Navigator.pushNamed(context, '/donate_page'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/new_features');
                          },
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(
                                FontAwesomeIcons.voteYea,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Vote for our next Feature!!',
                                style: kCategoryTextStyle,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int _selectedIndex = 0;

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
        color: Colors.black,
      ),
      activeIcon: Icon(
        iconData,
        color: Colors.blue,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: _selectedIndex == index
                ? Colors.blue
                : Colors.black
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,

        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildNavigationItem(0,Icons.home, _pageTitles[0]),
          _buildNavigationItem(1, Icons.shopping_cart, _pageTitles[1]),
          _buildNavigationItem(2, Icons.person, _pageTitles[2]),

        ],
      ),
      body:_pages[_selectedIndex],
    );
  }
}


