-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`MedioDePago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MedioDePago` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MedioDePago` (
  `nombreMedioDePago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombreMedioDePago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

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
DROP TABLE IF EXISTS `mydb`.`Telefono` ;

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
DROP TABLE IF EXISTS `mydb`.`Tarjeta` ;

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
DROP TABLE IF EXISTS `mydb`.`Factura` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `fechaEmitida` DATETIME NULL,
  `fechaVencimiento` DATETIME NULL,
  `numero` INT NOT NULL,
  `idTarjeta` INT NOT NULL,
  PRIMARY KEY (`numero`),
  CONSTRAINT `idTarjeta`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `mydb`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recibo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Recibo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Recibo` (
  `fecha` DATETIME NOT NULL,
  `numero` INT NOT NULL,
  PRIMARY KEY (`numero`),
  CONSTRAINT `fk_Recibo_Factura1`
    FOREIGN KEY (`numero`)
    REFERENCES `mydb`.`Factura` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empresa` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Empresa` (
  `idEmpresa` INT NOT NULL,
  `cuit` VARCHAR(45) NULL,
  `razonSocial` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `provincia/Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmpresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Producto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `tipoProducto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DaAcceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DaAcceso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DaAcceso` (
  `idTarjeta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idTarjeta`, `idProducto`),
  CONSTRAINT `fk_DaAcceso_Tarjeta`
    FOREIGN KEY (`idTarjeta`)
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
DROP TABLE IF EXISTS `mydb`.`Consumo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Consumo` (
  `idConsumo` INT NOT NULL,
  `fechaYhora` DATETIME NULL,
  `importe` DECIMAL NULL,
  `idTarjeta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idConsumo`),
  CONSTRAINT `fk_Consumo_DaAcceso`
    FOREIGN KEY (`idTarjeta` , `idProducto`)
    REFERENCES `mydb`.`DaAcceso` (`idTarjeta` , `idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Categoria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `nombreCategoria` VARCHAR(45) NOT NULL,
  `x` DECIMAL NULL,
  `y` DECIMAL NULL,
  PRIMARY KEY (`nombreCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Parque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Parque` (
  `idParque` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `ubicacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idParque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atraccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Atraccion` ;

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
DROP TABLE IF EXISTS `mydb`.`Evento` ;

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
DROP TABLE IF EXISTS `mydb`.`Precio` ;

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
DROP TABLE IF EXISTS `mydb`.`PoseeDescuento` ;

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
-- Table `mydb`.`PerteneceA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PerteneceA` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PerteneceA` (
  `idTarjeta` INT NOT NULL,
  `nombreCategoria` VARCHAR(45) NOT NULL,
  `fechaDesde` DATE NOT NULL,
  PRIMARY KEY (`idTarjeta`, `nombreCategoria`, `fechaDesde`),
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

USE `mydb` ;

-- -----------------------------------------------------
-- procedure cambiarAllCategorias
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`cambiarAllCategorias`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `cambiarAllCategorias` ()
BEGIN
	DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE v_idTarjeta INTEGER DEFAULT 0;
    DECLARE v_conPromMensual INT DEFAULT 0;
    DECLARE v_conAcumAnual INT DEFAULT 0;
    DECLARE v_catCorresp_nombre VARCHAR(50) DEFAULT NULL;
    DECLARE v_catActual_nombre VARCHAR(50) DEFAULT NULL;
    DECLARE v_catActual_x INT DEFAULT 0;
    DECLARE v_catActual_y INT DEFAULT 0;
    DECLARE v_catCorresp_x INT DEFAULT 0;
    DECLARE v_allIdsTarjetas CURSOR FOR SELECT idTarjeta FROM Tarjeta WHERE activada = 1;
    -- De una sola query calculo el promedio mensual en el año actual y el gasto acumulado
    
	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

	OPEN v_allIdsTarjetas;

	for_each_idTarjeta: LOOP

        FETCH v_allIdsTarjetas INTO v_idTarjeta;
        IF v_finished = 1 THEN 	LEAVE for_each_idTarjeta; END IF;

        -- Obtengo el consumo promedio por mes y el total gastado en el anio
        SELECT SUM(importe), AVG(importe) INTO v_conAcumAnual, v_conPromMensual 
        FROM  Consumo c
        WHERE c.idTarjeta = v_idTarjeta AND YEAR(c.fechaYhora) = YEAR(CURDATE())
        GROUP BY YEAR(fechaYhora) DESC;

        -- La categoria actual es aquella que en la relacion perteneceA posee la fecha mas reciente
        SELECT  pa1.nombreCategoria, x, y INTO v_catActual_nombre , v_catActual_x , v_catActual_y 
        FROM  PerteneceA pa1, Categoria c
        WHERE pa1.nombreCategoria = c.nombreCategoria
                AND pa1.idTarjeta = v_idTarjeta
                AND pa1.fechaDesde = (SELECT MAX(pa2.fechaDesde)
                                      FROM PerteneceA pa2
                                      WHERE pa2.idTarjeta = v_idTarjeta);

        -- La categoria correspondiente va a ser aquella a la que se le haya superado el limite x
        SELECT  nombreCategoria, x
        INTO v_catCorresp_nombre , v_catCorresp_x
        FROM  Categoria
        WHERE x = (SELECT MAX(x) FROM Categoria c  WHERE c.x <= v_conAcumAnual);

        -- Si el consumo mensual es adecuado para la categoria actual, y la categoria correspondiente no es mayor a la actual, entonces la categoria correspondiente es la actual
        -- En cualquier otro caso, la categoria se resuelve por el parametro x
        IF NOT (v_catActual_y <= v_conPromMensual and v_catCorresp_x <= v_catActual_x )THEN
        	INSERT INTO PerteneceA VALUES (v_idTarjeta,v_catCorresp_nombre, CURDATE());
        END IF;

        

    END LOOP for_each_idTarjeta;
    
	CLOSE v_allIdsTarjetas;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure atraccionMayorVisita
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`atraccionMayorVisita`;

DELIMITER $$
USE `mydb`$$
create procedure atraccionMayorVisita(in fechaDesde datetime, in fechaHasta datetime)
begin
SELECT producto.nombre as ParqueAtraccion, count(*) as cantidadVisitado FROM 
mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    consumo.fechaYhora >= fechaDesde and
    consumo.fechaYhora <= fechaHasta and
    producto.idProducto = consumo.idProducto 
group by consumo.idProducto
Having count(*) >= ALL (Select count(*) as count from mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, 
mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    consumo.fechaYhora >= fechaDesde and
    consumo.fechaYhora <= fechaHasta and
    producto.idProducto = consumo.idProducto
    group by consumo.idProducto)
;
end$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
