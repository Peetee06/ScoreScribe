import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Game {
  Game(this.name, this.players) : id = uuid.v4();

  final String id;
  final String name;
  final List<String> players;
}
