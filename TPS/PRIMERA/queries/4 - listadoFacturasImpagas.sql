SELECT f.numero as NumeroDeFactura , fechaVencimiento FROM mydb.Factura f, mydb.Recibo r
where f.fechaVencimiento <= now() AND
 r.numero != f.numero 
 ;