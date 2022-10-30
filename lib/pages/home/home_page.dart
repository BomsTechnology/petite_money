import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/home/screens/home_screen.dart';
import 'package:petite_money/pages/home/screens/listing_screen.dart';
import 'package:petite_money/pages/home/tabbar_widget.dart';
import 'package:petite_money/pages/qr_code_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = <Widget>[
    const HomeScreen(),
    const ListingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    void onChangerTab(int index) {
      setState(() {
        this.index = index;
      });
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: index,
          children: screens,
        ),
        bottomNavigationBar: TabBarWidget(
          index: index,
          onChangerTab: onChangerTab,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.qr_code_rounded,
            color: dYellow,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRCodePage(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
