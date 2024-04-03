import 'package:chat/auth/view_model/auth_view_model.dart';
import 'package:chat/chat/data/models/message_model.dart';
import 'package:chat/chat/view/widgets/received_message.dart';
import 'package:chat/chat/view/widgets/sent_message.dart';
import 'package:chat/chat/view_model/chat_states.dart';
import 'package:chat/chat/view_model/chat_view_model.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:chat/shared/widgets/error_indicator.dart';
import 'package:chat/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final viewModel = ChatViewModel();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.roomId = ModalRoute.of(context)!.settings.arguments as String;
      viewModel.getMessagesStream();
      viewModel.currentUser =
          BlocProvider.of<AuthViewModel>(context).currentUser!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Chat App'),
        forceMaterialTransparency: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppTheme.whiteColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: BlocBuilder<ChatViewModel, ChatState>(
                            bloc: viewModel,
                            buildWhen: (previousState, currentState) =>
                                currentState is GetMessagesStreamLoading ||
                                previousState is GetMessagesStreamLoading,
                            builder: (context, state) {
                              if (state is GetMessagesStreamLoading) {
                                return const LoadingIndicator();
                              } else if (state is GetMessagesStreamError) {
                                return const ErrorIndicator();
                              } else if (state is GetMessagesStreamSuccess) {
                                return StreamBuilder(
                                  stream: state.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      messages = snapshot.data!;
                                    }
                                    return ListView.separated(
                                      itemBuilder: (_, index) {
                                        final message = messages[index];
                                        final isMyMessage = viewModel
                                            .isMyMessage(message.senderId);
                                        if (isMyMessage) {
                                          return SentMessage(message);
                                        } else {
                                          return ReceivedMessage(message);
                                        }
                                      },
                                      reverse: true,
                                      itemCount: messages.length,
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 12),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: viewModel.messageController,
                                decoration: const InputDecoration(
                                  hintText: 'Type a message',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.greyColor,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.greyColor,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () => viewModel.sendMessage(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: AppTheme.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fixedSize: const Size(80, 50),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Send'),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.send,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
