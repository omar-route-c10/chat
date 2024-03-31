import 'package:chat/auth/view/widgets/default_elevated_button.dart';
import 'package:chat/auth/view/widgets/default_text_form_field.dart';
import 'package:chat/rooms/view/widgets/categories_drop_down_button.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/create-room';

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedCategory;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.7,
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
                          onCategorySelected: (category) =>
                              selectedCategory = category,
                        ),
                        const SizedBox(height: 20),
                        DefaultTextFormField(
                          controller: descriptionController,
                          hintText: 'Enter Room Description',
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Description can not be less than 5 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        DefaultElevatedButton(
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createRoom() {
    if (formKey.currentState?.validate() == true) {}
  }
}
