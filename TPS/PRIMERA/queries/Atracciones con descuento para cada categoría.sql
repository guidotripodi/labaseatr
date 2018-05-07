SELECT poseeDesc.nombreCategoria as Categoria, producto.nombre as Atraccion, poseeDesc.descuento as descuento FROM mydb.PoseeDescuento poseeDesc, mydb.Producto producto where 
producto.idProducto = poseeDesc.idProducto and
producto.tipoProducto Like "atraccion";