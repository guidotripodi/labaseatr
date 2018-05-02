SELECT producto.nombre as parqueAtraccion, count(*) as cantidadVisitado FROM mydb.Producto producto, mydb.Consumo consumo, mydb.Atraccion atraccion where
	atraccion.idProducto = producto.idProducto and producto.idProducto = consumo.idProducto AND
    (SELECT COUNT(*) FROM mydb.Consumo consumo where producto.idProducto = consumo.idProducto) >= 
    (SELECT COUNT(*) FROM mydb.Consumo consumo, mydb.Producto producto2 where 
    producto2.idProducto = consumo.idProducto and producto2.idProducto != producto.idProducto)
    GROUP BY consumo.idProducto
    ;
