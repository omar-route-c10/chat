import 'package:chat/chat/data/models/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageLoading extends ChatState {}

class SendMessageSuccess extends ChatState {}

class SendMessageError extends ChatState {}

class GetMessagesStreamLoading extends ChatState {}

class GetMessagesStreamSuccess extends ChatState {
  final Stream<List<MessageModel>> stream;

  GetMessagesStreamSuccess(this.stream);
}

class GetMessagesStreamError extends ChatState {}
