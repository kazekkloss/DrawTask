const User = require("../models/user");
const Game = require("../models/game");
const nouns = require("../middlewares/words/nouns");

class GameSocket {
  constructor(socket, io) {
    this.socket = socket;
    this.io = io;
  }

  // ----------------------------------

  async getAllGames(data) {
    try {
        const socketRooms = Object.keys(this.socket.rooms);
      const games = await Game.find({ users: { $in: [data.currentUserId] } });

      const gamesToRes = [];

      for (let i = 0; i < games.length; i++) {
        const users = await User.find({ _id: { $in: games[i].users } });

        const gameToRes = {
          _id: games[i]._id,
          gameWords: games[i].gameWords,
          users: users,
        };

        gamesToRes.push(gameToRes);

        if(!socketRooms.includes(games[i]._id.toString())) {
            this.socket.join(games[i]._id.toString());
        }
      }

      this.socket.emit("allGamesToState", gamesToRes);
      console.log(gamesToRes);
    } catch (e) {
      console.log(e);
    }
  }

  // ----------------------------------

  async joinToGame(data) {
    try {
      const user = await User.findById(data.currentUserId);

      const foundGame = await Game.findOne({
        users: { $not: { $in: [data.currentUserId] } },
        $expr: { $lt: [{ $size: "$users" }, 5] },
      });

      let game;

      //
      if (foundGame) {
        foundGame.users.push(data.currentUserId);
        await foundGame.save();
        game = foundGame;
      } else {
        let newGame = new Game({
          gameWords: [
            nouns[Math.floor(Math.random() * nouns.length)],
            nouns[Math.floor(Math.random() * nouns.length)],
            nouns[Math.floor(Math.random() * nouns.length)],
          ],
          users: [data.currentUserId],
        });

        await newGame.save();

        game = newGame;
      }

      const users = await User.find({ _id: { $in: game.users } });

      console.log(users);

      const gameToRes = {
        _id: game._id,
        gameWords: game.gameWords,
        users: users,
      };

      //   // sockets in game
      if (this.io.sockets.connected[user.socketId]) {
        const gameId = game._id.toString();

        // add socket id to game
        this.io.sockets.connected[user.socketId].join(gameId);

        // send the game over sockets

        this.io.to(gameId).emit("joinedToGame", gameToRes);
      } else {
        console.log(`Socket o id ${user.socketId} nie jest aktywny.`);
      }
    } catch (e) {
      console.log(e);
    }
  }
}

module.exports = GameSocket;
