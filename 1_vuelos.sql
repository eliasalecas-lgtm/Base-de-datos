-- Obtener todos los datos de los aeropuertos de la base de datos.
select* from aeropuerto;
-- Obtener la matrícula, el origen y el destino de todos los vuelos.
select avion,origen,destino from vuelo;
-- Obtener los datos de todos los tripulantes que estén contratados por horas.
select* from tripulante where tipoContrato='por horas';
-- Obtener el número de tripulantes con contrato indefinido.
select count(*) from tripulante where tipoContrato='indefinido';
-- Obtener el número de tripulantes con contrato temporal.
select count(*) from tripulante where tipoContrato='temporal';
-- Obtener el número de tripulantes contratados por horas.
select count(*) from tripulante where tipoContrato='por horas';
-- Obtener el precio medio de todos los billetes registrados en la base de datos.
select avg(precioFinal) from billete;
-- Obtener los datos del vuelo más concurrido (con más pasajeros).
select* from vuelo where pasajeros = ( select max(pasajeros) from vuelo);
-- Obtener la capacidad máxima de viajeros de los aviones.
select max(capacidadViajeros) from avion;
-- Obtener la capacidad mínima de viajeros de los aviones.
select min(capacidadViajeros) from avion;
-- Obtener la capacidad máxima de bodega de los aviones.
select max(capacidadBodega) from avion;
-- Obtener la capacidad mínima de bodega de los aviones.
select min(capacidadBodega) from avion;
-- Obtener los datos de los aeropuertos ordenados por países.
select* from aeropuerto order by pais;
-- Obtener los datos de los billetes ordenados por aeropuerto de origen y de destino.
select* from billete order by origen,destino;
-- Obtener los datos de los viajeros que son socios.
select* from pasajero where socio=true;
-- Obtener los datos de los tripulantes cuya categoría profesional es piloto o copiloto.
select* from tripulante where categoriaProfesional='piloto'or categoriaProfesional='copiloto';
-- Obtener los datos de los vuelos entre el aeropuerto desde Madrid Barajas (MADR) a Valladolid (VALL).
select* from vuelo where origen='MADR' and destino='VALL';
-- Obtener los datos de los vuelos entre el aeropuerto entre Madrid Barajas (MADR) y Valladolid (VALL) (ambos sentidos).
select* from vuelo where (origen='MADR' and destino='VALL') or (origen='VALL' and destino='MADR');
-- Obtener todos los datos de los vuelos que salieron a la hora y fecha prevista.
select* from vuelo where fechaPrevistaSalida=fechaRealSalida and horaPrevistaSalida=horaRealSalida;
-- Obtener todos los datos de los vuelos que no salieron a la hora prevista.
select* from vuelo where not horaPrevistaSalida=horaRealSalida; -- select* from vuelo where horaPrevistaSalida!=horaRealSalida;
-- Obtener todos los datos de los vuelos que no salieron en la fecha prevista.
select* from vuelo where not fechaPrevistaSalida=fechaRealSalida; -- select* from vuelo where fechaPrevistaSalida!=fechaRealSalida;
-- Obtener los datos de los vuelos que transportaron a más de 200 pasajeros.
select* from vuelo where pasajeros>200;
-- Obtener los datos de los viajeros con más de 500 puntos acumulados.
select* from pasajero where puntosViajero>500;
-- Obtener los datos de los billetes con mayor descuento.
select* from billete where descuento = (select max(descuento) from billete);
-- Obtener los datos de los billetes cuya diferencia entre el precio inicial y el final sea superior a 100 €.
select* from billete where precioOriginal-precioFinal>100;
-- Obtener los datos de los aviones cuya capacidad de bodega sea superior (en número) a la capacidad de viajeros.
select* from avion where capacidadBodega>capacidadViajeros;
