drop procedure if exists `atraccionMayorVisita`;
delimiter $
create procedure atraccionMayorVisita(in fechaInicio datetime, in fechaFin datetime)
begin
SELECT cliente.nombre as Nombre, cliente.apellido as Apellido, pertenece.nombreCategoria as Categoria, pertenece.fechaDesde as Fecha FROM 
mydb.Cliente cliente, mydb.perteneceA pertenece, mydb.Tarjeta tarjeta where
cliente.idCliente = tarjeta.idCliente and
pertenece.fechaDesde >= fechaInicio and
pertenece.fechaDesde <= fechaFin
;
end
$
