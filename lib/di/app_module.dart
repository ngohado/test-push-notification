import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:test_push_notification/data/entities/message_entity.dart';
import 'package:test_push_notification/firebase_options.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseApp> get firebaseApp async => await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

  @singleton
  Future<Isar> get isar async => await Isar.open([MessageEntitySchema]);
}
