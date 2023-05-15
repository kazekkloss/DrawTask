const User = require("../models/user");
const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth/auth");

userRouter.get("/api/user/search/:name", auth, async (req, res) => {
  try {
    const user = await User.find({
      username: { $regex: req.params.name, $options: "i" },
    }).limit(5);
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
