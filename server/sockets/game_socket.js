const User = require("../models/user");
const Game = require("../models/game");

class GameSocket {
  constructor(socket, io) {
    this.socket = socket;
    this.io = io;
  }

  async joinToGame(data) {
    try {
      const user = await User.findById(data.currentUserId);

      const lastGame = await Game.findOne().sort({ _id: -1 });

      let game;

      //
      if (
        lastGame &&
        lastGame.users.length < 5 &&
        !lastGame.users.includes(data.currentUserId)
      ) {
        lastGame.users.push(data.currentUserId);
        await lastGame.save();
        game = lastGame;
      } else {
        let newGame = new Game({
          gameWords: ["dupa", "kupa", "jajca"],
          users: [data.currentUserId],
        });

        await newGame.save();

        game = newGame;
      }

      //   // sockets in game
      if (this.io.sockets.connected[user.socketId]) {
        const gameId = game._id.toString();

        // add socket id to game
        this.io.sockets.connected[user.socketId].join(gameId);

        // send the game over sockets

        this.io.to(gameId).emit("joinedToGame", game);
      } else {
        console.log(`Socket o id ${user.socketId} nie jest aktywny.`);
      }
    } catch (e) {
      console.log(e);
    }
  }
}

module.exports = GameSocket;
