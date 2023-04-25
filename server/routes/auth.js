const express = require("express");
const authRouter = express.Router();
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const verify = require("../middlewares/verify/verify");
const jwt = require("jsonwebtoken");

//Sign Up
authRouter.post("/api/sign_up", async (req, res) => {
  try {
    const { email, password } = req.body;

    console.log(email);
    console.log(password);
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
    });
    user = await user.save();
    res.json(user);

    if (user) {
      verify.sendVerifyMail(req.body.email, user._id);
    }

    console.log("auth success");
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// When the user clicks on the verification link, it runs this script
authRouter.get("/verify", verify.verifyUser);

// Sign In
authRouter.post("/api/sign_in", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");

    console.log("success")

    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
