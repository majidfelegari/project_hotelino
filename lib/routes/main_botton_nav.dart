import 'package:flutter/material.dart';
import 'package:hotelino/routes/test.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainBottonNav extends StatefulWidget {
  const MainBottonNav({super.key});

  @override
  State<MainBottonNav> createState() => _MainBottonNavState();
}

class _MainBottonNavState extends State<MainBottonNav> {
  late PersistentTabController _controller;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  _buildScreens(){
    return [
      HomePage(),
      FovoritePage(),
      BookingPage(),
      ProfilePage(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, 
      controller: _controller,
      onItemSelected: (value) {},
      screens: [],
      );
  }
}