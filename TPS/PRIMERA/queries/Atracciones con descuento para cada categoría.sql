SELECT nombreCategoria as Categoria , nombre FROM mydb.PoseeDescuento, mydb.Producto , mydb.Atraccion   where
mydb.PoseeDescuento.idProducto = mydb.Atraccion.idProducto and mydb.Producto.idProducto = mydb.PoseeDescuento.idProducto
;