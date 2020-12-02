const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/contacto', isLoggedIn, async (req, res) => {
    pool.query('SELECT * FROM Contacto', async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contactos retornados con exito!",
                data: rows
            });
            console.log("Contactos retornados con exito!");
            console.log(rows)
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});

router.get('/contacto/:id', isLoggedIn, async (req, res) => {
    const id = req.params.id;
    pool.query('SELECT * FROM Contacto WHERE id_Contacto = ?', id ,async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contacto retornado con exito!",
                data: rows
            });
            console.log("Contacto retornado con exito!");
            console.log(rows)
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});

router.get('/contacto/rut/:rut', isLoggedIn, async (req, res) => {
    const rut = req.params.rut;
    pool.query('SELECT * FROM Contacto WHERE Paciente_RUT = ?', rut ,async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contactos retornados con exito!",
                data: rows
            });
            console.log("Contactos retornados con exito!");
            console.log(rows)
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});

router.post('/contacto', isLoggedIn, async (req, res) => {
    const {id_Contacto, encargado, fecha, respuesta, descripcion, Paciente_RUT} = req.body;
    pool.query('UPDATE Contacto SET encargado = (?),  fecha = (?),  respuesta = (?),  descripcion = (?),  Paciente_RUT = (?) WHERE id_Contacto = (?)',
    [encargado, new Date(fecha), respuesta, descripcion, Paciente_RUT, id_Contacto],
    async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contacto cambiado exitosamente",
            });
            console.log("Contacto cambiado con exito!");
            console.log(rows)
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});

router.post('/contacto/nuevo', isLoggedIn, async (req, res) => {
    const {encargado, fecha, respuesta, descripcion, rut} = req.body;
    pool.query('INSERT INTO Contacto (encargado, fecha, respuesta, descripcion, Paciente_RUT) VALUES (?,?,?,?,?)', [encargado, new Date(fecha), respuesta, descripcion, rut],
    async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contacto nuevo ingresado exitosamente",
            });
            console.log("Contacto retornado con exito!");
            console.log(rows)
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});

router.delete('/contacto/:id', isLoggedIn, async (req, res) => {
    const {id} = req.params;
    pool.query('DFELETE FROM Contacto WHERE id_Contacto = ?', [id] ,async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Contacto eliminado exitosamente",
            });
        }
        else {
            res.send({
                code: 400,
                failed: "un error ha ocurrido",
            });
            console.log(err);
        }
    });
});


module.exports = router;