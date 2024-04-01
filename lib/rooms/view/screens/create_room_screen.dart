import 'package:chat/auth/view/widgets/default_elevated_button.dart';
import 'package:chat/auth/view/widgets/default_text_form_field.dart';
import 'package:chat/rooms/data/models/room_model.dart';
import 'package:chat/rooms/view/widgets/categories_drop_down_button.dart';
import 'package:chat/rooms/view_model/rooms_states.dart';
import 'package:chat/rooms/view_model/rooms_view_model.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:chat/shared/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/create-room';

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedCategoryId;
  final formKey = GlobalKey<FormState>();
  final viewModel = RoomsViewModel();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Chat App'),
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.only(
                      top: 36,
                      left: 16,
                      right: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: AppTheme.whiteColor,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Create New Room',
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/room.png',
                            height: MediaQuery.of(context).size.height * 0.1,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: nameController,
                            hintText: 'Enter Room Name',
                            validator: (value) {
                              if (value == null || value.length < 3) {
                                return 'Name can not be less than 3 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CategoriesDropDownButton(
                            onCategorySelected: (categoryId) =>
                                selectedCategoryId = categoryId,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextFormField(
                            controller: descriptionController,
                            hintText: 'Enter Room Description',
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return 'Description can not be less than 5 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          BlocListener<RoomsViewModel, RoomsState>(
                            listener: (_, state) {
                              if (state is CreateRoomLoading) {
                                UIUtils.showLoading(context);
                              } else if (state is CreateRoomSuccess) {
                                UIUtils.hideLoading(context);
                                UIUtils.showMessage(
                                    'Room created successfully');
                                Navigator.of(context).pop();
                              } else if (state is CreateRoomError) {
                                UIUtils.hideLoading(context);
                                UIUtils.showMessage(state.message);
                              }
                            },
                            child: DefaultElevatedButton(
                              onPressed: createRoom,
                              width: MediaQuery.of(context).size.width * 0.7,
                              borderRadiusValue: 32,
                              child: Text(
                                'Create',
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppTheme.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void createRoom() {
    if (formKey.currentState?.validate() == true) {
      viewModel.createRoom(
        RoomModel(
          name: nameController.text,
          description: descriptionController.text,
          categoryId: selectedCategoryId!,
        ),
      );
    }
  }
}
