import mysql.connector

def nmlz(text):
  t = 30
  if len(text) < t:
    rem = t - len(text)
    while rem<>0:
      text+=" "
      rem-=1
  return text[0:t-1]

cnx = mysql.connector.connect(user='root',
                              password='Esteban1990',
                              host='127.0.0.1',
                              database='mydb')

cursor = cnx.cursor()

queryTarjetaYAtracciones = "SELECT t.idTarjeta, c.nombre, c.apellido, pa.nombreCategoria, p.idProducto, p.nombre as pn, p.tipoProducto, pq.nombre as nombreComp, pq.idParque as idComp  FROM Tarjeta t, Cliente c, PerteneceA pa, DaAcceso da, Producto p, Atraccion at, Parque pq WHERE t.idCliente=c.idCliente AND t.activada=true AND t.idTarjeta=pa.idTarjeta AND pa.fechaDesde = (SELECT MAX(fechaDesde) FROM PerteneceA pa2 WHERE pa2.idTarjeta = t.idTarjeta) AND da.idTarjeta=t.idTarjeta AND da.idProducto=p.idProducto AND p.idProducto=at.idProducto AND at.idParque = pq.idParque"
queryTarjetaYEventos = "SELECT t.idTarjeta, c.nombre, c.apellido, pa.nombreCategoria, p.idProducto, p.nombre as pn, p.tipoProducto, em.razonSocial as nombreComp, em.idEmpresa as idComp FROM Tarjeta t, Cliente c, PerteneceA pa, DaAcceso da, Producto p, Evento ev, Empresa em WHERE t.idCliente=c.idCliente AND t.activada=true AND t.idTarjeta=pa.idTarjeta AND pa.fechaDesde = (SELECT MAX(fechaDesde) FROM PerteneceA pa2 WHERE pa2.idTarjeta = t.idTarjeta) AND da.idTarjeta=t.idTarjeta AND da.idProducto=p.idProducto AND p.idProducto=ev.idProducto AND ev.idEmpresa = em.idEmpresa"
queryTarjetaYProductos = ("SELECT * FROM ( ("+queryTarjetaYAtracciones+") UNION ("+queryTarjetaYEventos+") ) a  ORDER BY idTarjeta, idProducto")

idProductosXidTarjetas = {}
cursor.execute(queryTarjetaYProductos)

#Print de todas las opciones
print("Productos x Tarjetas")
idTarjeta = -1
nombreComp = ""
for row in cursor:
  if idTarjeta <> row[0]:
    print row[0]," - [",row[3],"] ",row[1],row[2]
    idTarjeta = row[0]
    idProductosXidTarjetas[row[0]] = {}
  print "\t",row[4],"\t",nmlz(row[5]),"\t",nmlz(row[7])
  idProductosXidTarjetas[row[0]][row[4]] = row


#Creamos el consumo
print "Seleccione una tarjeta (id)"
tarjeta = input("Id de la tarjeta: ")

m = idProductosXidTarjetas[tarjeta]
print "Seleccione un producto (id)"
#Print de productos que puede consumir tarjeta
for r in m:

  print "\t",m[r][4],"\t",nmlz(m[r][5]),"\t",nmlz(m[r][7])

producto = input("Id del producto: ")



queryPrecio = ("SELECT p.diaSemana, p.valor FROM Precio p  WHERE p.idProducto = "+str(producto))
queryDescuento = ("SELECT descuento FROM PoseeDescuento WHERE idProducto="+str(producto)+" AND nombreCategoria='"+m[producto][3]+"'")
cursor.execute(queryDescuento)

descuento = 0
for row in cursor:
  descuento = row[0]

cursor.execute(queryPrecio)
print "Precios x dia (con descuento del %"+str(descuento)+")"
diaYPrecio = {}
for row in cursor:
  print row[0],"\tPrecio neto: $",str(row[1]),"\tcon descuento: $",str(float(row[1]) - float(row[1])*descuento/100.0)
  diaYPrecio[str(row[0])]= float(row[1]) - float(row[1])*descuento/100.0

dDay = raw_input("Letra del dia: ")
print dDay
cnx.close()
#metodo para hacer el insert


nomProd = idProductosXidTarjetas[tarjeta][producto][5]
nomComercio = idProductosXidTarjetas[tarjeta][producto][7]

print "La tarjeta "+str(tarjeta)+" consumira el producto '"+nomProd+"' pagando $"+str(diaYPrecio[dDay])+" a '"+nomComercio+"'"