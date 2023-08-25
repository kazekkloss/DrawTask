import '../models/models.dart';


// GameStep to use in game screen and dashboard screen

enum GameStep { none, waiting, draw, vote, finish }

GameStep stepInGame(Game game, Picture picture) {
  GameStep gameStep = GameStep.none;

  if (picture.imageUrl.isEmpty) {
    gameStep = GameStep.draw;
  } else if (game.pictures.length != 5 ||
      game.pictures.any((picture) => picture.imageUrl.isEmpty)) {
    gameStep = GameStep.waiting;
  } else if (game.pictures.length == 5 &&
      game.pictures.every((picture) => picture.imageUrl.isNotEmpty)) {
    gameStep = GameStep.vote;
  }
  return gameStep;
}

List<Picture> sortedPictures(Game game, String currentUserId) {
  final userOwnedPictures = game.pictures
      .where((picture) => picture.userOwner.id == currentUserId)
      .toList();
  final otherPictures = game.pictures
      .where((picture) => picture.userOwner.id != currentUserId)
      .toList();
  List<Picture> sortedPictures = [...userOwnedPictures, ...otherPictures];
  return sortedPictures;
}
