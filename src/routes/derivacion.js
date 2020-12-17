const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/derivacion', isLoggedIn, async (req, res) => {
    pool.query('SELECT * FROM Derivacion', async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Derivaciones retornadas con exito!",
                data: rows
            });
            console.log("Derivaciones retornadas con exito!");
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

router.get('/derivacion/:id', isLoggedIn, async (req, res) => {
    const id = req.params.id;
    pool.query('SELECT * FROM Derivacion WHERE id_Derivacion = ?', id ,async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Derivacion retornada con exito!",
                data: rows
            });
            console.log("Derivacion retornada con exito!");
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

router.post('/derivacion', isLoggedIn, async (req, res) => {
    const {id_Derivacion, Motivo_id_Motivo} = req.body;
    pool.query('UPDATE Derivacion SET Motivo_id_Motivo = (?) WHERE id_Derivacion = (?)',
    [Motivo_id_Motivo, id_Derivacion],
    async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Derivacion cambiada exitosamente",
            });
            console.log("Derivacion cambiada con exito!");
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

router.post('/derivacion/nuevo', isLoggedIn, async (req, res) => {
    const {Motivo_id_Motivo, RUT, id_Coordinador} = req.body;
    pool.query("INSERT INTO Derivacion (Motivo_id_Motivo, Paciente_RUT, Coordinador_id_Coordinador) VALUES (?,?,?);",[Motivo_id_Motivo, RUT, id_Coordinador]), async(err,rows) =>{
        if (!err) {
            console.log(rows)
        }
        else{
            console.log(rows)
        }
    };
    pool.query("INSERT INTO HechosConsultantes (Paciente_RUT, edad, genero, sexo, motivo, convenio, tipo_institucion, PrevisionSalud, estado) \n\
                VALUES ( ?,\n\
                    (SELECT TIMESTAMPDIFF(YEAR, (SELECT fecha_nacimiento FROM Paciente WHERE RUT = ?), NOW())),\n\
                    (SELECT genero FROM Paciente WHERE RUT = ?),\n\
                    (SELECT sexo FROM Paciente WHERE RUT = ?),\n\
                    (SELECT nombre FROM Motivo WHERE id_Motivo = ?),\n\
                    (SELECT Convenio.nombre FROM (Convenio\n\
                        INNER JOIN Coordinador ON Convenio.id_Convenio = Coordinador.Convenio_id_Convenio\n\
                        INNER JOIN Derivacion ON Coordinador.id_Coordinador = ?)),\n\
                    (SELECT TipoInstitucion.nombre FROM (TipoInstitucion\n\
                        INNER JOIN Convenio ON TipoInstitucion.id_TipoInstitucion = Convenio.TipoInstitucion_id_TipoInstitucion\n\
                        INNER JOIN Coordinador ON Convenio.id_Convenio = Coordinador.Convenio_id_Convenio\n\
                        INNER JOIN Derivacion ON Coordinador.id_Coordinador = ?)),\n\
                    (SELECT nombre FROM PrevisionSalud WHERE id_PrevisionSalud = (SELECT PrevisionSalud_id_PrevisionSalud FROM Paciente WHERE RUT = ?)),\n\
                    (SELECT nombre FROM Estado WHERE id_Estado = (SELECT Estado_id_Estado FROM Paciente WHERE RUT = ?)));",
    [RUT, RUT, RUT, RUT, Motivo_id_Motivo, id_Coordinador, id_Coordinador, RUT, RUT],
    async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Derivacion nueva ingresada exitosamente",
            });
            console.log("Derivacion retornada con exito!");
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

router.delete('/derivacion/:id', isLoggedIn, async (req, res) => {
    const {id} = req.params;
    pool.query('DFELETE FROM Derivacion WHERE id_Derivacion = ?', [id] ,async(err,rows) =>{
        if (!err) {
            res.send({
                code: 200,
                success: "Derivacion eliminada exitosamente",
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