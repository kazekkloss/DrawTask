const express = require("express");
const authRouter = express.Router();
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const verify = require("../middlewares/verify/verify");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth/auth");

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

    if (user) {
      verify.sendVerifyMail(req.body.email, user._id);
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user });
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

    res.json({ token, ...user._doc });
    console.log(user)
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/token-is-valid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
