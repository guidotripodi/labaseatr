import rethinkdb as reth
from faker import Faker
import random
import sys
import time
fake = Faker()
fake.seed(4321)

print "Connecting to RethinkDB..."
conn = reth.connect()
print "Creating 'tp2' DB..."
base = reth.db_create('tp2').run(conn)
conn.close()
print "Connecting to 'tp2' DB..."
conn = reth.connect(db='tp2')

def insertarEmpresas(cantEmpresas):
	i = 0
	while i < cantEmpresas:
		empresa = {"empresaId": i, "pais": fake.country(),"provincia": fake.city(),"direccion": fake.address(),"razonSocial": fake.company()}
		reth.table("Empresa").insert(
		   empresa,
		    conflict="replace"
		).run(conn)
		i += 1  
def insertarCategorias():
	categorias = [{"nombre": "Comun", "x": 0,"y": 0},{"nombre": "Silver", "x": 100,"y": 1000},{"nombre": "Gold", "x": 1000,"y": 10000},{"nombre": "Black", "x": 10000,"y": 100000}]
	for categoria in categorias:
		reth.table("Categoria").insert(categoria, conflict="replace").run(conn)

categorias = ['Comun','Silver','Gold','Black']

def insertarProductoEvento(compania, desde, hasta, cantCompanias):	 
	i = desde
	j = 0
	categorias = ['Comun','Silver','Gold','Black']
	while i < hasta:
		evento = {"id": i,"tipo": "evento",compania: random.randint(0,cantCompanias),
            "nombre": fake.name(),
            "categoriasDescuentos": [{"nombreCategoria":random.choice(categorias),"descuento":80.00 }],
			"precios": [{"dia":"L","valor":20.00},{"dia":"M","valor":50.00},{"dia":"X","valor":10.00},{"dia":"J","valor":100.00},{"dia":"V","valor":200.00},{"dia":"S","valor":250.00},{"dia":"D","valor":500.00}]
			,"edadDesde":"2","edadHasta":"1000","fechaDesde":fake.date()+fake.time(),"fechaHasta":fake.date()+fake.time()}
 
		reth.table("Producto").insert(
		   evento,
		    conflict="replace"
		).run(conn)
		i += 1  


def insertarProductoAtraccion(parque, desde, hasta, cantParques):	 
	i = desde
	j = 0
	categorias = ['Comun','Silver','Gold','Black']
	while i < hasta:
		atraccion = {"id": i,"tipo": "atraccion",parque: random.randint(0,cantParques),
            "nombre": fake.name(),
            "categoriasDescuentos": [{"nombreCategoria":random.choice(categorias),"descuento":80.00 }],
			"precios": [{"dia":"L","valor":20.00},{"dia":"M","valor":50.00},{"dia":"X","valor":10.00},{"dia":"J","valor":100.00},{"dia":"V","valor":200.00},{"dia":"S","valor":250.00},{"dia":"D","valor":500.00}]
			,"edadDesde":"2","edadHasta":"1000","fechaDesde":fake.date()+fake.time(),"fechaHasta":fake.date()+fake.time()}
 
		reth.table("Producto").insert(
		   atraccion,
		    conflict="replace"
		).run(conn)
		i += 1  


def insertarParque(prodId):	  
	i = 0
	a = prodId

	while i<10:
		parque = {"parqueId": i,
	           "nombre": fake.company(),
	           "ubicacion": fake.city(),
	           "atracciones":[
	                       {"productoId":a, "edadDesde":random.randint(2,10), "edadHasta":random.randint(10,1000)},
	                       {"productoId":a+1, "edadDesde":random.randint(2,10), "edadHasta":random.randint(10,1000)}
	                   ]
	             }
		a+=2
		reth.table("Parque").insert(parque,conflict="replace").run(conn)
		i += 1  




def insertarCliente(cantCliente):	  
	i = 0
	while i<cantCliente:
		parque = {"ClienteId":i,
        "nombre":fake.first_name(),
        "apellido":fake.last_name(),
        "domicilioFacturacion":fake.address(),
        "foto":fake.image_url(),
        "nombreMedioPago":"Tarjeta",
        "tarjetas":[{"numero": i}],
         "telefonos":[{"numero": fake.phone_number()}]}
		reth.table("Cliente").insert(parque,conflict="replace").run(conn)
		i += 1  

