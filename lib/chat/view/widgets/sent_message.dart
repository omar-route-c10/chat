import 'package:chat/chat/data/models/message_model.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SentMessage extends StatelessWidget {
  final MessageModel message;

  const SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    final displaySmallStyle = Theme.of(context).textTheme.displaySmall;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat.jm().format(message.dateTime),
          style: displaySmallStyle?.copyWith(
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Text(
              message.content,
              style: displaySmallStyle?.copyWith(
                color: AppTheme.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
