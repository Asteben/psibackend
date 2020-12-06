const express = require("express");
const router = express.Router();
const pool = require("../database");
const md_auth = require("../lib/authenticated");

router.get("/motivo", [md_auth.ensureAuth], async (req, res) => {
  pool.query("SELECT * FROM Motivo", async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        success: "Motivos retornados con exito!",
        data: rows,
      });
      console.log("Motivos retornados con exito!");
      console.log(rows);
    } else {
      res.send({
        code: 400,
        failed: "un error ha ocurrido",
      });
      console.log(err);
    }
  });
});

router.get("/motivo/:id", [md_auth.ensureAuth], async (req, res) => {
  const id = req.params.id;
  pool.query(
    "SELECT * FROM Motivo WHERE id_Motivo = ?",
    id,
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          success: "Motivo retornado con exito!",
          data: rows,
        });
        console.log("Motivo retornado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          failed: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

router.post("/motivo/nuevo", [md_auth.ensureAuth], async (req, res) => {
  const { nombre } = req.body;
  pool.query(
    "INSERT INTO Motivo (nombre) VALUES (?)",
    [nombre],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          success: "Motivo nuevo ingresado exitosamente",
        });
        console.log("Motivo retornado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          failed: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

router.delete("/motivo/:id", [md_auth.ensureAuth], async (req, res) => {
  const { id } = req.params;
  pool.query(
    "DELETE FROM Motivo WHERE id_Motivo = ?",
    [id],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          success: "Motivo eliminado exitosamente",
        });
      } else {
        res.send({
          code: 400,
          failed: "un error ha ocurrido",
        });
        console.log(err);
      }
    }
  );
});

module.exports = router;
