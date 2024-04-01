abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class CreateRoomLoading extends RoomsState {}

class CreateRoomSuccess extends RoomsState {}

class CreateRoomError extends RoomsState {
  final String message;

  CreateRoomError(this.message);
}

class GetRoomsLoading extends RoomsState {}

class GetRoomsSuccess extends RoomsState {}

class GetRoomsError extends RoomsState {
  final String message;

  GetRoomsError(this.message);
}
