-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
use mydb;

DROP PROCEDURE IF EXISTS `cambiarCategorias` ;

DELIMITER $$


CREATE PROCEDURE `cambiarCategorias` ()
BEGIN

    DECLARE conPromMensual INT DEFAULT 0;
    DECLARE conAcumAnual INT DEFAULT 0;
    DECLARE catCorresp_nombre VARCHAR(50) DEFAULT NULL;
    DECLARE catActual_nombre VARCHAR(50) DEFAULT NULL;
    DECLARE catActual_x INT DEFAULT 0;
    DECLARE catActual_y INT DEFAULT 0;
    DECLARE catCorresp_x INT DEFAULT 0;
    DECLARE catCorresp_y INT DEFAULT 0;
    
    -- De una sola query calculo el promedio mensual en el año actual y el gasto acumulado
SELECT 
    SUM(importe), AVG(importe)
INTO conAcumAnual , conPromMensual FROM
    Consumo c
WHERE
    c.idTarjeta = 1
        AND YEAR(c.fechaYhora) = YEAR(CURDATE())
GROUP BY YEAR(fechaYhora) DESC;
    
    -- La categoria actual es aquella que en la relacion perteneceA posee la fecha mas reciente
SELECT 
    pa1.nombreCategoria, x, y INTO catActual_nombre, catActual_x, catActual_y 
FROM
    PerteneceA pa1,
    Categoria c
WHERE
    pa1.nombreCategoria = c.nombreCategoria
        AND pa1.idTarjeta = 1
        AND pa1.fechaDesde = (SELECT 
            MAX(pa2.fechaDesde)
        FROM
            PerteneceA pa2
        WHERE
            pa2.idTarjeta = 1);
    -- la categoria correspondiente va a ser aquella a la que se le haya superado el limite x
SELECT 
    nombreCategoria, x
INTO catCorresp_nombre, catCorresp_x FROM
    Categoria
WHERE
    x = (SELECT 
            MAX(x)
        FROM
            Categoria c
        WHERE
            c.x <= conAcumAnual);
    
    -- Si el consumo mensual es adecuado para la categoria actual, y la categoria correspondiente no es mayor a la actual, entonces la categoria correspondiente es la actual
    -- En cualquier otro caso, la categoria se resuelve por el parametro x
    IF catActual_y <= conPromMensual and catCorresp_x <= catActual_x THEN
    	SET catCorresp_nombre = catActual_nombre;
    
    END IF;
        
    INSERT INTO PerteneceA VALUES (1,catCorresp_nombre, CURDATE());

END