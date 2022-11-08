import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final User user = FirebaseAuth.instance.currentUser!;

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
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Une Erreur est survenu: ${snapshot.error}"));
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(
                child: Text(
                    "Votre compte rencontre un probleme, veillez contactez l'assistance"));
          } else if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
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
                  widget.type != 0 && !isKeyboard
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['phone'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(data['operator'] == 'Mtn'
                                    ? "assets/mtnlogo.png"
                                    : "assets/orangelogo.png"),
                              ),
                            ],
                          ),
                        )
                      : const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScannerPage(),
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
            );
          } else {
            return const Center(
                child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(strokeWidth: 2),
            ));
          }
        },
      ),
    );
  }
}
