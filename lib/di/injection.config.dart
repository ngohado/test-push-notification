// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_core/firebase_core.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;
import 'package:test_push_notification/data/repositories/messages_repository.dart'
    as _i5;
import 'package:test_push_notification/data/repositories/repositories.dart'
    as _i7;
import 'package:test_push_notification/di/app_module.dart' as _i8;
import 'package:test_push_notification/features/home/home_cubit.dart' as _i6;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.FirebaseApp>(
      () => appModule.firebaseApp,
      preResolve: true,
    );
    gh.singletonAsync<_i4.Isar>(() => appModule.isar);
    gh.factory<_i5.MessagesRepository>(() => _i5.MessagesRepository());
    gh.factory<_i6.HomeCubit>(
        () => _i6.HomeCubit(messageRepository: gh<_i7.MessagesRepository>()));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
