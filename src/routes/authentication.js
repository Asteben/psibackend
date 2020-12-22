const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const passport = require("passport");
const passportconfig = require("../lib/passportconfig");
passportconfig(passport);

router.post("/login", (req, res, next) => {
  passport.authenticate("local-login", (err, user, info) => {
    if (err) {
      res.status(400).json({ err });
    } else {
      req.logIn(user, { session: false }, (err) => {
        //if (err) throw err;
        if (err) {
          return res.status(500).json({ msg: "Error de servidor" });
        }
        if (!user) {
          return res.status(400).json({ msg: "El usuario no existe" });
        }
        console.log(err);
        const body = {
          _id: user._id,
          email: user.email,
          password: user.password,
        };
        const token = jwt.sign({ user: body }, "TOP_SECRET");
        res.json({
          token,
          message: "Inicio de sesión exitoso",
        });
      });
    }
  })(req, res, next);
});

router.post("/signup", async (req, res, next) => {
  await passport.authenticate(
    "local-signup",
    { session: false },
    (err, user, info) => {
      if (err) {
        console.log(err);
        res.status(400).json("Hubo un error de servidor");
      } else {
        req.logIn(user, (err) => {
          if (err) {
            res.status(500).json({ msg: "El usuario ya existe." });
          } else {
            if (!user) {
              res.status(404).json({ msg: "Error al crear el usuario." });
            } else {
              res.status(200).json({ message: "registro exitoso" });
            }
          }
        });
      }
    }
  )(req, res, next);
});

router.get("/logout", (req, res) => {
  res.send("Finalizando sesion...");
});

module.exports = router;
