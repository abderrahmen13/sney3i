
import 'package:snay3i/screens/authentification/login.dart';
import 'package:snay3i/screens/home_screen/diary.dart';
import 'package:snay3i/screens/language.dart';
import 'package:snay3i/screens/me/me.dart';
import 'package:snay3i/screens/me/settings/settings.dart';

class Routes {
  static final all = {
    '/login': (context) => const Login(),
    '/home': (context) => const Diary(),
    '/me': (context) => const Me(),
    '/settings': (context) => const Settings(),
    '/language': (context) => const Language(),
  };
}
