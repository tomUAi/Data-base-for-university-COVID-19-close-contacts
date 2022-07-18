-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Justificaciones_Covid_UAI
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Justificaciones_Covid_UAI
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Justificaciones_Covid_UAI` DEFAULT CHARACTER SET utf8 ;
USE `Justificaciones_Covid_UAI` ;

-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Alumno` (
  `Rut` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Rut`),
  UNIQUE INDEX `Mail_UNIQUE` (`Mail` ASC) ,
  UNIQUE INDEX `Rut_UNIQUE` (`Rut` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Carrera` (
  `Cod_carrera` INT NOT NULL AUTO_INCREMENT,
  `Nombre_carrera` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_carrera`),
  UNIQUE INDEX `Nombre_carrera_UNIQUE` (`Nombre_carrera` ASC) ,
  UNIQUE INDEX `Cod_carrera_UNIQUE` (`Cod_carrera` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Asignatura` (
  `Cod_asignatura` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Asignatura` VARCHAR(45) NOT NULL,
  `Carrera_Cod_carrera` INT NOT NULL,
  PRIMARY KEY (`Cod_asignatura`),
  INDEX `fk_Asignatura_Carrera1_idx` (`Carrera_Cod_carrera` ASC) ,
  UNIQUE INDEX `Nombre_Asignatura_UNIQUE` (`Nombre_Asignatura` ASC) ,
  UNIQUE INDEX `Cod_asignatura_UNIQUE` (`Cod_asignatura` ASC) ,
  CONSTRAINT `fk_Asignatura_Carrera1`
    FOREIGN KEY (`Carrera_Cod_carrera`)
    REFERENCES `Justificaciones_Covid_UAI`.`Carrera` (`Cod_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Sec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Sec` (
  `Cod_Sec` INT NOT NULL AUTO_INCREMENT,
  `Num_Sec` INT NOT NULL,
  `Asignatura_Cod-asignatura` INT NOT NULL,
  PRIMARY KEY (`Cod_Sec`),
  INDEX `fk_Curso_Asignatura1_idx` (`Asignatura_Cod-asignatura` ASC) ,
  UNIQUE INDEX `Cod_Sec_UNIQUE` (`Cod_Sec` ASC) ,
  CONSTRAINT `fk_Curso_Asignatura1`
    FOREIGN KEY (`Asignatura_Cod-asignatura`)
    REFERENCES `Justificaciones_Covid_UAI`.`Asignatura` (`Cod_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Relacion_Alumnos_Sec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Relacion_Alumnos_Sec` (
  `Id_relaciones_alm_sec` INT NOT NULL AUTO_INCREMENT,
  `Sec_Cod_Sec` INT NOT NULL,
  `Alumno_Rut` INT NOT NULL,
  PRIMARY KEY (`Id_relaciones_alm_sec`, `Sec_Cod_Sec`, `Alumno_Rut`),
  INDEX `fk_Relacion_Alumnos_Sec_Sec1_idx` (`Sec_Cod_Sec` ASC) ,
  INDEX `fk_Relacion_Alumnos_Sec_Alumno1_idx` (`Alumno_Rut` ASC) ,
  UNIQUE INDEX `Id_relaciones_alm_sec_UNIQUE` (`Id_relaciones_alm_sec` ASC) ,
  CONSTRAINT `fk_Relacion_Alumnos_Sec_Sec1`
    FOREIGN KEY (`Sec_Cod_Sec`)
    REFERENCES `Justificaciones_Covid_UAI`.`Sec` (`Cod_Sec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Relacion_Alumnos_Sec_Alumno1`
    FOREIGN KEY (`Alumno_Rut`)
    REFERENCES `Justificaciones_Covid_UAI`.`Alumno` (`Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Profesor` (
  `Rut` VARCHAR(45) NOT NULL,
  `Nombre_prof` INT NOT NULL,
  `Apellido_prof` VARCHAR(45) NOT NULL,
  `Mail_prof` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Rut`),
  UNIQUE INDEX `Mail_prof_UNIQUE` (`Mail_prof` ASC) ,
  UNIQUE INDEX `Rut_UNIQUE` (`Rut` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Relacion_Profesor_Sec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Relacion_Profesor_Sec` (
  `Id_relaciones_prof_sec` INT NOT NULL AUTO_INCREMENT,
  `Sec_Cod_Sec` INT NOT NULL,
  `Profesor_Rut` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_relaciones_prof_sec`, `Sec_Cod_Sec`, `Profesor_Rut`),
  INDEX `fk_Relacion_Profesor_Sec_Sec1_idx` (`Sec_Cod_Sec` ASC) ,
  INDEX `fk_Relacion_Profesor_Sec_Profesor1_idx` (`Profesor_Rut` ASC) ,
  UNIQUE INDEX `Id_relaciones_prof_sec_UNIQUE` (`Id_relaciones_prof_sec` ASC) ,
  CONSTRAINT `fk_Relacion_Profesor_Sec_Sec1`
    FOREIGN KEY (`Sec_Cod_Sec`)
    REFERENCES `Justificaciones_Covid_UAI`.`Sec` (`Cod_Sec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Relacion_Profesor_Sec_Profesor1`
    FOREIGN KEY (`Profesor_Rut`)
    REFERENCES `Justificaciones_Covid_UAI`.`Profesor` (`Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Evaluaciones_sec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Evaluaciones_sec` (
  `Id_evaluaciones_sec` INT NOT NULL AUTO_INCREMENT,
  `Nombre_evaluacion` VARCHAR(45) NOT NULL,
  `Fecha_evaluacion` DATE NULL,
  `Sec_Cod_Sec` INT NOT NULL,
  PRIMARY KEY (`Id_evaluaciones_sec`, `Sec_Cod_Sec`),
  INDEX `fk_Evaluaciones_sec_Sec1_idx` (`Sec_Cod_Sec` ASC) ,
  UNIQUE INDEX `Id_evaluaciones_sec_UNIQUE` (`Id_evaluaciones_sec` ASC) ,
  CONSTRAINT `fk_Evaluaciones_sec_Sec1`
    FOREIGN KEY (`Sec_Cod_Sec`)
    REFERENCES `Justificaciones_Covid_UAI`.`Sec` (`Cod_Sec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Justificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Justificacion` (
  `Cod_Justificacion` INT NOT NULL AUTO_INCREMENT,
  `PCR_URL` VARCHAR(90) NOT NULL,
  `Alumno_Rut_Just` INT NOT NULL,
  PRIMARY KEY (`Cod_Justificacion`, `Alumno_Rut_Just`),
  UNIQUE INDEX `PCR_URL_UNIQUE` (`PCR_URL` ASC) ,
  UNIQUE INDEX `Cod_Justificacion_UNIQUE` (`Cod_Justificacion` ASC) ,
  INDEX `fk_Justificacion_Alumno1_idx` (`Alumno_Rut_Just` ASC) ,
  CONSTRAINT `fk_Justificacion_Alumno1`
    FOREIGN KEY (`Alumno_Rut_Just`)
    REFERENCES `Justificaciones_Covid_UAI`.`Alumno` (`Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Justificaciones_Covid_UAI`.`Respuesta_Secretaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Justificaciones_Covid_UAI`.`Respuesta_Secretaria` (
  `Id_Respuesta_Secretaria` INT NOT NULL AUTO_INCREMENT,
  `Respuesta` TINYINT(1) NULL,
  `Fecha_inicio_justificacion` DATE NULL,
  `Fecha_termino_justificacion` DATE NULL,
  `Justificacion_Cod_Justificacion` INT NOT NULL,
  PRIMARY KEY (`Id_Respuesta_Secretaria`, `Justificacion_Cod_Justificacion`),
  UNIQUE INDEX `Id_Respuesta_Secretaria_UNIQUE` (`Id_Respuesta_Secretaria` ASC) ,
  INDEX `fk_Respuesta_Secretaria_Justificacion1_idx` (`Justificacion_Cod_Justificacion` ASC) ,
  CONSTRAINT `fk_Respuesta_Secretaria_Justificacion1`
    FOREIGN KEY (`Justificacion_Cod_Justificacion`)
    REFERENCES `Justificaciones_Covid_UAI`.`Justificacion` (`Cod_Justificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
