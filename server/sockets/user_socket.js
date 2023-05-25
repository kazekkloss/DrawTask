const User = require("../models/user");

class UserSocket {
  constructor(socket, io) {
    this.socket = socket;
    this.io = io;
  }
}

module.exports = UserSocket;
