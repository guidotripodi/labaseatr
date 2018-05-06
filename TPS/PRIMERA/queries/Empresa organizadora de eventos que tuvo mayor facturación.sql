SELECT empresa.razonSocial , sum(consumo.importe) as facturacionTotal FROM mydb.Empresa empresa, mydb.Consumo consumo, mydb.Evento evento, mydb.Factura factura
where evento.idProducto = consumo.idProducto and
evento.idEmpresa = empresa.idEmpresa and
factura.idTarjeta = consumo.idTarjeta and
factura.fechaEmitida > consumo.fechaYhora
and month(consumo.fechaYhora) >  (month(factura.fechaEmitida) - 1)
and year(consumo.fechaYhora) = year(consumo.fechaYhora)  
group by empresa.razonSocial
having sum(consumo.importe) >= all (Select sum(consumo1.importe) FROM mydb.Empresa empresa1, mydb.Consumo consumo1,
 mydb.Evento evento1, mydb.Factura factura1
where evento1.idProducto = consumo1.idProducto and
evento1.idEmpresa = empresa1.idEmpresa and
factura1.idTarjeta = consumo1.idTarjeta and
factura1.fechaEmitida > consumo1.fechaYhora
and month(consumo1.fechaYhora) >  (month(factura1.fechaEmitida) - 1)
and year(consumo1.fechaYhora) = year(consumo1.fechaYhora) 
group by empresa1.razonSocial)