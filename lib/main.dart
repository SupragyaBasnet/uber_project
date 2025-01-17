import 'package:flutter/cupertino.dart';
import 'package:uber_mobile_app_project/app/app.dart';
import 'package:uber_mobile_app_project/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    App(),
  );
}
