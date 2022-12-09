import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_push_notification/data/repositories/repositories.dart';
import 'package:test_push_notification/domain/models/message.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final MessagesRepository _messageRepository;

  HomeCubit({
    required MessagesRepository messageRepository,
  })  : _messageRepository = messageRepository,
        super(const HomeState.init()) {
    _initListeners();
  }

  void _initListeners() async {
    final messagesStream = await _messageRepository.messagesWatcher;
    messagesStream.listen((messages) {
      emit(state.copyWith(messages: messages));
    });
  }

  Future<void> getAllMessages() async {
    emit(state.copyWith(loading: true));
    // Since load too fast, then would like to show loading :D
    await Future.delayed(const Duration(seconds: 2));
    final messages = await _messageRepository.getMessages();
    emit(state.copyWith(messages: messages, loading: false));
  }
}
