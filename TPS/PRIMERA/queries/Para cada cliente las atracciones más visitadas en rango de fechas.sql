
SELECT 
    cliente.nombre AS nombreCliente,
    cliente.apellido as apellidoCliente,
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
		AND producto.nombre = (SELECT 
            producto1.nombre AS Atraccion
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
                AND cliente1.idCliente = cliente.idCliente
		GROUP BY cliente1.nombre , consumo1.idProducto
        HAVING COUNT(consumo1.idProducto) >= ALL (SELECT 
                COUNT(consumo.idProducto) AS cantVisit
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
                    AND cliente.idCliente = cliente.idCliente
            GROUP BY cliente.nombre , consumo.idProducto));
            
      