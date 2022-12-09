import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String title;
  final String message;

  const Message({
    required this.title,
    required this.message,
  });

  @override
  List<Object?> get props => [
        title,
        message,
      ];
}
