const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    username: {
        type: String,
        default: "",
      },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  verify: {
    required: true,
    type: Number,
    default: 0,
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
