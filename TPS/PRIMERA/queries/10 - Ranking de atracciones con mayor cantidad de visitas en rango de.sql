delimiter $
CREATE PROCEDURE atraccionMayorVisita(IN fechaDesde datetime, IN fechaHasta datetime)
BEGIN
SELECT producto.nombre as ParqueAtraccion, count(*) as cantidadVisitado 
FROM Atraccion atraccion, Tarjeta tarjeta, Producto producto, Consumo consumo
WHERE atraccion.idProducto = producto.idProducto 
    AND consumo.fechaYhora >= fechaDesde 
    AND consumo.fechaYhora <= fechaHasta 
    AND producto.idProducto = consumo.idProducto 
GROUP BY consumo.idProducto
HAVING count(*) >= ALL (SELECT count(*) as count 
       FROM mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, Producto producto, Consumo consumo 
       WHERE atraccion.idProducto = producto.idProducto  
         AND consumo.fechaYhora >= fechaDesde
         AND consumo.fechaYhora <= fechaHasta
         AND producto.idProducto = consumo.idProducto
       GROUP BY consumo.idProducto)
;
END