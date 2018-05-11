SELECT 
    producto.nombre AS Atraccion,
    SUM(consumo.importe) AS facturacionTotal
FROM
    mydb.Consumo consumo,
    mydb.Producto producto,
    mydb.Atraccion atraccion,
    mydb.Factura factura,
    mydb.Parque parque
WHERE
    producto.idProducto = atraccion.idProducto
        AND parque.idParque = atraccion.idParque
        AND producto.idProducto = consumo.idProducto
        AND factura.idTarjeta = consumo.idTarjeta
        AND factura.fechaEmitida > consumo.fechaYhora
        AND MONTH(consumo.fechaYhora) > (MONTH(factura.fechaEmitida) - 1)
        AND YEAR(consumo.fechaYhora) = YEAR(consumo.fechaYhora)
GROUP BY consumo.idProducto
HAVING SUM(consumo.importe) >= ALL (SELECT 
        SUM(consumo1.importe)
    FROM
        mydb.Consumo consumo1,
        mydb.Atraccion atraccion1,
        mydb.Producto producto1,
        mydb.Factura factura1
    WHERE
        consumo1.idProducto != consumo.idProducto
            AND producto1.idProducto = atraccion1.idProducto
            AND consumo1.idProducto = producto1.idProducto
            AND consumo1.idTarjeta = factura1.idTarjeta
            AND factura1.fechaEmitida > consumo1.fechaYhora
            AND MONTH(consumo1.fechaYhora) > (MONTH(factura1.fechaEmitida) - 1)
            AND YEAR(consumo1.fechaYhora) = YEAR(consumo1.fechaYhora)
    GROUP BY consumo1.idProducto);