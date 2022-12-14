import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/otp_page.dart';
import 'package:petite_money/pages/register_page.dart';
import 'package:petite_money/utils/flash_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool _isLoading = false;
  String image = "";
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

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: isKeyboard ? 18 : 30 + MediaQuery.of(context).padding.top,
            bottom: 18,
            left: 18,
            right: 18,
          ),
          child: Column(
            children: [
              isKeyboard
                  ? Container()
                  : Text(
                      'Authentifiez-vous pour acceder à l’app',
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
                                  correctNumOr
                                      .contains(value.substring(0, 3)))) {
                            setState(() {
                              image =
                                  correctNumMtn.contains(value.substring(0, 3))
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
                                (correctNumMtn
                                        .contains(value.substring(0, 3)) ||
                                    correctNumOr
                                        .contains(value.substring(0, 3)))
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
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Se Connecter',
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
                    "Pas encore inscrit ?",
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
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "S'enregistrer",
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
          ),
        ),
      ),
    );
  }

  login() async {
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
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        FlashMessage.showSnackBar("Vous n'avez pas de compte", context);
      } else {
        await auth.verifyPhoneNumber(
          phoneNumber: '+237${phoneController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
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
