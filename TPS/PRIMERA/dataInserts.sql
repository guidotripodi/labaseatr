USE mydb;

INSERT INTO `MedioDePago` (`nombreMedioDePago`) VALUES ('Credito');
INSERT INTO `MedioDePago` (`nombreMedioDePago`) VALUES ('Debito');
INSERT INTO `MedioDePago` (`nombreMedioDePago`) VALUES ('Transferencia');
INSERT INTO `MedioDePago` (`nombreMedioDePago`) VALUES ('Nota de pago');




INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (0, 'Lennie', 'Toy', 'http://lorempixel.com/640/480/', '2749 Lela Curve\nNorth Micahmouth, KY 42937', 'Credito');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (1, 'Jalyn', 'Dibbert', 'http://lorempixel.com/640/480/', '04156 Aufderhar Valleys\nWest Sidneyborough, O', 'Credito');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (2, 'Felicia', 'OConnell', 'http://lorempixel.com/640/480/', '6917 Feil Shore\nBartolettichester, MA 74286', 'Debito');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (3, 'Janet', 'Beer', 'http://lorempixel.com/640/480/', '88724 Luella Court Suite 578\nSouth Cora, SD 5', 'Transferencia');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (4, 'Annabelle', 'Kunde', 'http://lorempixel.com/640/480/', '719 Kory Causeway Suite 783\nAlisafort, OK 768', 'Transferencia');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (5, 'Mittie', 'Kirlin', 'http://lorempixel.com/640/480/', '263 Will Street Suite 018\nWest Jaydontown, AR', 'Credito');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (6, 'Roman', 'Wilkinson', 'http://lorempixel.com/640/480/', '174 Giovani Overpass\nNew Bonnie, NH 74590-463', 'Transferencia');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (7, 'Rhianna', 'Lynch', 'http://lorempixel.com/640/480/', '5604 Waters Road Apt. 232\nEast Jovany, MS 067', 'Transferencia');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (8, 'Archibald', 'Moen', 'http://lorempixel.com/640/480/', '540 Huel Fords\nNorth Benniemouth, MD 74463-40', 'Debito');
INSERT INTO `Cliente` (`idCliente`, `nombre`, `apellido`, `foto`, `domicilioFact`, `nombreMedioDePago`) VALUES (9, 'Angela', 'Mertz', 'http://lorempixel.com/640/480/', '4469 Robin Crossing Suite 103\nMichelleberg, N', 'Credito');


INSERT INTO `Categoria` (`nombreCategoria`, `x`, `y`) VALUES ('Silver', 0, 0);
INSERT INTO `Categoria` (`nombreCategoria`, `x`, `y`) VALUES ('Gold', 10000, 1000);
INSERT INTO `Categoria` (`nombreCategoria`, `x`, `y`) VALUES ('Black', 100000, 10000);
INSERT INTO `Categoria` (`nombreCategoria`, `x`, `y`) VALUES ('Diamond', 500000, 50000);


INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (0, 2147649760, 'Gutkowski PLC', 'Monaco', '81215 Powlowski Lodge\nRutherfordmouth, IN 209', 'Konopelskishire');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (1, 9247483641, 'Gorczany-Morissette', 'Benin', '6846 Howell Ridge\nNorth Molly, DE 62757', 'Lake Katarinafort');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (2, 8147483642, 'Goldner, Bosco and Becker', 'Morocco', '5270 Pacocha Flat Suite 657\nWhitemouth, CT 23', 'Shawnbury');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (3, 7547483993, 'Nolan LLC', 'Malaysia', '15047 Rolfson Groves\nSouth Abigale, CO 84890', 'Juwanborough');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (4, 6647233644, 'Bosco Inc', 'Netherlands Antilles', '4981 Neil Spur\nNew Stephania, UT 16755', 'East Otho');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (5, 5947483645, 'Harber and Sons', 'Trinidad and Tobago', '6660 Haag Avenue Apt. 438\nCamrontown, SC 9325', 'Bradtkebury');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (6, 4947343646, 'Bauch LLC', 'New Zealand', '3418 Tianna Track\nGreenborough, CT 11596', 'North Emmanuelle');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (7, 3147483647, 'Keeling-Blanda', 'Saint Barthelemy', '15781 Weimann Spring Suite 135\nNew Buddytown,', 'North Arthurview');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (8, 2147543648, 'Schroeder, Gottlieb and Sawayn', 'Azerbaijan', '3611 Gutmann Mission\nWillardfort, OH 29198', 'Lake Gilda');
INSERT INTO `Empresa` (`idEmpresa`, `cuit`, `razonSocial`, `pais`, `direccion`, `provincia/Estado`) VALUES (9, 1247483649, 'Keeling-Johns', 'Congo', '16164 Rogelio Loop\nBodeshire, CT 31885-4620', 'New Cortney');




INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (0, 'Discovery Cove', '810 Reinger Fields Apt. 314\nWaelchifort, ID 8');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (1, 'Europa Park', '31316 Ebert Shoals Suite 429\nEast Willbury, N');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (2, 'Islands of Adventure de Universal', '728 Krajcik Drive\nWest Cullenborough, NV 5365');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (3, 'Magic Kingdom', '4695 Kilback Walks\nDanielchester, RI 44407-55');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (4, 'Hollywood Studios ', '0138 Hilll Flat Suite 052\nEast Coreneside, MA');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (5, 'Beto Carrero World, Bartoletti and Schulist', '51475 Fisher Dale\nEdwinaton, ND 68899-7022');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (6, 'Disneyland Park', '833 Hammes Parkways\nLake Lonie, MD 04804-9820');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (7, 'Tokio Disneyland', '0924 Lind Underpass\nBrennamouth, WV 17355');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (8, 'Ocean Park', '1722 Lang Port Suite 334\nNorth Carleton, SD 8');
INSERT INTO `Parque` (`idParque`, `nombre`, `ubicacion`) VALUES (9, 'Everland', '1349 Fannie Inlet\nPacochatown, NY 64374');



INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (0, 'Tiro al pato', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (1, 'Corrida de toros', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (4, 'Año nuevo', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (5, 'Fugiat ea dolores.', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (7, 'Piquete Au Illia', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (9, 'Quo non nemo.', 'evento');

INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (10, 'Fiesta de colores', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (11, 'Haraiquiri', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (12, 'Concierto de AC/DC', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (13, 'Caida del muro', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (14, 'Golpe de estado', 'evento');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (15, 'Busqueda de Nemo', 'evento');

INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (2, 'Montaña rusa Muerte Ambulante', 'atraccion');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (3, 'Enim non.', 'atraccion');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (6, 'Bola de estambre', 'atraccion');
INSERT INTO `Producto` (`idProducto`, `nombre`, `tipoProducto`) VALUES (8, 'Accusantium accusantium facilis.', 'atraccion');


INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (0, '2017-01-01', '2017-03-01',0);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (1, '2017-02-01', '2017-04-01',1);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (4, '2017-02-01', '2017-06-01',2);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (5, '2018-03-01', '2018-07-01',3);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (7, '2017-04-01', '2017-05-01',4);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (9, '2017-05-01', '2017-09-01',5);

INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (10, '2017-01-01', '2017-03-01',0);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (11, '2017-02-01', '2017-04-01',0);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (12, '2017-02-01', '2017-06-01',2);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (13, '2018-03-01', '2018-07-01',2);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (14, '2017-04-01', '2017-05-01',4);
INSERT INTO `Evento` (`idProducto`, `fechaDesde`,`fechaHasta` `idEmpresa`) VALUES (15, '2017-05-01', '2017-09-01',9);



INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (0, '156546-54651');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (0, '4529854-58458');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (1, '54-654654-64568');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (1, '89-536-556');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (2, '12-4556-4556');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (2, '82-9663589');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (2, '655-5685456-55263');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (3, '78-96-32');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (4, '7-965-5859');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (4, '8-5566-56-54556');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (4, '3-97452638-58');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (5, '9-9-552521');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (6, '564684-645634');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (6, '231231-89354');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (6, '645-6374');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (8, '214674-89774');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (9, '1564-654');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (9, '455241651');
INSERT INTO `Telefono` (`idCliente`, `numero`) VALUES (9, '54654564');


