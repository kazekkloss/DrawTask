class UserSocket {
  constructor(socket, io) {
    this.socket = socket;
    this.io = io;
  }

  async sendInvitaionSocket(data) {
    try {
      console.log(data);
    } catch (e) {
      console.log(e);
    }
  }
}

module.exports = UserSocket;
