import 'package:chat/chat/view/screens/chat_screen.dart';
import 'package:chat/rooms/data/models/room_model.dart';
import 'package:chat/rooms/view_model/rooms_view_model.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomItem extends StatelessWidget {
  final RoomModel room;

  const RoomItem(this.room);

  @override
  Widget build(BuildContext context) {
    final displaySmallStyle = Theme.of(context).textTheme.displaySmall;
    final categoryImageName = BlocProvider.of<RoomsViewModel>(context)
        .getCategoryImageName(room.categoryId);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        ChatScreen.routeName,
        arguments: room.id,
      ),
      child: Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: AppTheme.whiteColor,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/$categoryImageName.png',
                height: 85,
              ),
              const SizedBox(height: 12),
              Text(
                room.name,
                style: displaySmallStyle,
              ),
              const SizedBox(height: 8),
              Text(
                room.description,
                style: displaySmallStyle?.copyWith(
                  fontSize: 12,
                  color: AppTheme.greyColor,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
