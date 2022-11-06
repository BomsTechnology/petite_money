import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/scanner_page.dart';

class AmountPage extends StatefulWidget {
  const AmountPage({super.key, required this.type});
  final int type;
  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  final amountController = TextEditingController();
  List assets = [
    {
      "title": "Transfert d'argent",
      "image": "assets/transfert.png",
    },
    {
      "title": "Dépôt d'argent",
      "image": "assets/depot.png",
    },
    {
      "title": "Retrait d'argent",
      "image": "assets/retrait.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dGreen,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: bgGray,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Image.asset(
                assets[widget.type]["image"],
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              assets[widget.type]["title"],
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Entrez le montant',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 120,
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  suffix: Text("XFA", style: GoogleFonts.ubuntu()),
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScannerPage(),
                    ),
                  );
                },
                child: Text(
                  'Transférer',
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
