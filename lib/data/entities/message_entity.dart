import 'package:isar/isar.dart';

part 'message_entity.g.dart';

@collection
@Name('messages')
class MessageEntity {
  Id id;
  String title;
  String message;

  MessageEntity({
    required this.id,
    required this.title,
    required this.message,
  });
}
