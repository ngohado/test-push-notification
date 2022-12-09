import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:test_push_notification/data/entities/message_entity.dart';
import 'package:test_push_notification/di/injection.dart';
import 'package:test_push_notification/domain/models/models.dart';

@injectable
class MessagesRepository {
  Future<Stream<List<Message>>> get messagesWatcher async {
    final isar = await getIt.getAsync<Isar>();
    return isar.messageEntitys.where().watch().map(
      (messageEntities) {
        return messageEntities
            .map((entity) =>
                Message(title: entity.title, message: entity.message))
            .toList();
      },
    );
  }

  Future<void> saveMessage(Message message) async {
    final isar = await getIt.getAsync<Isar>();
    await isar.writeTxn(() async {
      await isar.messageEntitys.put(
        MessageEntity(
          id: Isar.autoIncrement,
          title: message.title,
          message: message.message,
        ),
      );
    });
  }

  Future<List<Message>> getMessages() async {
    final isar = await getIt.getAsync<Isar>();
    final messageEntities = await isar.messageEntitys.where().findAll();
    return messageEntities
        .map((entity) => Message(title: entity.title, message: entity.message))
        .toList(growable: false);
  }
}
