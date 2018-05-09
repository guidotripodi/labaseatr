SELECT parque.nombre as Parque, producto.nombre as Atraccion , sum(consumo.importe) as facturacionTotal 
FROM mydb.Consumo consumo, mydb.Factura factura, mydb.Producto producto, 
mydb.Atraccion atraccion, mydb.Parque parque
where producto.idProducto = atraccion.idProducto and
parque.idParque = atraccion.idParque and
producto.idProducto = consumo.idProducto and 
factura.idTarjeta = consumo.idTarjeta and
factura.fechaEmitida > consumo.fechaYhora
and month(consumo.fechaYhora) >  (month(factura.fechaEmitida) - 1)
and year(consumo.fechaYhora) = year(consumo.fechaYhora)  
group by parque.nombre, consumo.idProducto