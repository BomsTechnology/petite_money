import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.getIsDarkMode
              ? Color(0xFF00001a)
              : Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            leading: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marcelin Sigha',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '237658401181',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 4, bottom: 5),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.list_alt_rounded,
                    color: dGreen,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
            backgroundColor: dGreen,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listing des transactions',
                  style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
