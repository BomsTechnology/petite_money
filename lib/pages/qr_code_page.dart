import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String message = "";
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
          centerTitle: true,
          title: Text(
            "QR CODE",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Marcelin Sigha",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: dGreen,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "237658401181",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              QrImage(
                data: message,
                backgroundColor: Colors.white,
                size: 250,
                version: QrVersions.auto,
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
