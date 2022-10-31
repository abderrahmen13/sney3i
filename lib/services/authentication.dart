import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
/// for Firebase
///
class FirebaseAuths {
  //To create new User
  Future<Map> createUserAuth(Proffessionel profile, String language, context) async {
    if (kDebugMode) {
      print('-- CREATE USER 1 --');
      print(profile.email);
      print(profile.password);
      print(language);
    }
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firebaseAuth.setLanguageCode(language);
      UserCredential authres =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: profile.email!, password: profile.password!);
      User? user = authres.user;
      if (user != null) {
        await user.updateDisplayName(profile.firstname);
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        if (kDebugMode) {
          print('-- CREATE USER 2 --');
          print(user);
        }
        return {'uid': user.uid};
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          'error': AppLocalizations.of(context)!.the_password_provided_weak
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          'error': AppLocalizations.of(context)!.the_account_already_exists
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return {'error': AppLocalizations.of(context)!.something_wrong};
  }

  Future<bool> resetPassword(String email) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  //To verify new User
  Future<Map> signIn(String email, String password, context) async {
    try {
      UserCredential authres = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = authres.user;
      if (user != null && user.emailVerified) {
        return {'uid': user.uid};
      } else {
        if (user == null) {
          return {'error': AppLocalizations.of(context)!.something_wrong};
        } else {
          await user.sendEmailVerification();
          return {
            'error': AppLocalizations.of(context)!.your_account_not_valid
          };
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {'error': AppLocalizations.of(context)!.no_user_found};
      } else if (e.code == 'wrong-password') {
        return {'error': AppLocalizations.of(context)!.wrong_password_provided};
      } else if (e.code == 'invalid-email') {
        return {'error': AppLocalizations.of(context)!.your_account_not_valid};
      } else if (e.code == 'user-disabled') {
        return {'error': AppLocalizations.of(context)!.your_account_disabled};
      }
    }
    return {'error': AppLocalizations.of(context)!.something_wrong};
  }

  Future<void> saveToken() async {
    User? user = await currentUserObject();
    var jwt = await user!.getIdToken();
    preferences.setStringValue('token', jwt);
  }

  Future<String> getToken() async {
    User? user = await currentUserObject();
    var jwt = await user!.getIdToken(true);
    return jwt;
  }

  Future<String?> currentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<String?> currentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email;
    }
    return null;
  }

  Future<User?> currentUserObject() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<Proffessionel?> getCurrentUser() async {
    //Récupère le user si demandé
    var email = await currentUserEmail();
    if (email != null) {
      return await userRop.getUserByEmail(email);
    }
    return null;
  }

  Future<String> updateCurrentUserPassword(String newPassword, context) async {
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
      return AppLocalizations.of(context)!.password_updated_successfully;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AppLocalizations.of(context)!.the_password_provided_weak;
      }
    }
    return AppLocalizations.of(context)!.something_wrong;
  }
}
