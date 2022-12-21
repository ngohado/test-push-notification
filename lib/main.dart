import 'package:flutter/material.dart';
import 'package:test_push_notification/app.dart';
import 'package:test_push_notification/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
