delimiter $
create procedure atraccionMayorVisita(in fechaDesde datetime, in fechaHasta datetime)
begin
SELECT producto.nombre as ParqueAtraccion, count(*) as cantidadVisitado FROM 
mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    consumo.fechaYhora >= fechaDesde and
    consumo.fechaYhora <= fechaHasta and
    producto.idProducto = consumo.idProducto 
group by consumo.idProducto
Having count(*) >= ALL (Select count(*) as count from mydb.Atraccion atraccion, mydb.Tarjeta tarjeta, 
mydb.Producto producto, mydb.Consumo consumo where
	atraccion.idProducto = producto.idProducto and 
    consumo.fechaYhora >= fechaDesde and
    consumo.fechaYhora <= fechaHasta and
    producto.idProducto = consumo.idProducto
    group by consumo.idProducto)
;
end
$
