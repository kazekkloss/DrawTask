const mongoose = require("mongoose");

const gameSchema = mongoose.Schema({
  gameWords: [String],
  users: [String],
});

const Game = mongoose.model("Game", gameSchema);
module.exports = Game;
