import 'package:firebase_auth/firebase_auth.dart';
import 'package:snay3i/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool showSpinner = false;
  late TextEditingController controllerEmail;
  bool isButtonActive = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuths firebaseAuths = FirebaseAuths();

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerEmail.addListener(() {
      final isButtonActive = controllerEmail.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                automaticallyImplyLeading: true,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(AppLocalizations.of(context)!.reset_password,
                    style: Theme.of(context).textTheme.headline5)),
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            AppLocalizations.of(context)!
                                .enter_your_email_to_reset_you_password,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: AppLocalizations.of(context)!
                                    .your_Email_Address,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              controller: controllerEmail,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .email_address_required;
                                } else {
                                  bool emailValid = RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value.trim());
                                  if (!emailValid) {
                                    return AppLocalizations.of(context)!
                                        .please_use_valid_email_address;
                                  }
                                }
                                return null;
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // background
                onPrimary: Colors.white, // foreground
                onSurface: Colors.deepPurple,
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: isButtonActive
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                          isButtonActive = false;
                        });
                        try {
                          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                          await firebaseAuth.sendPasswordResetEmail(
                              email: controllerEmail.text.trim());
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.yellow.shade100,
                            content: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: Colors.yellow, size: 30),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .password_reset_email_sent,
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                            ),
                          ));
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            showSpinner = false;
                            isButtonActive = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red.shade100,
                            content: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: Colors.red, size: 30),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(e.message.toString(),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                            ),
                          ));
                        }
                      }
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showSpinner)
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                  if (showSpinner)
                    const SizedBox(
                      width: 10,
                    ),
                  Text(
                    AppLocalizations.of(context)!.reset_password,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
