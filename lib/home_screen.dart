import 'package:chat/auth/view/screens/login_screen.dart';
import 'package:chat/auth/view_model/auth_states.dart';
import 'package:chat/auth/view_model/auth_view_model.dart';
import 'package:chat/rooms/view/screens/create_room_screen.dart';
import 'package:chat/rooms/view/widgets/room_item.dart';
import 'package:chat/rooms/view_model/rooms_states.dart';
import 'package:chat/rooms/view_model/rooms_view_model.dart';
import 'package:chat/shared/ui_utils.dart';
import 'package:chat/shared/widgets/error_indicator.dart';
import 'package:chat/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = RoomsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Chat App'),
          actions: [
            BlocConsumer<AuthViewModel, AuthState>(
              listener: (_, state) {
                if (state is LogoutSuccess) {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                } else if (state is LogoutError) {
                  UIUtils.showMessage(state.message);
                }
              },
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return const LoadingIndicator();
                } else {
                  return IconButton(
                    onPressed: () =>
                        BlocProvider.of<AuthViewModel>(context).logout(),
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 28,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
            ),
            child: BlocBuilder<RoomsViewModel, RoomsState>(
              builder: (context, state) {
                if (state is GetRoomsLoading) {
                  return const LoadingIndicator();
                } else if (state is GetRoomsError) {
                  return ErrorIndicator(state.message);
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (_, index) => RoomItem(viewModel.rooms[index]),
                    itemCount: viewModel.rooms.length,
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(CreateRoomScreen.routeName)
              .then((_) => viewModel.getRooms()),
          child: const Icon(
            Icons.add,
            size: 36,
          ),
        ),
      ),
    );
  }
}
