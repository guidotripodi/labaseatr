SELECT 
    poseeDesc.nombreCategoria AS Categoria,
    producto.nombre AS Atraccion,
    poseeDesc.descuento AS descuento
FROM
    mydb.PoseeDescuento poseeDesc,
    mydb.Producto producto
WHERE
    producto.idProducto = poseeDesc.idProducto
        AND producto.tipoProducto LIKE 'atraccion';