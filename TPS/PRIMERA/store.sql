CREATE PROCEDURE `cambiarCategorias` ()
BEGIN

    DECLARE conPromMensual INT DEFAULT 0;
    DECLARE conAcumAnual INT DEFAULT 0;
    DECLARE catCorresp INT DEFAULT 0;
    DECLARE catActual INT DEFAULT 0;
    
    -- De una sola query calculo el promedio mensual en el año actual y el gasto acumulado
SELECT 
    AVG(importeFactura), SUM(importeFactura)
INTO conPromMensual , conPromMensual FROM
    (SELECT 
        SUM(importe) AS importeFactura
    FROM
        Consumos
    WHERE
        idTarjeta = t.idTarjeta
    GROUP BY YEAR(CURDATE()) , MONTH(CURDATE()) DESC);
    -- La categoria actual es aquella que en la relacion perteneceA posee la fecha mas reciente
SELECT 
    nombreCategoria, x, y, MAX(pa.fecha)
INTO catActual FROM
    Categoria c,
    perteneceA pa
WHERE
    c.nobreCategoria = pa.nombreCategoria
        AND pa.idTarjeta = t.idTarjeta
GROUP BY nombreCategoria , x , y;
    -- la categoria correspondiente va a ser aquella a la que se le haya superado el limite x
SELECT 
    nombreCategoria, x, y, MAX(x)
INTO catCorresp FROM
    Categoria
WHERE
    x > conAcumAnual
GROUP BY nombreCategoria , x , y;
    
    -- Si el consumo mensual es adecuado para la categoria actual, y la categoria correspondiente no es mayor a la actual, entonces la categoria correspondiente es la actual
    -- En cualquier otro caso, la categoria se resuelve por el parametro x
    IF catActual.y <= conPromMensual and catCorresp.x <= catActual.x THEN
    	SET catCorresp = catActual;
    
    END IF;
        
    INSERT INTO PerteneceA VALUES (t,idTarjeta,catCorresp.nombreCategoria, CURDATE());

END