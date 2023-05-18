const User = require("../models/user");

class UserSocket {
  constructor(socket, io) {
    this.socket = socket;
    this.io = io;
  }

  async sendInvitaionSocket(data) {
    try {
      let currentUser = await User.findById(data.currentUserId);
      let otherUser = await User.findById(data.otherUserId);

      currentUser.invitationsFromMe.push(otherUser._id);
      otherUser.invitationsToMe.push(currentUser._id);

      currentUser = await currentUser.save();
      otherUser = await otherUser.save();

      console.log(otherUser);
      console.log(currentUser);
      this.socket.emit("sendInvitationSuccess", otherUser);
    } catch (e) {
      console.log(e);
    }
  }
}

module.exports = UserSocket;
