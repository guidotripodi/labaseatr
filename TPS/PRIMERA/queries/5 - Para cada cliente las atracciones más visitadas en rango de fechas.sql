delimiter $
create procedure atraccionMasVisitadaPorCliente(in fechaDesde datetime, in fechaHasta datetime)
begin
SELECT 
    cliente.nombre AS nombreCliente,
    cliente.apellido AS apellidoCliente,
    producto.nombre AS nombreAtraccion
FROM
    mydb.Consumo consumo,
    mydb.Tarjeta tarjeta,
    mydb.Producto producto,
    mydb.Cliente cliente
WHERE
    producto.tipoProducto LIKE 'atraccion'
        AND cliente.idCliente = tarjeta.idCliente
        AND tarjeta.idTarjeta = consumo.idTarjeta
        AND producto.idProducto = consumo.idProducto
        AND producto.idProducto IN (
        SELECT 
            producto1.idProducto AS AtraccionesDeMaximasVisitasXCliente
        FROM
            mydb.Consumo consumo1,
            mydb.Tarjeta tarjeta1,
            mydb.Producto producto1,
            mydb.Cliente cliente1
        WHERE
            producto1.tipoProducto LIKE 'atraccion'
                AND cliente1.idCliente = tarjeta1.idCliente
                AND tarjeta1.idTarjeta = consumo1.idTarjeta
                AND producto1.idProducto = consumo1.idProducto
                AND consumo1.fechaYhora >= fechaDesde 
                AND consumo1.fechaYhora <= fechaHasta 
             AND cliente1.idCliente = cliente.idCliente
        GROUP BY cliente1.nombre , consumo1.idProducto
        HAVING COUNT(consumo1.idProducto) >= ALL (SELECT 
                COUNT(consumo2.idProducto) AS cantidadVisitasAtraccionXCliente
            FROM
                mydb.Consumo consumo2,
                mydb.Tarjeta tarjeta2,
                mydb.Producto producto2,
                mydb.Cliente cliente2
            WHERE
                producto2.tipoProducto LIKE 'atraccion'
                    AND cliente2.idCliente = tarjeta2.idCliente
                    AND tarjeta2.idTarjeta = consumo2.idTarjeta
                    AND producto2.idProducto = consumo2.idProducto
                    AND cliente2.idCliente = cliente.idCliente
            GROUP BY cliente2.idCliente , consumo2.idProducto)
            
            
            ) GROUP BY cliente.idCliente, producto.idProducto;
            
            end
$
