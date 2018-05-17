
SELECT 
    parque.nombre AS nombreParque,
    producto.nombre AS nombreAtraccion
FROM
    mydb.Consumo consumo,
    mydb.Factura factura,
    mydb.Producto producto,
    mydb.Atraccion atraccion,
    mydb.Parque parque
WHERE
    producto.idProducto = atraccion.idProducto
        AND parque.idParque = atraccion.idParque
        AND producto.idProducto = consumo.idProducto
        AND factura.idTarjeta = consumo.idTarjeta
        AND factura.fechaEmitida > consumo.fechaYhora
        AND MONTH(consumo.fechaYhora) > (MONTH(factura.fechaEmitida) - 1)
        AND YEAR(consumo.fechaYhora) = YEAR(consumo.fechaYhora)
        AND producto.nombre =
        (SELECT 
            producto1.nombre AS Atraccion
        FROM
            mydb.Consumo consumo1,
            mydb.Factura factura1,
            mydb.Producto producto1,
            mydb.Atraccion atraccion1,
            mydb.Parque parque1
        WHERE
            producto1.idProducto = atraccion1.idProducto
                AND parque1.idParque = atraccion1.idParque
                AND producto1.idProducto = consumo1.idProducto
                AND factura1.idTarjeta = consumo1.idTarjeta
                AND factura1.fechaEmitida > consumo1.fechaYhora
                AND MONTH(consumo1.fechaYhora) > (MONTH(factura1.fechaEmitida) - 1)
                AND YEAR(consumo1.fechaYhora) = YEAR(consumo1.fechaYhora)
                AND parque1.idParque = parque.idParque
        GROUP BY parque1.nombre , consumo1.idProducto
        HAVING SUM(consumo1.importe) >= ALL (SELECT 
                SUM(consumo.importe) AS facturacionTotal
            FROM
                mydb.Consumo consumo,
                mydb.Factura factura,
                mydb.Producto producto,
                mydb.Atraccion atraccion,
                mydb.Parque parque2
            WHERE
                producto.idProducto = atraccion.idProducto
                    AND parque2.idParque = atraccion.idParque
                    AND producto.idProducto = consumo.idProducto
                    AND factura.idTarjeta = consumo.idTarjeta
                    AND factura.fechaEmitida > consumo.fechaYhora
                    AND MONTH(consumo.fechaYhora) > (MONTH(factura.fechaEmitida) - 1)
                    AND YEAR(consumo.fechaYhora) = YEAR(consumo.fechaYhora)
                    AND parque2.idParque = parque.idParque
            GROUP BY parque.nombre , consumo.idProducto))  GROUP BY parque.idParque, producto.idProducto