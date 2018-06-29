import rethinkdb as reth
from faker import Faker
import random
fake = Faker()
fake.seed(4321)

#print fake.name()
#print fake.name()
#print fake.date(),fake.time() 
#print fake.integer()

conn = reth.connect(db='tp2')
def insertarEmpresas():
	i = 0
	while i < 10:
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

def insertarProducto(compania, desde, hasta, cantCompanias):	 
	i = desde
	j = 0
	categorias = ['Comun','Silver','Gold','Black']
	while i < hasta:
		evento = {"id": i, compania: random.randint(0,cantCompanias),
            "nombre": fake.name(),
            "categoriasDescuentos": [{"nombreCategoria":random.choice(categorias),"descuento":80.00 }],
			"precios": [{"dia":"L","valor":20.00},{"dia":"M","valor":50.00},{"dia":"X","valor":10.00},{"dia":"J","valor":100.00},{"dia":"V","valor":200.00},{"dia":"S","valor":250.00},{"dia":"D","valor":500.00}]
			,"edadDesde":"2","edadHasta":"1000","fechaDesde":fake.date()+fake.time(),"fechaHasta":fake.date()+fake.time()}
 
		reth.table("Producto").insert(
		   evento,
		    conflict="replace"
		).run(conn)
		i += 1  

#insertarProducto("empresa", 0 ,20, 9)


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


#insertarProducto("parque", 20, 40, 9)
#insertarParque(20)


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
		reth.table("Parque").insert(parque,conflict="replace").run(conn)
		i += 1  
#insertarProducto("parque", 20, 40, 9)

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


#insertarFactura(20)



def insertarConsumo(cantConsumo):
	i = 0
	tarjetas = reth.table("Tarjeta").run(conn)
	productos = reth.table("Producto").run(conn)
	while i<cantConsumo:
		tarjeta = tarjetas.next()
		producto = productos.next()
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
                compania:producto[compania],
                "idProducto":producto['id'],
                "nombre":producto['nombre']
            },
        "facturaId":i}
		reth.table("Consumo").insert(Consumo,conflict="replace").run(conn)
		i += 1  


insertarTarjeta(20)
insertarConsumo(20)
conn.close()
#consumo = {"idConsumo": i, 'importe':fake.number(),'fechaHora': fake.date(),fake.time() ,'tarjeta':{'idCliente': j, 'numero': tarjeta},'producto':{'tipo': tipo, 'empresa':compania, 'idProducto': producto, 'nombre': nomProd}}
#consumo = {'importe':diaYPrecio[dDay],'fechaHora': hoy,'tarjeta':{'idCliente': idCliente, 'numero': tarjeta},'producto':{'tipo': tipo, 'parque':compania, 'idProducto': producto, 'nombre': nomProd}}