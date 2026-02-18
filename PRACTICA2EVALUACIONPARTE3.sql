-- Obtener toda la información de los centros deportivos de la base de datos.
select* from centrodeportivo;
-- Obtener toda la información de los empleados que están actualmente en plantilla.
select* from empleado where fechaBaja is null;
/*Obtener los datos de los empleados que están contratados de forma temporal o haciendo una
sustitución. Utiliza la evaluación de pertenencia a conjuntos para esta consulta.*/
select* from empleado where tipoContrato='temporal' or tipoContrato='sustitucion';
/*Obtener la información de los usuarios VIP ordenados por el número de reservas que hayan realizado,
es decir, el número de reservas en las que aparezcan como “titularReserva” (los que más reservas
hayan realizado aparecerán primero).*/
select u.*, count(*) as total_reservas from usuario u join usuarioreserva ur on u.dni=ur.idUsuario
    where tipoUsuario='VIP' and tipoParticipacion='titularReserva' group by u.dni order by total_reservas desc;
/*Obtener el número de empleados que hay con cada tipo de contrato (también hay que mostrar el tipo
de contrato). */
select tipoContrato, count(*) as numero_empleado from empleado group by tipoContrato;
-- Obtener todos los datos, personales y de empleado de todos los empleados que aún siguen en la empresa.
select* from persona p join empleado e on p.dni=e.dni where fechaBaja is null;
-- Obtener los datos de los centros deportivos junto con el número de pistas deportivas que tienen.
select cd.*, count(*) as numero_pistas from centrodeportivo cd join pista p
    on cd.idCentro=p.idCentro group by cd.idCentro;
/* Obtener la capacidad media de espectadores de las pistas deportivas del centro deportivo con
identificador 11 */
select avg(capEspectadores)as capacidad_media from pista where idCentro = 11;
/*Obtener la capacidad media de espectadores de las pistas deportivas que pertenecen a algún centro
deportivo de la localidad de Zaratán.*/
select avg(p.capEspectadores) as capacidad_media from centrodeportivo cd join pista p on cd.idCentro=p.idCentro
    where cd.localidad='Zaratán' ;
/*Obtener los datos de los empleados cuyo salario está por encima del salario medio global de los
trabajadores.*/
select* from empleado where salario>(select avg(salario) from empleado);
-- Obtener el número de centros deportivos que hay en cada localidad.
select localidad,count(*) as numero_centros from centrodeportivo group by localidad;
-- Obtener la media de reservas que hay en cada centro deportivo.
select avg(reservas) as media_reservas from (select count(*) as reservas from reserva group by idCentro) t1;
-- Obtener cuál es el tipo de pista que se reserva más.
select tipoEspacio as pista_mas_reservada from reserva r join pista p on r.idPista=p.idPista and r.idCentro=p.idCentro group by tipoEspacio
    having count(*) >= all (select count(*) from reserva r join pista p on r.idPista=p.idPista and r.idCentro=p.idCentro group by tipoEspacio);
/*Obtener el número de reservas por cada tipo de pista deportiva, pero solo para aquellas que acumulen
más de 100 reservas.*/
select tipoEspacio, count(*) as numero_reservas from pista p join reserva r
    on r.idPista=p.idPista and r.idCentro=p.idCentro group by tipoEspacio having numero_reservas>100;
-- Obtener los datos de los centros deportivos que han tenido más reservas en el último año.
select* from centrodeportivo where idCentro in (select p.idCentro from reserva r join pista p on r.idCentro=p.idCentro and r.idPista=p.idPista
    where year(fecha)=(select max(year(fecha)) from reserva) group by p.idCentro having count(*) >= all (
        select count(*) from reserva r join pista p on r.idPista=p.idPista and r.idCentro=p.idCentro  group by p.idCentro));