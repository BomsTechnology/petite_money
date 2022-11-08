import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/login_page.dart';
import 'package:petite_money/pages/otp_page.dart';
import 'package:petite_money/utils/flash_message.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  bool _isLoading = false;
  String image = "";
  final List<String> accountTypeItems = [
    "Particulier",
    "Commerçant",
  ];

  final List correctNumOr = [
    "690",
    "691",
    "692",
    "693",
    "694",
    "695",
    "696",
    "697",
    "698",
    "699",
    "680",
    "655",
    "656",
    "657",
    "658",
    "659",
  ];

  final List correctNumMtn = [
    "670",
    "671",
    "672",
    "673",
    "674",
    "675",
    "676",
    "677",
    "678",
    "679",
    "680",
    "650",
    "651",
    "652",
    "653",
    "654",
  ];
  String? accountType = "Particulier";

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: isKeyboard ? 10 : 10 + MediaQuery.of(context).padding.top,
            bottom: 18,
            left: 18,
            right: 18,
          ),
          child: isKeyboard
              ? SingleChildScrollView(
                  child: buildForm(isKeyboard),
                )
              : buildForm(isKeyboard),
        ),
      ),
    );
  }

  Widget buildForm(bool isKeyboard) => Column(
        children: [
          isKeyboard
              ? Container()
              : Text(
                  'Entrez vos informations pour vous enregistrer',
                  style: GoogleFonts.ubuntu(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const SizedBox(
            height: 50,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nom complet",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length > 1
                        ? null
                        : 'Entrez votre nom',
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Numéro de téléphone",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 9 &&
                          (correctNumMtn.contains(value.substring(0, 3)) ||
                              correctNumOr.contains(value.substring(0, 3)))) {
                        setState(() {
                          image = correctNumMtn.contains(value.substring(0, 3))
                              ? "assets/mtnlogo.png"
                              : "assets/orangelogo.png";
                        });
                      } else {
                        setState(() {
                          image = "";
                        });
                      }
                    },
                    validator: (value) => value != null &&
                            value.length == 9 &&
                            (correctNumMtn.contains(value.substring(0, 3)) ||
                                correctNumOr.contains(value.substring(0, 3)))
                        ? null
                        : 'Numéro de téléphone incorrect',
                    decoration: InputDecoration(
                      prefix: const Text(
                        '237',
                        style: TextStyle(color: Colors.grey),
                      ),
                      suffix: image != ""
                          ? SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                image,
                              ),
                            )
                          : const SizedBox(
                              width: 1,
                              height: 1,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Type de compte",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      items: accountTypeItems
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.ubuntu(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              )))
                          .toList(),
                      value: accountType,
                      onChanged: (value) => {
                            setState(() {
                              accountType = value;
                            })
                          }),
                ),
              ],
            ),
          ),
          isKeyboard
              ? const SizedBox(
                  height: 50,
                )
              : const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: register,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'S\'inscrire',
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Déjà un compte ?",
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Se Connecter",
                  style: GoogleFonts.ubuntu(
                    color: dGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      );

  register() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    db
        .collection('users')
        .where('phone', isEqualTo: "237${phoneController.text}")
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
        FlashMessage.showSnackBar("Ce compte exite déja", context);
      } else {
        Map<String, dynamic> creds = {
          'phone': "237${phoneController.text}",
          'name': nameController.text.trim(),
          'accountType': accountType,
          'operator':
              correctNumMtn.contains(phoneController.text.substring(0, 3))
                  ? 'Mtn'
                  : 'Orange',
        };
        await auth.verifyPhoneNumber(
          phoneNumber: '+237${phoneController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print(e.message.toString());
            FlashMessage.showSnackBar(e.message.toString(), context);
            setState(() {
              _isLoading = false;
            });
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPPage(
                  phone: '+237${phoneController.text}',
                  verificationId: verificationId,
                  creds: creds,
                ),
              ),
            );
            setState(() {
              _isLoading = false;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // FlashMessage.showSnackBar(verificationId, context);
            setState(() {
              _isLoading = false;
            });
          },
        );
      }
    });
  }
}
