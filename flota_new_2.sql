DROP SCHEMA IF EXISTS flota CASCADE;

-- flota de vehículos de empresa

CREATE SCHEMA flota;

CREATE TABLE flota.coches (
    matricula varchar(10) PRIMARY KEY,
    kms_totales int NOT NULL,
    fecha_compra date NOT NULL,
    id_modelo smallint NOT NULL,
    id_color smallint NOT NULL
);

CREATE TABLE flota.revisiones (
    id serial PRIMARY KEY,
    matricula_coche varchar(10) NOT NULL,
    kms_revision int NOT NULL,
    fecha_revision date NOT NULL,
    importe_revision float4 NOT NULL,
    id_moneda smallint NOT NULL
);

CREATE TABLE flota.moneda (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL
);

CREATE TABLE flota.poliza (
    id serial PRIMARY KEY,
    id_aseguradora smallint NOT NULL,
    matricula_poliza varchar(10) NOT NULL
);

CREATE TABLE flota.aseguradora (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL
);

CREATE TABLE flota.color (
    id serial PRIMARY KEY,
    nombre varchar(50)
);

CREATE TABLE flota.grupo (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL
);

CREATE TABLE flota.marca (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL,
    id_grupo smallint NOT NULL
);

CREATE TABLE flota.modelo (
    id serial PRIMARY KEY,
    nombre varchar(50) NOT NULL,
    id_marca smallint NOT NULL
);

-- creo las relaciones

ALTER TABLE flota.coches ADD CONSTRAINT pk_color FOREIGN KEY (id_color) REFERENCES flota.color(id);
ALTER TABLE flota.revisiones ADD CONSTRAINT pk_coches FOREIGN KEY (matricula_coche) REFERENCES flota.coches(matricula);
ALTER TABLE flota.revisiones ADD CONSTRAINT pk_moneda FOREIGN KEY (id_moneda) REFERENCES flota.moneda(id);
ALTER TABLE flota.poliza ADD CONSTRAINT pk_aseguradora FOREIGN KEY (id_aseguradora) REFERENCES flota.aseguradora(id);
ALTER TABLE flota.poliza ADD CONSTRAINT pk_matricula_poliza FOREIGN KEY (matricula_poliza) REFERENCES flota.coches(matricula);
ALTER TABLE flota.marca ADD CONSTRAINT pk_grupo FOREIGN KEY (id_grupo) REFERENCES flota.grupo(id);
ALTER TABLE flota.modelo ADD CONSTRAINT pk_marca FOREIGN KEY (id_marca) REFERENCES  flota.marca(id);
ALTER TABLE flota.coches ADD CONSTRAINT pk_modelo FOREIGN KEY (id_modelo) REFERENCES flota.modelo(id);

-- tabla temporal con datos para inyectar

CREATE TABLE flota.vehiculos (
    matricula varchar(50) NULL,
    grupo varchar(50) NULL,
    marca varchar(50) NULL,
    modelo varchar(50) NULL,
    fecha_compra date NULL,
    color varchar(50) NULL,
    aseguradora varchar(50) NULL,
    n_poliza int4 NULL,
    fecha_alta_seguro date NULL,
    importe_revision float4 NULL,
    moneda varchar(50) NULL,
    kms_revision int4 NULL,
    fecha_revision date NULL,
    kms_totales int4 NULL,
    matricula_poliza varchar(50) NULL
);


