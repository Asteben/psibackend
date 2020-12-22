-- MySQL Script generated by MySQL Workbench
-- Thu Dec 17 17:51:43 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Motivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Motivo` (
  `id_Motivo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Motivo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `id_Estado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PrevisionSalud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PrevisionSalud` (
  `id_PrevisionSalud` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_PrevisionSalud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `RUT` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nombre_social` VARCHAR(45) NOT NULL,
  `pronombre` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `intentos_contacto` INT NOT NULL DEFAULT 0,
  `fecha_ingreso` DATE NULL,
  `Estado_id_Estado` INT NOT NULL DEFAULT 1,
  `PrevisionSalud_id_PrevisionSalud` INT NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` TINYINT NOT NULL,
  PRIMARY KEY (`RUT`, `Estado_id_Estado`, `PrevisionSalud_id_PrevisionSalud`),
  INDEX `fk_Paciente_Estado1_idx` (`Estado_id_Estado` ASC) VISIBLE,
  INDEX `fk_Paciente_PrevisionSalud1_idx` (`PrevisionSalud_id_PrevisionSalud` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Estado1`
    FOREIGN KEY (`Estado_id_Estado`)
    REFERENCES `mydb`.`Estado` (`id_Estado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Paciente_PrevisionSalud1`
    FOREIGN KEY (`PrevisionSalud_id_PrevisionSalud`)
    REFERENCES `mydb`.`PrevisionSalud` (`id_PrevisionSalud`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoInstitucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoInstitucion` (
  `id_TipoInstitucion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_TipoInstitucion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Convenio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Convenio` (
  `id_Convenio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `TipoInstitucion_id_TipoInstitucion` INT NOT NULL,
  PRIMARY KEY (`id_Convenio`, `TipoInstitucion_id_TipoInstitucion`),
  INDEX `fk_Convenio_TipoInstitucion1_idx` (`TipoInstitucion_id_TipoInstitucion` ASC) VISIBLE,
  CONSTRAINT `fk_Convenio_TipoInstitucion1`
    FOREIGN KEY (`TipoInstitucion_id_TipoInstitucion`)
    REFERENCES `mydb`.`TipoInstitucion` (`id_TipoInstitucion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Coordinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coordinador` (
  `id_Coordinador` INT NOT NULL AUTO_INCREMENT,
  `Convenio_id_Convenio` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Coordinador`, `Convenio_id_Convenio`),
  INDEX `fk_Coordinador_Convenio1_idx` (`Convenio_id_Convenio` ASC) VISIBLE,
  CONSTRAINT `fk_Coordinador_Convenio1`
    FOREIGN KEY (`Convenio_id_Convenio`)
    REFERENCES `mydb`.`Convenio` (`id_Convenio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Derivacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Derivacion` (
  `id_Derivacion` INT NOT NULL AUTO_INCREMENT,
  `Motivo_id_Motivo` INT NOT NULL,
  `Paciente_RUT` VARCHAR(10) NOT NULL,
  `Coordinador_id_Coordinador` INT NOT NULL,
  PRIMARY KEY (`id_Derivacion`, `Motivo_id_Motivo`, `Paciente_RUT`, `Coordinador_id_Coordinador`),
  INDEX `fk_Derivacion_Motivo1_idx` (`Motivo_id_Motivo` ASC) VISIBLE,
  INDEX `fk_Derivacion_Paciente1_idx` (`Paciente_RUT` ASC) VISIBLE,
  INDEX `fk_Derivacion_Coordinador1_idx` (`Coordinador_id_Coordinador` ASC) VISIBLE,
  CONSTRAINT `fk_Derivacion_Motivo1`
    FOREIGN KEY (`Motivo_id_Motivo`)
    REFERENCES `mydb`.`Motivo` (`id_Motivo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Derivacion_Paciente1`
    FOREIGN KEY (`Paciente_RUT`)
    REFERENCES `mydb`.`Paciente` (`RUT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Derivacion_Coordinador1`
    FOREIGN KEY (`Coordinador_id_Coordinador`)
    REFERENCES `mydb`.`Coordinador` (`id_Coordinador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Accion` (
  `id_Accion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Accion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoUsuario` (
  `id_TipoUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_TipoUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `TipoUsuario_id_TipoUsuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nombre_social` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`id_Usuario`, `TipoUsuario_id_TipoUsuario`),
  INDEX `fk_Usuario_TipoUsuario1_idx` (`TipoUsuario_id_TipoUsuario` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_id_TipoUsuario`)
    REFERENCES `mydb`.`TipoUsuario` (`id_TipoUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Log` (
  `id_Log` INT NOT NULL AUTO_INCREMENT,
  `Accion_id_Accion` INT NOT NULL,
  `Usuario_id_Usuario` INT NULL,
  `Derivacion_id_Derivacion` INT NULL,
  `fecha` TIMESTAMP NOT NULL,
  `consulta` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`id_Log`, `Accion_id_Accion`),
  INDEX `fk_Log_Accion_idx` (`Accion_id_Accion` ASC) VISIBLE,
  INDEX `fk_Log_Usuario1_idx` (`Usuario_id_Usuario` ASC) VISIBLE,
  INDEX `fk_Log_Derivacion1_idx` (`Derivacion_id_Derivacion` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Accion`
    FOREIGN KEY (`Accion_id_Accion`)
    REFERENCES `mydb`.`Accion` (`id_Accion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Log_Usuario1`
    FOREIGN KEY (`Usuario_id_Usuario`)
    REFERENCES `mydb`.`Usuario` (`id_Usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Log_Derivacion1`
    FOREIGN KEY (`Derivacion_id_Derivacion`)
    REFERENCES `mydb`.`Derivacion` (`id_Derivacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Politica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Politica` (
  `id_Politica` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Politica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contacto` (
  `id_Contacto` INT NOT NULL AUTO_INCREMENT,
  `encargado` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `respuesta` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NULL,
  `Paciente_RUT` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_Contacto`, `Paciente_RUT`),
  INDEX `fk_Contacto_Paciente1_idx` (`Paciente_RUT` ASC) VISIBLE,
  CONSTRAINT `fk_Contacto_Paciente1`
    FOREIGN KEY (`Paciente_RUT`)
    REFERENCES `mydb`.`Paciente` (`RUT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Psicopatologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Psicopatologia` (
  `id_Psicopatologia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Psicopatologia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diagnostico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnostico` (
  `id_Diagnostico` INT NOT NULL AUTO_INCREMENT,
  `Psicopatologia_id_Psicopatologia` INT NOT NULL,
  `Paciente_RUT` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_Diagnostico`, `Psicopatologia_id_Psicopatologia`, `Paciente_RUT`),
  INDEX `fk_Diagnostico_Psicopatologia1_idx` (`Psicopatologia_id_Psicopatologia` ASC) VISIBLE,
  INDEX `fk_Diagnostico_Paciente1_idx` (`Paciente_RUT` ASC) VISIBLE,
  CONSTRAINT `fk_Diagnostico_Psicopatologia1`
    FOREIGN KEY (`Psicopatologia_id_Psicopatologia`)
    REFERENCES `mydb`.`Psicopatologia` (`id_Psicopatologia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Diagnostico_Paciente1`
    FOREIGN KEY (`Paciente_RUT`)
    REFERENCES `mydb`.`Paciente` (`RUT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Protocolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Protocolo` (
  `id_Protocolo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Protocolo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atencion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atencion` (
  `id_Atencion` INT NOT NULL AUTO_INCREMENT,
  `Protocolo_id_Protocolo` INT NULL,
  `fecha_registro` DATE NOT NULL,
  `terapeuta` VARCHAR(45) NOT NULL,
  `aplica_protocolo` TINYINT NOT NULL DEFAULT 0,
  `Paciente_RUT` VARCHAR(10) NOT NULL,
  `fecha_ingreso_datos` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_Atencion`, `Paciente_RUT`),
  INDEX `fk_Atencion_Protocolo1_idx` (`Protocolo_id_Protocolo` ASC) VISIBLE,
  INDEX `fk_Atencion_Paciente1_idx` (`Paciente_RUT` ASC) VISIBLE,
  CONSTRAINT `fk_Atencion_Protocolo1`
    FOREIGN KEY (`Protocolo_id_Protocolo`)
    REFERENCES `mydb`.`Protocolo` (`id_Protocolo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Atencion_Paciente1`
    FOREIGN KEY (`Paciente_RUT`)
    REFERENCES `mydb`.`Paciente` (`RUT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HechosConsultantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HechosConsultantes` (
  `id_HechosConsultantes` INT NOT NULL AUTO_INCREMENT,
  `Paciente_RUT` VARCHAR(10) NOT NULL,
  `edad` INT NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `sexo` TINYINT NOT NULL,
  `intentos_contacto` INT NOT NULL DEFAULT 0,
  `motivo` VARCHAR(45) NOT NULL,
  `convenio` VARCHAR(45) NOT NULL,
  `tipo_institucion` VARCHAR(45) NOT NULL,
  `PrevisionSalud` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_HechosConsultantes`, `Paciente_RUT`),
  INDEX `fk_HechosConsultantes_Paciente1_idx` (`Paciente_RUT` ASC) VISIBLE,
  CONSTRAINT `fk_HechosConsultantes_Paciente1`
    FOREIGN KEY (`Paciente_RUT`)
    REFERENCES `mydb`.`Paciente` (`RUT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Permiso` (
  `TipoUsuario_id_TipoUsuario` INT NOT NULL,
  `Politica_id_Politica` INT NOT NULL,
  PRIMARY KEY (`TipoUsuario_id_TipoUsuario`, `Politica_id_Politica`),
  INDEX `fk_TipoUsuario_has_Politica_Politica1_idx` (`Politica_id_Politica` ASC) VISIBLE,
  INDEX `fk_TipoUsuario_has_Politica_TipoUsuario1_idx` (`TipoUsuario_id_TipoUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_TipoUsuario_has_Politica_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_id_TipoUsuario`)
    REFERENCES `mydb`.`TipoUsuario` (`id_TipoUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TipoUsuario_has_Politica_Politica1`
    FOREIGN KEY (`Politica_id_Politica`)
    REFERENCES `mydb`.`Politica` (`id_Politica`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Paciente_AFTER_UPDATE` AFTER UPDATE ON `Paciente` FOR EACH ROW
BEGIN
IF OLD.genero <> NEW.genero THEN
	UPDATE HechosConsultantes SET genero = NEW.genero WHERE HechosConsultantes.Paciente_RUT = OLD.RUT;
END IF;
IF OLD.sexo <> NEW.sexo THEN
	UPDATE HechosConsultantes SET sexo = NEW.sexo WHERE HechosConsultantes.Paciente_RUT = OLD.RUT;
END IF;
IF OLD.intentos_contacto <> NEW.intentos_contacto THEN
	UPDATE HechosConsultantes SET intentos_contacto = NEW.intentos_contacto WHERE HechosConsultantes.Paciente_RUT = OLD.RUT;
END IF;
IF OLD.Estado_id_Estado <> NEW.Estado_id_Estado THEN
	UPDATE HechosConsultantes SET Estado = (
		SELECT nombre FROM Estado WHERE id_Estado = NEW.Estado_id_Estado) 
		WHERE HechosConsultantes.Paciente_RUT = OLD.RUT;
END IF;
IF OLD.PrevisionSalud_id_PrevisionSalud <> NEW.PrevisionSalud_id_PrevisionSalud THEN
	UPDATE HechosConsultantes SET PrevisionSalud = (
		SELECT nombre FROM PrevisionSalud WHERE id_PrevisionSalud = NEW.PrevisionSalud_id_PrevisionSalud) 
		WHERE HechosConsultantes.Paciente_RUT = OLD.RUT;
END IF;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Contacto_AFTER_INSERT` AFTER INSERT ON `Contacto` FOR EACH ROW
BEGIN
UPDATE Paciente SET intentos_contacto = intentos_contacto + 1 WHERE RUT = NEW.Paciente_RUT; 
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Contacto_AFTER_DELETE` AFTER DELETE ON `Contacto` FOR EACH ROW
BEGIN
UPDATE Paciente SET intentos_contacto = intentos_contacto - 1 WHERE RUT = OLD.Paciente_RUT; 
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Estado (nombre) VALUES ('consultante');
INSERT INTO Estado (nombre) VALUES ('paciente');
INSERT INTO Estado (nombre) VALUES ('incontestado');
INSERT INTO PrevisionSalud (nombre) VALUES ('sin prevision');
INSERT INTO PrevisionSalud (nombre) VALUES ('fonasa');
INSERT INTO PrevisionSalud (nombre) VALUES ('isapre');
INSERT INTO TipoUsuario (nombre) VALUES ('Superadmin');
INSERT INTO TipoUsuario (nombre) VALUES ('FuncionarioAdmin');
INSERT INTO TipoUsuario (nombre) VALUES ('Supervisor');
INSERT INTO TipoUsuario (nombre) VALUES ('Terapeuta');
INSERT INTO Politica (nombre) VALUES ('usuarios.crear'); 
INSERT INTO Politica (nombre) VALUES ('usuarios.editar');
INSERT INTO Politica (nombre) VALUES ('usuarios.eliminar');
INSERT INTO Politica (nombre) VALUES ('usuarios.ver');
INSERT INTO Politica (nombre) VALUES ('consultantes.crear');
INSERT INTO Politica (nombre) VALUES ('consultantes.ver');
INSERT INTO Politica (nombre) VALUES ('consultantes.editar');
INSERT INTO Politica (nombre) VALUES ('consultantes.borrar');
INSERT INTO Politica (nombre) VALUES ('pacientes.ver');
INSERT INTO Politica (nombre) VALUES ('pacientes.crear');
INSERT INTO Politica (nombre) VALUES ('pacientes.editar');
INSERT INTO Politica (nombre) VALUES ('terapeutas.ver');
INSERT INTO Politica (nombre) VALUES ('terapeutas.crear');
INSERT INTO Politica (nombre) VALUES ('terapeutas.editar');
INSERT INTO Politica (nombre) VALUES ('homegestion.ver');
INSERT INTO Politica (nombre) VALUES ('homeadm.ver');
INSERT INTO Politica (nombre) VALUES ('home.ver');
INSERT INTO Politica (nombre) VALUES ('llamadas.ver');
INSERT INTO Politica (nombre) VALUES ('llamadas.crear');
INSERT INTO Politica (nombre) VALUES ('llamadas.editar');
INSERT INTO Politica (nombre) VALUES ('*');
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (1,21);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,5);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,6);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,7);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,9);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,10);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,11);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,12);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,13);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,14);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,16);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,18);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,19);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (2,20);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,5);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,6);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,7);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,9);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,10);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,11);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,12);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,13);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,16);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,18);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,19);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (3,20);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,17);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,18);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,19);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,20);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,5);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,6);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,7);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,8);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,9);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,10);
INSERT INTO Permiso (TipoUsuario_id_TipoUsuario, Politica_id_Politica) VALUES (4,11);
INSERT INTO Tipoinstitucion (nombre) VALUES ("universidad");
INSERT INTO Tipoinstitucion (nombre) VALUES ("colegio");
INSERT INTO Tipoinstitucion (nombre) VALUES ("fundacion");
INSERT INTO Tipoinstitucion (nombre) VALUES ("institucion publica");
INSERT INTO Tipoinstitucion (nombre) VALUES ("sindicato");
INSERT INTO Tipoinstitucion (nombre) VALUES ("corporacion");
INSERT INTO Motivo (nombre) VALUES ("voluntario");
INSERT INTO Motivo (nombre) VALUES ("tristeza");
INSERT INTO Motivo (nombre) VALUES ("estres");
INSERT INTO Motivo (nombre) VALUES ("crisis de panico");
INSERT INTO Motivo (nombre) VALUES ("hiperactividad");
INSERT INTO Motivo (nombre) VALUES ("retomar terapia");
INSERT INTO Motivo (nombre) VALUES ("bajo rendimiento academico");
INSERT INTO Motivo (nombre) VALUES ("defecit de atencion");
