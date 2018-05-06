SELECT cliente.nombre, cliente.apellido, producto.nombre, count(*) as cantidadVisitado FROM 
mydb.Cliente cliente, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	consumo.idTarjeta = tarjeta.idTarjeta and 
    tarjeta.idCliente = cliente.idCliente and
    producto.idProducto = consumo.idProducto 
group by consumo.idTarjeta, consumo.idProducto
Having count(*) >= ALL (Select count(*) as count from mydb.Cliente cliente, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	consumo.idTarjeta = tarjeta.idTarjeta and 
    tarjeta.idCliente = cliente.idCliente and
    producto.idProducto = consumo.idProducto 
    group by consumo.idTarjeta, consumo.idProducto)
;
