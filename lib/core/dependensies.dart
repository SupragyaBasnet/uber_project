import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeDependencies() async {
  await Hive.initFlutter();
  await Hive.openBox('rideBox');
  await Hive.openBox('userBox');
}
