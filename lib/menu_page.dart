import 'package:flutter/material.dart';
import 'package:flutter_webrtc_mifone/recent_page.dart';

import 'contact_page.dart';
import 'numpad_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int pageIndex = 0;
  final pages = [
    const RecentScreen(),
    const ContactScreen(),
    const NumpadScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7D4BC5),
      ),
      endDrawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
          ),
        ]),
      ),
      body: pages[pageIndex],
      extendBody: true,
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Recent'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_sharp), label: 'Contact'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outlined), label: 'Numpad'),
          ],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff277AB9),
          unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
        ),
      ),
    );
  }
}
