-- Obtener el nombre y apellidos de todos los clientes ordenados por apellido.
select nombre,apellidos from cliente order by apellidos;
-- Obtener los datos de las oficinas ordenadas por provincia.
select* from oficina order by provincia;
-- Obtener el número de oficinas de la provincia de Palencia.
select count(*) from oficina where provincia='Palencia';
-- Obtener el número de oficinas de cada provincia (una sola consulta).
select provincia,count(*) from oficina group by provincia;
-- Obtener el promedio de días de los alquileres.
select avg(nDias) from alquiler;
-- Obtener el promedio de días de los alquileres cuya oficina de inicio fue Valladolid.
select avg(nDias) from alquiler where oficinaInicio='Valladolid';
-- Obtener el número de vehículos cuyo tipo de combustible es diesel.
select count(*) from vehiculo where tipoCombustible='diesel';
-- Obtener el número de vehículos con más de 4 plazas.
select count(*) from vehiculo where plazas>4;
-- Obtener los diferentes modelos que existen para la marca con id = 1.
select modelo from vehiculo where idMarca=1;
-- Obtener los datos del alquiler en el que se hicieron más kilómetros.
select* from alquiler where (kmFinal-kmInicio)= (select max(kmFinal-kmInicio) from alquiler);
-- Obtener los datos del cliente que llevó a cabo el alquiler en el que se hicieron más kilómetros.
select* from cliente where dni in (
select dniCliente from alquiler where (kmFinal-kmInicio)= (
select max(kmFinal-kmInicio) from alquiler));
/* Obtener el número de alquileres agrupados por días, es decir,
   el número de alquileres con 1 día, el número de alquileres con 2 días, etc. */
select nDias,count(*) from alquiler group by nDias order by nDias;
-- Obtener el número de marcas de cada país.
select pais,count(*) from marca group by pais;
-- Obtener el número de oficinas por localidad en la provincia de Palencia.
select localidad,count(*) from oficina where provincia='Palencia' group by localidad ;
-- Obtener los datos del vehículo más alquilado.
select* from vehiculo where idVehiculo in (select max(idVehiculo) from alquiler);

select count(*) from alquiler;

show tables;
describe vehiculo;
describe alquiler;
select* from oficina;
