import 'package:chat/auth/data/models/user_model.dart';
import 'package:chat/chat/data/models/message_model.dart';
import 'package:chat/chat/view_model/chat_states.dart';
import 'package:chat/shared/database_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewModel extends Cubit<ChatState> {
  ChatViewModel() : super(ChatInitial());

  final messageController = TextEditingController();
  late final UserModel currentUser;
  late final String roomId;

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) return;
    emit(SendMessageLoading());
    try {
      final message = MessageModel(
        content: messageController.text,
        dateTime: DateTime.now(),
        senderId: currentUser.id,
        senderName: currentUser.name,
        roomId: roomId,
      );
      messageController.clear();
      await DatabaseUtils.insertMessageToRoom(message);
      emit(SendMessageSuccess());
    } catch (error) {
      emit(SendMessageError());
    }
  }

  Future<void> getMessagesStream() async {
    emit(GetMessagesStreamLoading());
    try {
      final messagesStream = DatabaseUtils.getRoomMessages(roomId);
      emit(GetMessagesStreamSuccess(messagesStream));
    } catch (error) {
      emit(GetMessagesStreamError());
    }
  }

  bool isMyMessage(String messageId) => messageId == currentUser.id;

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
