SELECT cliente.nombre, cliente.apellido, producto.nombre, count(*) as cantidadVisitado FROM mydb.Cliente cliente, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	consumo.idTarjeta = tarjeta.idTarjeta and tarjeta.idCliente = cliente.idCliente and producto.idProducto = consumo.idProducto and
    (SELECT COUNT(*) FROM mydb.Consumo consumo where tarjeta.idTarjeta = consumo.idTarjeta
    and producto.idProducto = consumo.idProducto) >= (SELECT COUNT(*) FROM mydb.Consumo consumo, mydb.Producto producto2 where tarjeta.idTarjeta = consumo.idTarjeta
    and producto2.idProducto = consumo.idProducto
    and producto2.idProducto != producto.idProducto)
group by consumo.idTarjeta, consumo.idProducto
;
