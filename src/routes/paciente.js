const express = require("express");
const router = express.Router();
const pool = require("../database");
const md_auth = require("../lib/authenticated");

router.get("/paciente", [md_auth.ensureAuth], async (req, res) => {
  pool.query("SELECT * FROM Paciente", async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Pacientes retornados con exito!",
        rows,
      });
      console.log("Pacientes retornados con exito!");
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

router.get("/paciente/:rut", [md_auth.ensureAuth], async (req, res) => {
  const rut = req.params.rut;
  pool.query("SELECT * FROM Paciente WHERE RUT = ?", rut, async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Paciente retornado con exito!",
        rows,
      });
      console.log("Paciente retornado con exito!");
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

router.post("/paciente/nuevo", [md_auth.ensureAuth], async (req, res) => {
  const {
    rut,
    nombre,
    nombre_social,
    pronombre,
    genero,
    sexo,
    apellido,
    id_PrevisionSalud,
    fecha_nacimiento,
    fecha_ingreso,
  } = req.body;
  pool.query(
    "INSERT INTO Paciente (RUT, nombre, nombre_social, pronombre, genero, sexo, apellido, PrevisionSalud_id_PrevisionSalud, fecha_nacimiento,fecha_ingreso) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [
      rut,
      nombre,
      nombre_social,
      pronombre,
      genero,
      sexo,
      apellido,
      id_PrevisionSalud,
      new Date(fecha_nacimiento),
      new Date(fecha_ingreso),
    ],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Paciente nuevo ingresado exitosamente",
        });
        console.log("Paciente retornado con exito!");
        console.log(rows);
      } else {
        res.send({
          code: 400,
          msg: "Paciente ya existe",
        });
        console.log(err);
      }
    }
  );
});

router.put("/paciente:rut", [md_auth.ensureAuth], async (req, res) => {
  const RUT = req.params.rut;
  const {
    nombre,
    nombre_social,
    pronombre,
    genero,
    sexo,
    apellido,
    Prevision_id_PrevisionSalud,
    fecha_nacimiento,
    Estado_id_Estado,
  } = req.body;
  pool.query(
    "UPDATE Paciente SET nombre = (?),  nombre_social = (?),  pronombre = (?),  genero = (?),  sexo = (?),  apellido = (?),  PrevisionSalud_id_PrevisionSalud = (?),  fecha_nacimiento = (?),  Estado_id_Estado = (?) WHERE RUT = (?)",
    [
      nombre,
      nombre_social,
      pronombre,
      genero,
      sexo,
      apellido,
      Prevision_id_PrevisionSalud,
      new Date(fecha_nacimiento),
      Estado_id_Estado,
      RUT,
    ],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Paciente cambiado exitosamente",
        });
        console.log("Paciente cambiado con exito!");
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
router.delete("/paciente/:rut", [md_auth.ensureAuth], async (req, res) => {
  const { rut } = req.params;
  pool.query("DELETE FROM Paciente WHERE RUT = ?", [rut], async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Paciente eliminado exitosamente",
      });
    } else {
      res.send({
        code: 400,
        msg: "un error ha ocurrido",
      });
      console.log(err);
    }
  });
});

module.exports = router;
