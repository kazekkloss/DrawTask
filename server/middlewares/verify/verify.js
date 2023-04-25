const nodemailer = require("nodemailer");
const User = require("../../models/user");

const verifyUser = async (req, res) => {
  try {
    const updateInfo = await User.updateOne(
      { _id: req.query.id },
      { $set: { verify: 1 } }
    );

    console.log(updateInfo);
    res.sendFile(__dirname + "/layouts/verify-page.html", function (err) {
      if (err) {
        console.log("error email link");
      }
    });
  } catch (err) {
    console.log(err);
  }
};

const sendVerifyMail = async (email, user_id) => {
  try {
    let mailTransporter = nodemailer.createTransport({
      host: "sandbox.smtp.mailtrap.io",
      port: 2525,
      auth: {
        user: "cce6db6f1eb927",
        pass: "a76efadf7b378a",
      },
    });

    let details = {
      from: "cce6db6f1eb927",
      to: email,
      subject: "DrawTask - confirm email",
      html:
        "<p>Hi " +
        email +
        ', please click here to <a href="http://0.0.0.0:3000/verify?id=' +
        user_id +
        '"> Verify </a> your mail',
    };

    mailTransporter.sendMail(details, (err) => {
      if (err) {
        console.log("it has an error", err);
      } else {
        console.log("email has sent!");
      }
    });
  } catch (err) {
    console.log(err);
  }
};

module.exports = { verifyUser, sendVerifyMail };
