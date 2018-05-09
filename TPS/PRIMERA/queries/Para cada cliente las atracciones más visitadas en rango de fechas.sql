SELECT T.nombreCliente, T.apellidoCliente, T.nombreAtraccion, MAX(cantidadVisitado) cantVisitado
FROM
( SELECT 
    c1.idTarjeta,
    c1.idProducto,
    cl1.nombre as nombreCliente,
    cl1.apellido as apellidoCliente,
    p.nombre AS nombreAtraccion,
    COUNT(*) AS cantidadVisitado
FROM
    mydb.Consumo c1,
    mydb.Producto p,
    mydb.Cliente cl1,
    mydb.Tarjeta t1
WHERE
    p.tipoProducto LIKE 'atraccion'
        AND cl1.idCliente = t1.idCliente
        AND c1.idTarjeta = t1.idTarjeta
        AND p.idProducto = c1.idProducto
        AND c1.fechaYhora >= '2017-04-01 00:00:00'
        AND c1.fechaYhora <= '2020-04-01 00:00:00'
GROUP BY c1.idTarjeta , c1.idProducto) T
 group by T.nombreCliente, T.apellidoCliente, T.nombreAtraccion
 ;