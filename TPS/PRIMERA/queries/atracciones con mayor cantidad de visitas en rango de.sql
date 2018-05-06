
SELECT producto.nombre as ParqueAtraccion, count(*) as cantidadVisitado FROM 
mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    producto.idProducto = consumo.idProducto 
group by consumo.idProducto
Having count(*) >= ALL (Select count(*) as count from mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, 
mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    producto.idProducto = consumo.idProducto
    group by consumo.idProducto)
;
