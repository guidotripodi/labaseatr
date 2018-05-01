-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `foto` VARCHAR(45) NULL,
  `domicilioFact` VARCHAR(45) NULL,
  `idMedioDePago` INT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MedioDePago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MedioDePago` (
  `idMedioDePago` INT NOT NULL,
  `nombreMedioDePago` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedioDePago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefono` (
  `idCliente` INT NOT NULL,
  `numero` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tarjeta` (
  `idTarjeta` INT NOT NULL,
  `idCliente` INT NULL,
  `idCategoria` INT NULL,
  `activada` TINYINT(1) NULL,
  `foto` VARCHAR(45) NULL,
  PRIMARY KEY (`idTarjeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL,
  `fechaEmitida` DATETIME NULL,
  `fechaVencimiento` DATETIME NULL,
  `numero` INT NULL,
  `tipo` VARCHAR(45) NULL,
  `idCliente` INT NULL,
  `idTarjeta` INT NULL,
  PRIMARY KEY (`idFactura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recibo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recibo` (
  `idFactura` INT NOT NULL,
  `numero` INT NULL,
  PRIMARY KEY (`idFactura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `tipoProducto` VARCHAR(45) NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empresa` (
  `idEmpresa` INT NOT NULL,
  `cuit` INT NULL,
  `razonSocial` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `provincia/Estado` VARCHAR(45) NULL,
  `idProducto` INT NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consumo` (
  `idConsumo` INT NOT NULL,
  `idProducto` INT NULL,
  `idTarjeta` INT NULL,
  `fechaYhora` DATETIME NULL,
  `importe` DECIMAL NULL,
  PRIMARY KEY (`idConsumo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `x` DECIMAL NULL,
  `y` DECIMAL NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Parque` (
  `idParque` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `ubicacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atraccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atraccion` (
  `idProducto` INT NOT NULL,
  `idParque` INT NULL,
  `edadDesde` INT NULL,
  `edadHasta` INT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Evento` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fechaDesde` DATETIME NULL,
  `fechaHasta` DATETIME NULL,
  `idEmpresa` INT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Precio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Precio` (
  `idProducto` INT NOT NULL,
  `diaSemana` VARCHAR(45) NULL,
  `valor` DECIMAL NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PoseeDescuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PoseeDescuento` (
  `idCategoria` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `descuento` FLOAT NULL,
  PRIMARY KEY (`idCategoria`, `idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DaAcceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DaAcceso` (
  `idTarjeta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idTarjeta`, `idProducto`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
