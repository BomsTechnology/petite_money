import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/account_page.dart';
import 'package:petite_money/pages/amount_page.dart';
import 'package:petite_money/pages/notification_page.dart';
import 'package:petite_money/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            title: Text('Petite Money',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 15, bottom: 5),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Text(
                    'MS',
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w700,
                      color: dGreen,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 4, bottom: 5),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_rounded,
                      color: dGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
            backgroundColor: dGreen,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'VOTRE SOLDE EST DE: ',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 12,
                                  color: dGray,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  '1000 XFA',
                                  style: GoogleFonts.ubuntu(
                                    color: dGray,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: InkWell(
                          onTap: null,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                color: dGreen,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'MASQUER MON SOLDE',
                                style: GoogleFonts.ubuntu(
                                  fontSize: 15,
                                  color: dGray,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Paiement',
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCard(
                      action: const AmountPage(type: 0),
                      imagePath: 'assets/transfert.png',
                      label: 'Transfert d\'argent',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Transactions',
                  style: GoogleFonts.ubuntu(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCard(
                      action: const AmountPage(type: 1),
                      imagePath: 'assets/depot.png',
                      label: 'Dépôt d\'argent',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    buildCard(
                      action: const AmountPage(type: 2),
                      imagePath: 'assets/retrait.png',
                      label: 'Retrait d\'argent',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCard({
    required String imagePath,
    required String label,
    required Widget action,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => action,
          ),
        );
      },
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgGray,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: dGray,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
