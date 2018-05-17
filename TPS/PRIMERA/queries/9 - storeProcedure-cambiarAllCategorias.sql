DROP PROCEDURE IF EXISTS `cambiarAllCategorias`;
DELIMITER $
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
END
