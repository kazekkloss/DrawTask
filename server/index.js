const express = require("express");
const mongoose = require("mongoose");
const http = require("http");

const authRouter = require("./routes/auth");
const userRouter = require("./routes/user");

//INIT
const port = process.env.PORT || 3000;
const app = express();
const DB =
  "";
var server = http.createServer(app);
var io = require("socket.io")(server);

// SOCKETS
const GameSocket = require("./sockets/game_socket");

// middleware
app.use(express.json());
app.use(authRouter);
app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, "0.0.0.0", function () {
  console.log(`Server started and running on port ${port}`);
});

io.on("connection", async (socket) => {
  const gameSocket = new GameSocket(socket, io);

  const User = require("./models/user");
  console.log("connection socket");
  console.log(socket.id);

  socket.on("authToSocket", async (data) => {
    console.log(socket.id);
    await User.findOneAndUpdate(
      { _id: data },
      { socketId: socket.id },
      { new: true }
    );
  });

  // Game sockets -------------------------------------
  socket.on("joinToGame", (data) => {
    gameSocket.joinToGame(data);
  })
});