INSERT INTO flota.vehiculos (matricula,grupo,marca,modelo,fecha_compra,color,aseguradora,n_poliza,fecha_alta_seguro,importe_revision,moneda,kms_revision,fecha_revision,kms_totales) VALUES
	 ('7343FRT','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2009-06-01','Rojo','Allianz',25786,'2009-06-01',1076032.5,'Peso Colombiano',29564,'2020-07-07',47644),
	 ('2438GSV','PSA Peugeot S.A.','Citroën','DS4','2010-04-17','Gris Plateado','Allianz',195443,'2010-04-17',734.7,'Dólar',12028,'2010-05-13',52349),
	 ('2439GSV','PSA Peugeot S.A.','Citroën','DS4','2010-04-17','Gris Plateado','Axa',110761,'2011-08-23',460.0,'Euro',28312,'2016-05-17',52349),
	 ('9666FZC','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2008-03-03','Blanco','Allianz',79841,'2008-03-03',344330.4,'Peso Colombiano',19543,'2017-12-13',39533),
	 ('7221BJG','Hyundai Motor Group','Kia','Ceed','1999-09-30','Blanco','Allianz',112320,'1999-09-30',1162115.1,'Peso Colombiano',12066,'2000-05-18',70197),
	 ('7222BJG','Hyundai Motor Group','Kia','Ceed','1999-09-30','Blanco','Mapfre',135515,'2001-04-05',800.0,'Euro',41764,'2008-05-24',70197),
	 ('6756GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',3615469.2,'Peso Colombiano',21955,'2012-01-19',112881),
	 ('6757GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',697.5,'Dólar',50738,'2012-04-02',112881),
	 ('6758GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',11869.2,'Peso Mexicano',74499,'2012-06-28',112881),
	 ('6759GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Generali',159753,'2012-10-22',3579.6,'Peso Mexicano',94670,'2013-06-24',112881),
	 ('9314JHS','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2017-10-10','Negro','Allianz',67577,'2017-10-10',14695.2,'Peso Mexicano',24441,'2019-09-04',41064),
	 ('7987FXL','Hyundai Motor Group','Kia','Rio','2009-01-23','Blanco','Generali',32844,'2009-01-23',730.0,'Euro',11140,'2021-12-04',24726),
	 ('4325KMF','PSA Peugeot S.A.','Citroën','DS4','2020-04-13','Blanco','Mapfre',12534,'2020-04-13',7912.8,'Peso Mexicano',20410,'2022-07-08',49476),
	 ('3883DSH','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2007-02-27','Blanco','Mapfre',54632,'2007-02-27',570.0,'Euro',19245,'2014-05-16',35949),
	 ('3442GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',120.9,'Dólar',16209,'2014-02-10',77662),
	 ('3542GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',80.0,'Euro',27845,'2014-04-27',77662),
	 ('3642GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',1695.6,'Peso Mexicano',38072,'2014-06-07',77662),
	 ('3742GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Generali',187526,'2014-07-14',16767.6,'Peso Mexicano',49153,'2021-11-30',77662),
	 ('4315JKL','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2017-08-27','Gris Plateado','Mapfre',9482,'2017-08-27',15825.6,'Peso Mexicano',20263,'2017-11-02',46145),
	 ('2426HDG','Hyundai Motor Group','Kia','Ceed','2015-04-01','Negro','Axa',144573,'2015-04-01',437.1,'Dólar',16879,'2015-09-27',46759),
	 ('5326HDG','Hyundai Motor Group','Kia','Ceed','2015-04-01','Negro','Generali',186297,'2016-08-24',2883767.0,'Peso Colombiano',34964,'2019-08-24',46759),
	 ('6231KKQ','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2019-04-10','Rojo','Allianz',34218,'2019-04-10',632.4,'Dólar',13755,'2021-04-04',39563),
	 ('7457BFT','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2000-11-24','Negro','Mapfre',35103,'2000-11-24',90.0,'Euro',16226,'2018-09-24',39949),
	 ('5205DFJ','Hyundai Motor Group','Kia','Ceed','2006-03-04','Gris Plateado','Allianz',41930,'2006-03-04',14883.6,'Peso Mexicano',23043,'2022-05-24',50972),
	 ('3212HJW','Hyundai Motor Group','Kia','Rio','2014-08-04','Gris Plateado','Axa',117277,'2015-12-19',170.0,'Euro',14526,'2023-04-14',28986),
	 ('3313GGW','PSA Peugeot S.A.','Citroën','DS4','2013-04-01','Rojo','Mapfre',85225,'2013-04-01',1884.0,'Peso Mexicano',17187,'2017-12-13',35823),
	 ('6642GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Mapfre',151249,'2010-04-21',3228097.5,'Peso Colombiano',21563,'2011-01-06',97183),
	 ('6643GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Mapfre',151249,'2010-04-21',83.7,'Dólar',49405,'2011-05-04',97183),
	 ('6644GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Axa',169829,'2011-12-01',1507.2,'Peso Mexicano',69454,'2023-03-11',97183),
	 ('3306GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Generali',174969,'2011-12-19',1463404.2,'Peso Colombiano',18060,'2012-04-17',76024),
	 ('3307GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Generali',174969,'2011-12-19',16767.6,'Peso Mexicano',37513,'2013-01-10',76024),
	 ('3308GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Axa',173030,'2013-02-18',14883.6,'Peso Mexicano',58378,'2019-06-16',76024),
	 ('5303DCG','PSA Peugeot S.A.','Citroën','DS4','2007-08-30','Gris Plateado','Allianz',79203,'2007-08-30',11492.4,'Peso Mexicano',14181,'2022-05-31',35530),
	 ('0827DBB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2006-07-24','Gris Plateado','Generali',40647,'2006-07-24',325.5,'Dólar',24407,'2019-02-23',39061),
	 ('5017FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',172625,'2009-10-26',5086.8,'Peso Mexicano',18053,'2010-02-22',90641),
	 ('5057FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',172625,'2009-10-26',399.9,'Dólar',40390,'2010-05-03',90641),
	 ('5067FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',161701,'2010-10-16',2324230.2,'Peso Colombiano',63099,'2010-12-08',90641),
	 ('4366GZX','Hyundai Motor Group','Hyundai','Tucson','2013-11-03','Verde','Axa',40977,'2013-11-03',306.9,'Dólar',21132,'2017-08-27',44510),
	 ('2561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',170914,'2004-09-22',12622.8,'Peso Mexicano',13171,'2006-01-18',71901),
	 ('37561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',170914,'2004-09-22',2926808.5,'Peso Colombiano',29474,'2006-02-27',71901),
	 ('4561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',172754,'2006-03-23',74.4,'Dólar',42110,'2021-04-19',71901);