def insertarTarjeta(cantTarjeta):
	productos = reth.table("Producto").run(conn)

	i = 0
	while i<cantTarjeta:
		producto1 = productos.next()
		producto2 = productos.next()
		parque = {"numero":i,
                  "categoria":random.choice(categorias),
                  "activada":True,
                  "idCliente":i,
                  "productos":[{"productoId":producto1['id'],"nombre":producto1['nombre']},
                  {"productoId":producto2['id'],"nombre":producto2['nombre']}]
                }
		reth.table("Tarjeta").insert(parque,conflict="replace").run(conn)
		i += 1  


def insertarFactura(cantFactura):
	i = 0
	while i<cantFactura:
		Factura = { "facturaId":i,
        "fechaEmitida":fake.date(),
        "fechaVencimiento":fake.date(),
        "importe":random.randint(100,5000),
        "tarjeta":i}
		reth.table("Factura").insert(Factura,conflict="replace").run(conn)
		i += 1  





def insertarConsumo(cantConsumo):
	i = 0
	tarjetas = reth.table("Tarjeta").run(conn)
	productos = reth.table("Producto").run(conn)

	tarjetasSet = [a for a in tarjetas]
	productosSet = [a for a in productos]
	batch = 500
	batchArray=[]
	saved = 0
	while i<cantConsumo:
		tarjeta = random.choice(tarjetasSet)
		producto = random.choice(productosSet)
		compania = 'parque'
		if 'empresa' in producto:
			compania = 'empresa'

		Consumo = { "idConsumo":i,
        "importe":random.randint(100,500),
        "fechaHora":fake.date()+fake.time(),
        "tarjeta":{"idCliente":tarjeta['idCliente'],
                "numero":tarjeta['numero'],
                "categoria":tarjeta['categoria']
             },
        "producto":{
        		"tipo": producto['tipo'],
                compania:producto[compania],
                "idProducto":producto['id'],
                "nombre":producto['nombre']
            },
        "facturaId":i}

		batchArray.append(Consumo)
		i += 1  
		if len(batchArray) > batch or i == cantConsumo:
			reth.table("Consumo").insert(batchArray,conflict="replace").run(conn)
			saved+=500
		
			sys.stdout.write("\r\t\tSaved: %d of %d ( %d percent) " % ( saved ,cantConsumo, float(saved)/float(cantConsumo) * 100))
			sys.stdout.flush() 
			batchArray = []

print "Creating tables..."
print "\tEmpresa"
reth.table_create("Empresa").run(conn)
print "\tCategoria"
reth.table_create("Categoria").run(conn)
print "\tProducto"
reth.table_create("Producto").run(conn)
print "\tParque"
reth.table_create("Parque").run(conn)
print "\tCliente"
reth.table_create("Cliente").run(conn)
print "\tTarjeta"
reth.table_create("Tarjeta").run(conn)
print "\tFactura"
reth.table_create("Factura").run(conn)
print "\tConsumo"
reth.table_create("Consumo").run(conn)

print "Creating documents..."
print "\tempresas"
insertarEmpresas(10)
print "\tparques"
insertarParque(20)
print "\tclientes"
insertarCliente(20)
print "\tcategorias"
insertarCategorias()
print "\teventos"
insertarProductoEvento("empresa", 0 ,20, 9)
print "\tatracciones"
insertarProductoAtraccion("parque", 20 ,40, 9)
print "\tfacturas"
insertarFactura(20)
print "\ttarjetas"
insertarTarjeta(20)
print "\tconsumos"
insertarConsumo(1000)
conn.close()
print "\nEnd of script"

#Para crear shards hay que tener mas servers de rethink andando: hay que usar la siguiente instruccion variando el --port-offset 1 y --directory rethinkdb_data2
#rethinkdb --port-offset 1 --directory rethinkdb_data2 --join localhost:29015
#Una vez corriendo, en el Browser le pedis para la tabla consumo mas shards