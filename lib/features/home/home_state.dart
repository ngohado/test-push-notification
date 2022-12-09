part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Message>? messages;
  final bool loading;

  const HomeState({
    required this.messages,
    required this.loading,
  });

  const HomeState.init() : this(messages: null, loading: false);

  @override
  List<Object?> get props => [messages, loading];

  HomeState copyWith({
    List<Message>? messages,
    bool? loading,
  }) {
    return HomeState(
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
    );
  }
}
