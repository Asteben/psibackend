const express = require("express");
const router = express.Router();
const pool = require("../database");
const md_auth = require("../lib/authenticated");

router.get("/convenio", [md_auth.ensureAuth], async (req, res) => {
  pool.query("SELECT * FROM Convenio", async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Convenios retornados con exito!",
        rows,
      });
      console.log("Convenios retornados con exito!");
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

router.get("/convenio/:id", [md_auth.ensureAuth], async (req, res) => {
  const id = req.params.id;
  pool.query(
    "SELECT * FROM Convenio WHERE id_Convenio = ?",
    id,
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Convenio retornado con exito!",
          data: rows,
        });
        console.log("Convenio retornado con exito!");
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

router.post("/convenio/nuevo", [md_auth.ensureAuth], async (req, res) => {
  const {
    TipoInstitucion_id_TipoInstitucion,
    nombre,
    fecha_inicio,
    estado,
  } = req.body;
  pool.query(
    "INSERT INTO Convenio (TipoInstitucion_id_Tipoinstitucion, nombre, fecha_inicio, estado) VALUES (?,?,?,?)",
    [
      TipoInstitucion_id_TipoInstitucion,
      nombre,
      new Date(fecha_inicio),
      estado,
    ],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Convenio nuevo ingresado exitosamente",
        });
        console.log("Convenio retornado con exito!");
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

router.delete("/convenio/:id", [md_auth.ensureAuth], async (req, res) => {
  const { id } = req.params;
  pool.query(
    "DELETE FROM Convenio WHERE id_Convenio = ?",
    [id],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Convenio eliminado exitosamente",
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
});

router.post("/convenio/:id", [md_auth.ensureAuth], async (req, res) => {
  const id_Convenio = req.params.id;
  const {
    TipoInstitucion_id_TipoInstitucion,
    nombre,
    fecha_inicio,
    estado,
  } = req.body;
  pool.query(
    "UPDATE Convenio SET TipoInstitucion_id_TipoInstitucion = (?),  nombre = (?),  fecha_inicio = (?),  estado = (?) WHERE id_Convenio = (?)",
    [
      TipoInstitucion_id_TipoInstitucion,
      nombre,
      new Date(fecha_inicio),
      estado,
      id_Convenio,
    ],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Convenio cambiado exitosamente",
        });
        console.log("Convenio cambiado con exito!");
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

module.exports = router;
