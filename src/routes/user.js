const express = require("express");
const router = express.Router();
const pool = require("../database");
const md_auth = require("../lib/authenticated");

router.get("/usuario", [md_auth.ensureAuth], async (req, res) => {
  //const { email } = req.params;
  pool.query(
    "SELECT * FROM Usuario ",

    async (err, rows) => {
      if (!err) {
        res
          .status(200)
          .send({ code: 200, message: "Usuarios retornado con exito!", rows });
        console.log("Usuario retornado con exito!");
        console.log(rows);
      } else {
        res.status(404).send({ msg: "No se ha encontrado ningun usuario." });
        console.log(err);
      }
    }
  );
});

//retorna el usuario por id
router.get("/usuario/:id", [md_auth.ensureAuth], async (req, res) => {
  const id = req.params.id;
  pool.query(
    "SELECT * FROM Usuario WHERE id = ? ",
    id,

    async (err, rows) => {
      if (!err) {
        res
          .status(200)
          .send({ code: 200, message: "Usuario retornado con exito!", rows });
        console.log("Usuario retornado con exito!");
        console.log(rows);
      } else {
        res.status(404).send({ msg: "No se ha encontrado ningun usuario." });
        console.log(err);
      }
    }
  );
});

router.post("/usuario/:id", [md_auth.ensureAuth], async (req, res) => {
  const id_Usuario = req.params.id;
  const { TipoUsuario_id_TipoUsuario } = req.body;
  pool.query(
    "UPDATE Usuario SET TipoUsuario_id_TipoUsuario = (?) WHERE id_Usuario  = (?)",
    [TipoUsuario_id_TipoUsuario, id_Usuario],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Usuario cambiado exitosamente",
        });
        console.log("Usuario cambiado con exito!");
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

router.get("/tipousuario", async (req, res) => {
  pool.query("SELECT * FROM TipoUsuario", async (err, rows) => {
    if (!err) {
      res.send({
        code: 200,
        message: "Tipos de usuario retornados con exito!",
        rows,
      });
      console.log("Tipos de usuario retornado con exito!");
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

router.delete("/usuario/:id", [md_auth.ensureAuth], async (req, res) => {
  const { id } = req.params;
  pool.query(
    "DELETE FROM Usuario WHERE id_Usuario = ?",
    [id],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Usuario eliminado exitosamente",
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

router.get("/politica/:id", [md_auth.ensureAuth], async (req, res) => {
  const { id } = req.params;
  pool.query(
    "SELECT Politica.nombre FROM Politica INNER JOIN Permiso ON Permiso.Politica_id_Politica = Politica.id_Politica WHERE Permiso.TipoUsuario_id_TipoUsuario = ?;",
    [id],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "permisos del rol retornados con exito!",
          rows,
        });
        console.log("permisos del rol retornado con exito!");
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

router.post("/tipousuario/nuevo", [md_auth.ensureAuth], async (req, res) => {
  const { nombre } = req.body;
  pool.query(
    "INSERT INTO TipoUsuario (nombre) VALUES (?)",
    [nombre],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Tipo de usuario nuevo ingresado exitosamente",
        });
        console.log("Tipo de usuario retornado con exito!");
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

router.put("/tipousuario", [md_auth.ensureAuth], async (req, res) => {
  const id_TipoUsuario = req.params.id;
  const { nombre } = req.body;
  pool.query(
    "UPDATE TipoUsuario SET nombre = (?) WHERE id_TipoUsuario = (?)",
    [nombre, id_TipoUsuario],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Tipo de usuario cambiado exitosamente",
        });
        console.log("Tipo de usuario cambiado con exito!");
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

router.delete("/tipousuario/:id", [md_auth.ensureAuth], async (req, res) => {
  const { id } = req.params;
  pool.query(
    "DELETE FROM TipoUsuario WHERE id_TipoUsuario = ?",
    [id],
    async (err, rows) => {
      if (!err) {
        res.send({
          code: 200,
          message: "Tipo de usuario eliminado exitosamente",
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
module.exports = router;
