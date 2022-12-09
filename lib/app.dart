import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_push_notification/data/repositories/repositories.dart';
import 'package:test_push_notification/di/injection.config.dart';
import 'package:test_push_notification/di/injection.dart';
import 'package:test_push_notification/domain/models/message.dart';
import 'package:test_push_notification/features/routes.gr.dart';

import 'firebase_options.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();
  final messagesRepository = getIt.get<MessagesRepository>();

  @override
  void initState() {
    _initFirebaseMessagingListeners();
    super.initState();
  }

  void _initFirebaseMessagingListeners() {
    // Show notification on iOS even when foreground.
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    // Listen message on foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground! - ${message.messageId}');
      final title = message.notification?.title ?? 'Title null';
      final body = message.notification?.body ?? 'Body null';
      messagesRepository.saveMessage(Message(title: title, message: body));
    });

    // Listen message on background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (!initCompleted) {
    await configureDependencies();
  }

  final messagesRepository = getIt.get<MessagesRepository>();
  final title = message.notification?.title ?? 'Title null';
  final body = message.notification?.body ?? 'Body null';
  messagesRepository.saveMessage(Message(title: title, message: body));
}
