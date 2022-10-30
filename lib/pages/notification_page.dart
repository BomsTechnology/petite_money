import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dGreen,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Notification",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
