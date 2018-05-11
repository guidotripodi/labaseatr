SELECT 
    empresa.razonSocial,
    SUM(consumo.importe) AS facturacionTotal
FROM
    Empresa empresa,
    Consumo consumo,
    mydb.Evento evento,
    mydb.Factura factura
WHERE
    evento.idProducto = consumo.idProducto
        AND evento.idEmpresa = empresa.idEmpresa
        AND factura.idTarjeta = consumo.idTarjeta
        AND factura.fechaEmitida > consumo.fechaYhora
        AND MONTH(consumo.fechaYhora) > (MONTH(factura.fechaEmitida) - 1)
        AND YEAR(consumo.fechaYhora) = YEAR(consumo.fechaYhora)
GROUP BY empresa.razonSocial
HAVING SUM(consumo.importe) >= ALL (SELECT 
        SUM(consumo1.importe)
    FROM
        Empresa empresa1,
        Consumo consumo1,
        Evento evento1,
        Factura factura1
    WHERE
        evento1.idProducto = consumo1.idProducto
            AND evento1.idEmpresa = empresa1.idEmpresa
            AND factura1.idTarjeta = consumo1.idTarjeta
            AND factura1.fechaEmitida > consumo1.fechaYhora
            AND MONTH(consumo1.fechaYhora) > (MONTH(factura1.fechaEmitida) - 1)
            AND YEAR(consumo1.fechaYhora) = YEAR(consumo1.fechaYhora)
    GROUP BY empresa1.razonSocial)