-- Inserciones

INSERT INTO flota.moneda (nombre) SELECT DISTINCT moneda FROM flota.vehiculos WHERE moneda IS NOT NULL;
INSERT INTO flota.color (nombre) SELECT DISTINCT color FROM flota.vehiculos WHERE color IS NOT NULL;
INSERT INTO flota.aseguradora (nombre) SELECT DISTINCT aseguradora FROM flota.vehiculos WHERE aseguradora IS NOT NULL;
INSERT INTO flota.grupo (nombre) SELECT DISTINCT grupo FROM flota.vehiculos WHERE grupo IS NOT NULL;
INSERT INTO flota.marca (nombre, id_grupo)
  SELECT DISTINCT v.marca, g.id
  FROM flota.vehiculos v
  INNER JOIN flota.grupo g ON g.nombre = v.grupo
  WHERE v.marca IS NOT NULL AND v.grupo IS NOT NULL;

INSERT INTO flota.modelo (nombre, id_marca)
  SELECT DISTINCT v.modelo, m.id
  FROM flota.vehiculos v
  INNER JOIN flota.marca m ON m.nombre = v.marca
  WHERE v.modelo IS NOT NULL AND v.marca IS NOT NULL
  ORDER BY m.id;

INSERT INTO flota.coches (matricula, id_modelo, id_color, kms_totales, fecha_compra)
  SELECT DISTINCT v.matricula, m.id, c.id, v.kms_totales, v.fecha_compra
  FROM flota.vehiculos v
  INNER JOIN flota.modelo m ON m.nombre = v.modelo
  INNER JOIN flota.color c ON c.nombre = v.color
  WHERE v.matricula IS NOT NULL AND v.modelo IS NOT NULL AND v.color IS NOT NULL;

INSERT INTO flota.revisiones (matricula_coche, kms_revision, fecha_revision, importe_revision, id_moneda)
  SELECT DISTINCT v.matricula, v.importe_revision, v.fecha_revision, v.importe_revision, m.id
  FROM flota.vehiculos v
  INNER JOIN flota.coches r ON r.matricula = v.matricula
  INNER JOIN flota.moneda m ON v.moneda = m.nombre
  WHERE v.matricula IS NOT NULL AND v.importe_revision IS NOT NULL AND v.moneda IS NOT NULL;

INSERT INTO flota.poliza (id_aseguradora, matricula_poliza)
  SELECT DISTINCT a.id, v.matricula
  FROM flota.vehiculos v
  INNER JOIN flota.coches p ON p.matricula = v.matricula
  INNER JOIN flota.aseguradora a ON a.nombre = v.aseguradora
  WHERE v.matricula IS NOT NULL AND v.aseguradora IS NOT NULL;

-- Consulta

SELECT
  DISTINCT c.matricula,
  c.fecha_compra,
  c.kms_totales,
  cc.nombre AS color,
  mc.nombre AS modelo,
  mc2.nombre AS marca,
  g.nombre AS grupo,
  ca.nombre AS aseguradora,
  matricula_poliza
FROM flota.coches c
INNER JOIN flota.modelo mc ON c.id_modelo = mc.id
INNER JOIN flota.marca mc2 ON mc2.id = mc.id_marca
INNER JOIN flota.grupo g ON g.id = mc2.id_grupo
INNER JOIN flota.color cc ON cc.id = c.id_color
INNER JOIN flota.poliza p ON p.matricula_poliza = c.matricula
INNER JOIN flota.aseguradora ca ON p.id_aseguradora = ca.id;

-- Elimino la tabla temporal

DROP TABLE IF EXISTS flota.vehiculos;
