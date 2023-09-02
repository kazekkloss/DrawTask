import '../models/models.dart';



// GameStep to use in game screen and dashboard screen

enum GameStep { none, waiting, draw, vote, finish }

class GlobalVariables {
  GameStep stepInGame(Game game, Picture picture, String currentUserId) {
    GameStep gameStep = GameStep.none;

    bool voted = game.voted.any((userId) => userId == picture.userOwner.id);

    if (picture.imageUrl.isEmpty) {
      gameStep = GameStep.draw;
    } else if (game.pictures.length != 5 ||
        game.pictures.any((picture) => picture.imageUrl.isEmpty)) {
      gameStep = GameStep.waiting;
    } else if (game.pictures.length == 5 &&
        game.pictures
            .every((picture) => picture.imageUrl.isNotEmpty && !voted)) {
      gameStep = GameStep.vote;
    } else if (voted) {
      gameStep = GameStep.finish;
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
}
