// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttergram/helpers/navigator.dart';
import 'package:fluttergram/locator.dart';
import 'package:fluttergram/routes/router.dart';
import 'package:fluttergram/ui_shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await setupApp();
  runApp(MyApp());
}

Future<void> setupApp() async {
  try {
    await Firebase.initializeApp();
  } on Exception catch (e) {
    debugPrint('setup firebase error : ${e.toString()}');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavigatorService navigator = locator<NavigatorService>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      navigatorKey: navigator.navigatorKey,
      initialRoute: UIRouter.initialRoute,
      onGenerateRoute: UIRouter.generateRoute,
    );
  }
}
