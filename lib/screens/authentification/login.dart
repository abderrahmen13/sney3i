import 'dart:async';

import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/screens/authentification/register.dart';
import 'package:snay3i/screens/nav/bottom_nav_screen.dart';
import 'package:snay3i/services/authentication.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription? internetconnection;
  bool isoffline = true;
  bool showSpinner = false;
  bool isButtonActive = false;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuths firebaseAuths = FirebaseAuths();
  FirebaseAuths userAuth = FirebaseAuths();

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    controllerEmail.addListener(() {
      final isButtonActive = controllerEmail.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    Future(() {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.orange.shade100,
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 30),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                      AppLocalizations.of(context)!
                          .verification_email_has_been_sent,
                      style: const TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ));
      }
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final email = ModalRoute.of(context)!.settings.arguments;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      controllerEmail.text =
          ModalRoute.of(context)!.settings.arguments.toString();
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Image(
                width: 30,
                image: AssetImage('assets/images/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
              ),
              Text("Sney3i", style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(AppLocalizations.of(context)!.sign_in,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Container(padding: const EdgeInsets.only(top: 10)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: AppLocalizations.of(context)!.your_email,
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
                                  .hasMatch(value);
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
                        TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText:
                                AppLocalizations.of(context)!.your_Password,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          controller: controllerPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .password_required;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: ElevatedButton(
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
                                // Login
                                Map user = await firebaseAuths.signIn(
                                    controllerEmail.text,
                                    controllerPassword.text,
                                    context);
                                if (user.containsKey('uid')) {
                                  // Local values
                                  Proffessionel? profile =
                                      await userAuth.getCurrentUser();
                                  if (profile != null &&
                                      profile.status.toString() == "verified") {
                                    preferences.setUser(profile);
                                    preferences.setStringValue(
                                        "userEmail", controllerEmail.text);
                                    preferences.setStringValue(
                                        'uid', user['uid']);
                                    preferences.setBoolValue('keeplogin', true);
                                    preferences.setStringValue(
                                        'loginType', 'emailAndPassword');
                                    controllerEmail.clear();
                                    controllerPassword.clear();
                                    // Redirection
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const BottomNavView(),
                                        ));
                                  } else {
                                    setState(() {
                                      showSpinner = false;
                                      isButtonActive = true;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red.shade100,
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.warning_amber_rounded,
                                                color: Colors.red, size: 30),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Text(AppLocalizations.of(context)!.your_account_not_validated_administrator,
                                                  style: const TextStyle(
                                                      color: Colors.black)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                                  }
                                } else {
                                  setState(() {
                                    showSpinner = false;
                                    isButtonActive = true;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red.shade100,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                              size: 30),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Text(user['error'],
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
                            AppLocalizations.of(context)!.sign_in,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                          AppLocalizations.of(context)!.you_agree_to_our_terms,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 114, 113, 113)))),
                  Container(
                      //width: double.infinity,
                      margin: const EdgeInsets.only(top: 30.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register(profile: Proffessionel())),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.sign_up,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.deepPurple),
                            textAlign: TextAlign.left,
                          ))),
                  Text(AppLocalizations.of(context)!.you_have_any_issues,
                      style: const TextStyle(fontSize: 16)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
