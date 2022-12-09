import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_push_notification/di/injection.config.dart';

final getIt = GetIt.instance;

bool _initCompleted = false;
bool get initCompleted => _initCompleted;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  _initCompleted = true;
}
