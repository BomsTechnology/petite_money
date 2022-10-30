import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petite_money/main.dart';
import 'package:petite_money/pages/home/home_page.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    super.key,
    this.creds,
    this.iCode,
    required this.phone,
  });
  final String phone;
  final String? iCode;
  final Map<String, dynamic>? creds;
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool _isLoading = false;
  final character1Controller = TextEditingController();
  final character2Controller = TextEditingController();
  final character3Controller = TextEditingController();
  final character4Controller = TextEditingController();
  String currentCode = "";
  String code = "1234";

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
            child: Column(
              children: [
                isKeyboard
                    ? Container()
                    : Text(
                        'Nous vous avons envoyé un code de verification par SMS',
                        style: GoogleFonts.ubuntu(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${widget.phone.substring(0, 5)}*****${widget.phone.substring(10)}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Changer le numéro de téléphone',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          color: dGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character1Controller,
                          onSaved: (pin1) {},
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          onSaved: (pin2) {},
                          controller: character2Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character3Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              code =
                                  "${character1Controller.text}${character2Controller.text}${character3Controller.text}${character4Controller.text}";
                              FocusScope.of(context).nextFocus();
                              // verify();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: character4Controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "0"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Renvoyer le code',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Valider',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
