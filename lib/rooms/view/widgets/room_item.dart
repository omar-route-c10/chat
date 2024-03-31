import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displaySmallStyle = Theme.of(context).textTheme.displaySmall;
    return Material(
      elevation: 16,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppTheme.whiteColor,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/movies.png',
              height: 85,
            ),
            const SizedBox(height: 12),
            Text(
              'The Movies Zone',
              style: displaySmallStyle,
            ),
            const SizedBox(height: 12),
            Text(
              '13 members',
              style: displaySmallStyle?.copyWith(
                fontSize: 12,
                color: AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
