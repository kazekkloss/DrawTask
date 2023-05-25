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

// get user list
userRouter.post("/api/get_users", auth, async (req, res) => {
  try {
    const { currentListLength, friendsType } = req.body;

    let list = [];

    let currentUser = await User.findById(req.user);

    if (friendsType == "FriendsType.accepted") {
      list = currentUser.friends;
    }
    if (friendsType == "FriendsType.waiting") {
      list = currentUser.invitationsFromMe;
    }
    if (friendsType == "FriendsType.invitations") {
      list = currentUser.invitationsToMe;
    }

    const startIndex = Math.max(list.length - currentListLength - 10, 0);
    const endIndex = list.length - currentListLength;

    const friendsId = list.slice(startIndex, endIndex);
    friendsId.reverse();

    const users = [];

    //const users = await User.find({ _id: { $in: friendsId } });
    for (let i = 0; i < friendsId.length; i++) {
      let user = await User.findById(friendsId[i]);
      users.push(user);
    }

    res.json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Send invitation to friend
userRouter.post("/api/send_invitation_to_friend", auth, async (req, res) => {
  try {
    const { userId } = req.body;

    console.log(userId);

    let currentUser = await User.findById(req.user);
    let otherUser = await User.findById(userId);

    currentUser.invitationsFromMe.push(userId);
    otherUser.invitationsToMe.push(currentUser.id);

    await currentUser.save();
    await otherUser.save();

    console.log(currentUser);
    console.log(otherUser);

    res.json(otherUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/confirm_invitation", auth, async (req, res) => {
  try {
    const { userId } = req.body;

    let currentUser = await User.findById(req.user);
    let otherUser = await User.findById(userId);

    currentUser.invitationsToMe.pull(userId);
    otherUser.invitationsFromMe.pull(currentUser.id);

    console.log(currentUser);
    console.log(otherUser);

    currentUser.friends.push(userId);
    otherUser.friends.push(currentUser.id);

    otherUser = await otherUser.save();
    currentUser = await currentUser.save();

    res.json(otherUser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/delete_friend", auth, async (req, res) => {
  try {
    const { friendsType, userId } = req.body;

    let otherUser = await User.findById(userId);
    let currentUser = await User.findById(req.user);

    if (friendsType == "FriendsType.accepted") {
      currentUser.friends.pull(userId);
      otherUser.friends.pull(currentUser.id);

      currentUser = await currentUser.save();
      otherUser = await otherUser.save();

      res.json();
    }
    if (friendsType == "FriendsType.waiting") {
      currentUser.invitationsFromMe.pull(userId);
      otherUser.invitationsToMe.pull(currentUser.id);

      currentUser = await currentUser.save();
      otherUser = await otherUser.save();

      res.json();
    }
    if (friendsType == "FriendsType.invitations") {
      currentUser.invitationsToMe.pull(userId);
      otherUser.invitationsFromMe.pull(currentUser.id);

      currentUser = await currentUser.save();
      otherUser = await otherUser.save();

      res.json();
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
