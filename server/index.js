const express = require("express");
const mongoose = require("mongoose");
const http = require("http");

const authRouter = require("./routes/auth");

//INIT
const port = process.env.PORT || 3000;
const app = express();
const DB = "";
var server = http.createServer(app);
var io = require("socket.io")(server);

// middleware
app.use(express.json());
app.use(authRouter);

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
  console.log("connection socket");
  console.log(socket.id);
});
