SELECT nombre, apellido, nombreCategoria, fechaInicio FROM mydb.Cliente, mydb.pertenece, mydb.Tarjeta where
mydb.Cliente.idCliente = mydb.Tarjeta.idCliente ;