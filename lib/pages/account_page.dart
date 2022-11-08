import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/onboarding_page.dart';
import 'package:petite_money/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool withBiomrtric = false;
  final User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    var names = user.displayName.toString().split(" ");
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
          "Mon Compte",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: bgGray,
                    child: Text(
                      '${names[0][0].toUpperCase()}${names.length > 1 ? names[1][0].toUpperCase() : ""}',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w700,
                        color: dGreen,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.displayName}",
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "${user.phoneNumber}",
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Sécurité",
                style: GoogleFonts.ubuntu(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SwitchListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      "Biométrie",
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      withBiomrtric ? "Activé" : "Désactivé",
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                secondary: const Icon(
                  Icons.fingerprint_rounded,
                  color: dGreen,
                  size: 30,
                ),
                value: withBiomrtric,
                onChanged: (bool value) {
                  setState(() {
                    withBiomrtric = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Thème",
                style: GoogleFonts.ubuntu(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SwitchListTile(
                title: Text(themeProvider.getIsDarkMode ? 'Sombre' : 'Clair',
                    style: GoogleFonts.ubuntu(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                secondary: Icon(
                  themeProvider.getIsDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: dGreen,
                  size: 30,
                ),
                value: themeProvider.getIsDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    themeProvider.toogleTheme(value);
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Autres",
                style: GoogleFonts.ubuntu(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: null,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.question_mark_outlined,
                      color: dGreen,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Aide",
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: null,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.share,
                      color: dGreen,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Partager",
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: null,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.supervised_user_circle_rounded,
                      color: dGreen,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "A Propos de nous",
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                  );
                  // }
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Déconnexion",
                      style: GoogleFonts.ubuntu(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
