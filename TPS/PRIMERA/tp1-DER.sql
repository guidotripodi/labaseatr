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
-- Table `mydb`.`MedioDePago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MedioDePago` (
  `nombreMedioDePago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombreMedioDePago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `foto` VARCHAR(45) NULL,
  `domicilioFact` VARCHAR(45) NULL,
  `nombreMedioDePago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_Cliente_MedioDePago1`
    FOREIGN KEY (`nombreMedioDePago`)
    REFERENCES `mydb`.`MedioDePago` (`nombreMedioDePago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefono` (
  `idCliente` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`, `numero`),
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tarjeta` (
  `idTarjeta` INT NOT NULL,
  `activada` TINYINT(1) NOT NULL,
  `foto` VARCHAR(45) NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idTarjeta`),
  CONSTRAINT `fk_Tarjeta_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL,
  `fechaEmitida` DATETIME NULL,
  `fechaVencimiento` DATETIME NULL,
  `numero` INT NOT NULL,
  `idTarjeta` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `idTarjeta`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `mydb`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recibo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recibo` (
  `fecha` INT NULL,
  `idFactura` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `fk_Recibo_Factura1`
    FOREIGN KEY (`idFactura`)
    REFERENCES `mydb`.`Factura` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `tipoProducto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DaAcceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DaAcceso` (
  `Tarjeta_idTarjeta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`Tarjeta_idTarjeta`, `idProducto`),
  CONSTRAINT `fk_DaAcceso_Tarjeta`
    FOREIGN KEY (`Tarjeta_idTarjeta`)
    REFERENCES `mydb`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DaAcceso_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consumo` (
  `idConsumo` INT NOT NULL,
  `fechaYhora` DATETIME NULL,
  `importe` DECIMAL NULL,
  `idTarjeta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idConsumo`, `idTarjeta`, `idProducto`),
  CONSTRAINT `fk_Consumo_DaAcceso`
    FOREIGN KEY (`idTarjeta` , `idProducto`)
    REFERENCES `mydb`.`DaAcceso` (`Tarjeta_idTarjeta` , `idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `nombreCategoria` VARCHAR(45) NOT NULL,
  `x` DECIMAL NULL,
  `y` DECIMAL NULL,
  PRIMARY KEY (`nombreCategoria`))
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
  `idParque` INT NOT NULL,
  `edadDesde` INT NULL,
  `edadHasta` INT NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `idParque`
    FOREIGN KEY (`idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Atraccion_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Evento` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fechaDesde` DATETIME NULL,
  `fechaHasta` DATETIME NULL,
  `idEmpresa` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `idEmpresa`
    FOREIGN KEY (`idEmpresa`)
    REFERENCES `mydb`.`Empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_Producto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Precio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Precio` (
  `diaSemana` VARCHAR(45) NOT NULL,
  `idProducto` INT NOT NULL,
  `valor` DECIMAL NOT NULL,
  PRIMARY KEY (`diaSemana`, `idProducto`),
  CONSTRAINT `fk_Precio_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PoseeDescuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PoseeDescuento` (
  `nombreCategoria` VARCHAR(45) NOT NULL,
  `idProducto` INT NOT NULL,
  `descuento` FLOAT NOT NULL,
  PRIMARY KEY (`nombreCategoria`, `idProducto`),
  CONSTRAINT `nombreCategoria`
    FOREIGN KEY (`nombreCategoria`)
    REFERENCES `mydb`.`Categoria` (`nombreCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProducto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`perteneceA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`perteneceA` (
  `idTarjeta` INT NOT NULL,
  `nombreCategoria` VARCHAR(45) NOT NULL,
  `fechaDesde` DATE NOT NULL,
  PRIMARY KEY (`idTarjeta`, `nombreCategoria`),
  CONSTRAINT `fk_Tarjeta_has_Categoria_Tarjeta1`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `mydb`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarjeta_has_Categoria_Categoria1`
    FOREIGN KEY (`nombreCategoria`)
    REFERENCES `mydb`.`Categoria` (`nombreCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
