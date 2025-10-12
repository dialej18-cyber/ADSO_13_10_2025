create database bd_selfcertify;
use bd_selfcertify;

create table t_usuarios(
usuario varchar (30) primary key not null,
contraseña varchar (15) not null);

insert into t_usuarios(usuario, contraseña)
values ("dialej18@gmail.com","dialej17");
insert into t_usuarios(usuario, contraseña)
values ("dialej17@hotmail.com","dialej18");

select * from t_usuarios;

create table t_ciudad(
cod_ciudad varchar (10) primary key not null,
nom_ciudad varchar (30) not null);

insert into t_ciudad(cod_ciudad, nom_ciudad)
values ("11001","Bogota");
insert into t_ciudad(cod_ciudad, nom_ciudad)
values ("05001","Medellin");
insert into t_ciudad(cod_ciudad, nom_ciudad)
values ("76001","Cali");
insert into t_ciudad(cod_ciudad, nom_ciudad)
values ("41001","Neiva");

select * from t_ciudad;

create table t_dpto(
cod_dpto varchar (10) primary key not null,
nom_dpto varchar (30) not null);

insert into t_dpto(cod_dpto, nom_dpto)
values ("11","Bogota.DC");
insert into t_dpto(cod_dpto, nom_dpto)
values ("05","Antioquia");
insert into t_dpto(cod_dpto, nom_dpto)
values ("76","Valle del Cauca");
insert into t_dpto(cod_dpto, nom_dpto)
values ("41","Huila");

select * from t_dpto;

create table t_regimen_t(
cod_regimen_t varchar (10) primary key not null,
regimen varchar (50) not null);

insert into t_regimen_t(cod_regimen_t, regimen)
values ("001","reg comun");
insert into t_regimen_t(cod_regimen_t, regimen)
values ("002","reg simple");
insert into t_regimen_t(cod_regimen_t, regimen)
values ("003","reg aut_comun");
insert into t_regimen_t(cod_regimen_t, regimen)
values ("004","reg gran_contribuyente");

select * from t_regimen_t;

create table t_tarifa_ica(
cod_ciudad varchar (10) not null,
foreign key (cod_ciudad) references t_ciudad (cod_ciudad),
tarifa_ica varchar (10) not null,
Servicio_ica varchar (100) not null);

insert into t_tarifa_ica(cod_ciudad, tarifa_ica, Servicio_ica)
values ("11001","11.04","Compras");
insert into t_tarifa_ica(cod_ciudad, tarifa_ica, Servicio_ica)
values ("05001","2","servicios");
insert into t_tarifa_ica(cod_ciudad, tarifa_ica, Servicio_ica)
values ("41001","5","Compras");

select * from t_tarifa_ica;

create table t_tarifa_fte(
id_rte_fuente varchar (10) primary key not null,
tarifa_fte varchar (10) not null,
Servicio_fte varchar (100) not null);

insert into t_tarifa_fte(id_rte_fuente, tarifa_fte, Servicio_fte)
values ("001","2.5", "Compras");
insert into t_tarifa_fte(id_rte_fuente, tarifa_fte, Servicio_fte)
values ("002","4", "Servicios");
insert into t_tarifa_fte(id_rte_fuente, tarifa_fte, Servicio_fte)
values ("003","3.5", "Arriendos");

select * from t_tarifa_fte;

create table t_proveedores(
cod_prov integer primary key not null auto_increment,
id_prov varchar (15) not null,
nom_prov varchar (100) not null,
tipo_doc varchar (4) not null,
cod_regimen_t varchar (10) not null,
tel_prov varchar (15) not null,
usuario varchar (30) not null,
pais_prov varchar (30) not null,
cod_ciudad varchar (10) not null,
dir_prov varchar (100) not null,
num_actecono_prov varchar (4) not null,
foreign key (cod_ciudad) references t_ciudad (cod_ciudad),
foreign key (cod_regimen_t) references t_regimen_t (cod_regimen_t),
foreign key (usuario) references t_usuarios (usuario));

insert into t_proveedores(id_prov, nom_prov, tipo_doc, cod_regimen_t, tel_prov, usuario, pais_prov, cod_ciudad, dir_prov, num_actecono_prov)
values ("1075264785","Alejandro Rojas", "CC", "001", "3118166320", "dialej18@gmail.com", "Colombia", "11001", "Calle 3 2 15", "1010");
insert into t_proveedores(id_prov, nom_prov, tipo_doc, cod_regimen_t, tel_prov, usuario, pais_prov, cod_ciudad, dir_prov, num_actecono_prov)
values ("900800003","La Castellana", "NIT", "003", "3118166321", "dialej17@hotmail.com", "Colombia", "41001", "Calle 3 2 16", "8001");

select * from t_proveedores;

create table t_compras(
cod_prov integer not null,
id_rte_fuente varchar (10) not null,
cod_ciudad varchar (10) not null,
tarifa_ica integer (10) not null,
cod_regimen_t varchar (10) not null,
base_imp integer not null,
año_imp year not null,
periodo_imp varchar (15) not null,
foreign key (cod_prov) references t_proveedores (cod_prov),
foreign key (id_rte_fuente) references t_tarifa_fte (id_rte_fuente),
foreign key (cod_ciudad) references t_ciudad (cod_ciudad),
foreign key (cod_regimen_t) references t_regimen_t (cod_regimen_t));

insert into t_compras(cod_prov, id_rte_fuente, cod_ciudad, tarifa_ica, cod_regimen_t, base_imp, año_imp, periodo_imp)
values ("2", "001", "11001", "0.01104", "001", "1000000", "2025", "bim II");
insert into t_compras(cod_prov, id_rte_fuente, cod_ciudad, tarifa_ica, cod_regimen_t, base_imp, año_imp, periodo_imp)
values ("3", "002", "05001", "0.002", "002", "5000000", "2025", "bim III");

DELETE FROM t_compras
WHERE cod_prov = 2 AND valor_ica = "11040000.00";
DELETE FROM t_compras
WHERE cod_prov = 3 AND valor_ica = "10000000.00";
DELETE FROM t_compras
WHERE cod_prov = 3 AND valor_ica = "50000";

ALTER TABLE t_compras
ADD valor_ica DECIMAL(15,2) GENERATED ALWAYS AS (
  base_imp * CAST(tarifa_ica AS DECIMAL(10,2))
) STORED;


select * from t_compras;

SELECT 
  c.cod_prov,
  p.nom_prov,
  p.tipo_doc,
  p.id_prov,
  p.tel_prov,
  p.pais_prov,
  p.dir_prov,
  p.num_actecono_prov,
  u.usuario,
  u.contraseña,
  ci.nom_ciudad,
  d.nom_dpto,
  r.regimen,
  tf.tarifa_fte,
  tf.Servicio_fte,
  ti.tarifa_ica,
  ti.Servicio_ica,
  c.base_imp,
  c.año_imp,
  c.periodo_imp,
  c.valor_ica
FROM t_compras c
JOIN t_proveedores p ON c.cod_prov = p.cod_prov
JOIN t_usuarios u ON p.usuario = u.usuario
JOIN t_ciudad ci ON c.cod_ciudad = ci.cod_ciudad
JOIN t_dpto d ON LEFT(ci.cod_ciudad, 2) = d.cod_dpto
JOIN t_regimen_t r ON c.cod_regimen_t = r.cod_regimen_t
JOIN t_tarifa_fte tf ON c.id_rte_fuente = tf.id_rte_fuente
LEFT JOIN t_tarifa_ica ti ON c.cod_ciudad = ti.cod_ciudad AND c.tarifa_ica = ti.tarifa_ica;
