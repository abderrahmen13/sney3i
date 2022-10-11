import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/services/authentication.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final Proffessionel profile;
  const Register({Key? key, required this.profile}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showSpinner = false;
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  bool isButtonActive = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuths firebaseAuths = FirebaseAuths();

  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    controllerEmail.addListener(() {
      final isButtonActive = controllerEmail.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
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
                title: Text(AppLocalizations.of(context)!.sign_up,
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
                                .enter_your_email_to_get_your_personal_meal_plan,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Text(
                            AppLocalizations.of(context)!
                                .we_respect_your_privacy,
                            style: const TextStyle(fontSize: 20),
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
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: AppLocalizations.of(context)!
                                    .your_Full_name,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              controller: controllerName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .full_name_required;
                                } else {
                                  bool nameValid = RegExp(r'^[A-za-z ]+$')
                                      .hasMatch(value.trim());
                                  if (!nameValid) {
                                    return AppLocalizations.of(context)!
                                        .only_alphabetical_characters;
                                  }
                                }
                                widget.profile.firstname = value;
                                return null;
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
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
                                widget.profile.email = value.trim();
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
                                } else if (value.length < 6) {
                                  return AppLocalizations.of(context)!
                                      .password_must_be_6_characters_or_more;
                                }
                                widget.profile.password = value;
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
                        // create auth (firebase)
                        Map user = await firebaseAuths.createUserAuth(
                            widget.profile,
                            await preferences.getStringValue('language') ??
                                'fr',
                            context);
                        if (user.containsKey('uid')) {
                          widget.profile.uid = user['uid'];
                          // create user to database (mysql)
                          await http.post(
                              Uri.parse(
                                  'https://sney3i.epsrd.com/api/register'),
                              body: {
                                "Role": "client",
                                "first_name": widget.profile.firstname ?? "",
                                "last_name": widget.profile.lastname ?? "",
                                "email": widget.profile.email ?? "",
                                "password": widget.profile.password ?? "",
                                "uid": widget.profile.uid ?? ""
                              });
                          // Redirection
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', ModalRoute.withName('/'),
                              arguments: widget.profile.email);
                        } else {
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
                    AppLocalizations.of(context)!.continuee,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
