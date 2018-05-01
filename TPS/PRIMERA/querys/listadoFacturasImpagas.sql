SELECT numero as NumeroDeFactura , fechaVencimiento FROM mydb.Factura, mydb.Recibo
where mydb.Factura.fechaVencimiento <= now() AND
 mydb.Recibo.idFactura != mydb.Factura.idFactura 
 ;