import 'package:chat/chat/data/models/message_model.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {
  final MessageModel message;

  const ReceivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    final displaySmallStyle = Theme.of(context).textTheme.displaySmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.senderName,
          style: displaySmallStyle?.copyWith(
            color: AppTheme.greyColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppTheme.lightGreyColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  message.content,
                  style: displaySmallStyle?.copyWith(
                    color: AppTheme.greyColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              DateFormat.jm().format(message.dateTime),
              style: displaySmallStyle?.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
