import 'package:e_home/models/Room.dart';

class ChoosenRoomModel {
  RoomsModel _roomsList;
  final List<int> _roomIdsList = [];

  RoomsModel get roomsList => _roomsList;

  set roomsList(RoomsModel newRoomsList) {
    _roomsList = newRoomsList;
  }

  /* Room get choosenRoom => _roomIdsList.map((id) => _roomsList.getById(id)).toRoom(); */
  List<Room> get choosenRoom =>
      _roomIdsList.map((id) => _roomsList.getById(id)).toList();

  void add(Room room) {
    _roomIdsList.add(room.id);
  }
}
