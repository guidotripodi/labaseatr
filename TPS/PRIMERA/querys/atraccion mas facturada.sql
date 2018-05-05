SELECT producto.nombre as Atraccion, sum(consumo.importe) as facturacionTotal FROM mydb.Consumo consumo, mydb.Producto producto, mydb.Atraccion atraccion, 
mydb.Factura factura
where producto.idProducto = atraccion.idProducto and
producto.idProducto = consumo.idProducto and 
factura.idTarjeta = consumo.idTarjeta and
factura.fechaEmitida > consumo.fechaYhora
and month(consumo.fechaYhora) >  (month(factura.fechaEmitida) - 1)
and year(consumo.fechaYhora) = year(consumo.fechaYhora)  
group by consumo.idProducto
having sum(consumo.importe) >= ALL(Select sum(consumo1.importe) from mydb.Consumo consumo1, mydb.Atraccion atraccion1, mydb.Producto producto1, mydb.Factura factura1 where
consumo1.idProducto != consumo.idProducto and
producto1.idProducto = atraccion1.idProducto and
consumo1.idProducto = producto1.idProducto and
consumo1.idTarjeta = factura1.idTarjeta
and factura1.fechaEmitida > consumo1.fechaYhora
and month(consumo1.fechaYhora) > (month(factura1.fechaEmitida) - 1)
and year(consumo1.fechaYhora) = year(consumo1.fechaYhora)
);