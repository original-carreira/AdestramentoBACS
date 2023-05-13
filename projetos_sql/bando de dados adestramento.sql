-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema adestramento
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema adestramento
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `adestramento` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `adestramento` ;

-- -----------------------------------------------------
-- Table `adestramento`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `sigla_dep` VARCHAR(45) NULL,
  `descricao_dep` VARCHAR(50) NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adestramento`.`Militar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Militar` (
  `nip` INT UNSIGNED ZEROFILL NOT NULL,
  `posto_graduacao` VARCHAR(10) NOT NULL,
  `especialidade` VARCHAR(5) NOT NULL,
  `subespecialidade` VARCHAR(5) NULL,
  `nome_guerra` VARCHAR(25) NULL,
  `nome_completo` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`nip`, `Departamento_idDepartamento`),
  UNIQUE INDEX `nip_UNIQUE` (`nip` ASC) VISIBLE,
  INDEX `fk_Militar_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Militar_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `adestramento`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adestramento`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Curso` (
  `idCurso` INT NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `nome_curso` VARCHAR(45) NOT NULL,
  `descricao_curso` VARCHAR(100) NULL,
  `local` VARCHAR(20) NOT NULL,
  `modalidade_curso` VARCHAR(45) NULL,
  PRIMARY KEY (`idCurso`),
  UNIQUE INDEX `idCurso_UNIQUE` (`idCurso` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adestramento`.`Msg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Msg` (
  `idMsg` VARCHAR(10) NOT NULL,
  `mes_msg` CHAR(3) NOT NULL,
  `ano_msg` YEAR NOT NULL,
  `origem` VARCHAR(45) NULL,
  `destino` VARCHAR(45) NULL,
  `assunto` VARCHAR(100) NOT NULL,
  `recebida` TINYINT NULL,
  `transmitida` TINYINT NULL,
  `referencia` VARCHAR(55) NULL,
  PRIMARY KEY (`idMsg`, `mes_msg`),
  UNIQUE INDEX `idMsg_UNIQUE` (`idMsg` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adestramento`.`Incricao_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Incricao_Curso` (
  `Data_inicio` DATE NOT NULL,
  `Data_fim` DATE NOT NULL,
  `Militar_nip` INT UNSIGNED ZEROFILL NOT NULL,
  `Curso_idCurso` INT NOT NULL,
  `Msg_idMsg` VARCHAR(10) NOT NULL,
  `Msg_mes_msg` CHAR(3) NOT NULL,
  PRIMARY KEY (`Militar_nip`, `Curso_idCurso`, `Msg_idMsg`, `Msg_mes_msg`),
  INDEX `fk_Incricao_Curso_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  INDEX `fk_Incricao_Curso_Msg1_idx` (`Msg_idMsg` ASC, `Msg_mes_msg` ASC) VISIBLE,
  CONSTRAINT `fk_Incricao_Curso_Militar`
    FOREIGN KEY (`Militar_nip`)
    REFERENCES `adestramento`.`Militar` (`nip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incricao_Curso_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `adestramento`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incricao_Curso_Msg1`
    FOREIGN KEY (`Msg_idMsg` , `Msg_mes_msg`)
    REFERENCES `adestramento`.`Msg` (`idMsg` , `mes_msg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adestramento`.`Ficha_ADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adestramento`.`Ficha_ADE` (
  `OS_pub` INT NULL,
  `Bol_pub` VARCHAR(45) NULL,
  `ano_curso` YEAR NULL,
  `Curso_idCurso` INT NOT NULL,
  `Militar_nip` INT UNSIGNED ZEROFILL NOT NULL,
  `Militar_Departamento_idDepartamento` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Militar_nip`, `Militar_Departamento_idDepartamento`),
  INDEX `fk_Ficha_ADE_Militar1_idx` (`Militar_nip` ASC, `Militar_Departamento_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Ficha_ADE_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `adestramento`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ficha_ADE_Militar1`
    FOREIGN KEY (`Militar_nip` , `Militar_Departamento_idDepartamento`)
    REFERENCES `adestramento`.`Militar` (`nip` , `Departamento_idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
