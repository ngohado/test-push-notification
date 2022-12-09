import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_notification/di/injection.dart';
import 'package:test_push_notification/domain/models/models.dart';
import 'package:test_push_notification/features/home/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final cubit = getIt.get<HomeCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestNotificationPermission();
    });
    cubit.getAllMessages();
    super.initState();
  }

  void _requestNotificationPermission() async {
    final result = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (result.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      final token = await _firebaseMessaging.getToken();
      print('Token: $token');
    } else if (result.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final cubit = context.read<HomeCubit>();
              cubit.getAllMessages();
            },
            child: const Text('Refresh'),
          ),
          BlocSelector<HomeCubit, HomeState, bool>(
            selector: (state) => state.loading,
            builder: (context, loading) {
              if (loading) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
          Expanded(
            child: BlocSelector<HomeCubit, HomeState, List<Message>?>(
              selector: (state) => state.messages?.reversed.toList(),
              builder: (context, messages) {
                if (messages == null) {
                  // Don't show any view while load messages
                  return Container();
                } else if (messages.isEmpty) {
                  return _emptyMessagesView();
                } else {
                  return _messagesView(messages);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyMessagesView() {
    return const Center(child: Text('There is no message'));
  }

  Widget _messagesView(List<Message> messages) {
    return ListView.separated(
      itemBuilder: (_, index) => _messageItemView(messages[index]),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: messages.length,
    );
  }

  Widget _messageItemView(Message message) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.message),
    );
  }
}
