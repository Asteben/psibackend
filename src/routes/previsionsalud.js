const express = require("express");
const router = express.Router();
const pool = require("../database");
const md_auth = require("../lib/authenticated");

router.get("/prevision-salud", [md_auth.ensureAuth], async (req, res) => {
  pool.query("SELECT * FROM PrevisionSalud", async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Previsiones retornadas con exito!",
        rows,
      });
      console.log("Previsiones retornadas con exito!");
      console.log(rows);
    } else {
      res.send({
        code: 400,
        msg: "un error ha ocurrido",
      });
      console.log(err);
    }
  });
});

router.get("/prevision-salud/:id", [md_auth.ensureAuth], async (req, res) => {
  const id = req.params.id;
  pool.query(
    "SELECT * FROM Estado WHERE id_PrevisionSalud = ?",
    id,
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Prevision retornado con exito!",
          rows,
        });
        console.log("Estado retornado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          msg: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

router.put("/prevision-salud/:id", [md_auth.ensureAuth], async (req, res) => {
  const id_PrevisionSalud = req.params.id;
  const { nombre } = req.body;
  pool.query(
    "UPDATE PrevisionSalud SET nombre = (?) WHERE id_Estado = (?)",
    [nombre, id_PrevisionSalud],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Estado cambiado exitosamente",
        });
        console.log("Estado cambiado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          msg: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

router.post("/prevision-salud", [md_auth.ensureAuth], async (req, res) => {
  const { nombre } = req.body;
  pool.query(
    "INSERT INTO PrevisionSalud (nombre) VALUES (?)",
    [nombre],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Prevision nueva ingresado exitosamente",
        });
        console.log("Estado retornado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          msg: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

router.delete(
  "/prevision-salud/:id",
  [md_auth.ensureAuth],
  async (req, res) => {
    const { id_PrevisionSalud } = req.params.id;
    pool.query(
      "DELETE FROM PrevisionSalud WHERE id_Estado = ?",
      [id_PrevisionSalud],
      async (err, rows) => {
        if (!err) {
          res.send({
            code: 200,
            message: "Estado eliminado exitosamente",
          });
        } else {
          res.send({
            code: 400,
            msg: "un error ha ocurrido",
          });
          console.log(err);
        }
      }
    );
  }
);

module.exports = router;
