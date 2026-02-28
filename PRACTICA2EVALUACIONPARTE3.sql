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
select* from centrodeportivo where idCentro in
                                   (select idCentro from (select idCentro, count(*) as num from reserva where datediff(curdate(),fecha) between 0 and 365 group by idCentro) t1
                                                where num >= all (select count(*) from reserva where datediff(curdate(),fecha) between 0 and 365 group by idCentro));
-- Obtener el número de tareas que hay de cada tipo.
select tipoTarea, count(*) as num_tareas from tarea group by tipoTarea;
/* Obtener el número de reservas que hay en el centro deportivo con identificador 12 para la próxima
semana. Se debe tomar como referencia del día actual el 22 de febrero de 2026. */
select* from reserva where idCentro=12 and datediff(fecha,'2026-02-22') between 0 and 7;
-- Obtener el número de reservas de más de 3 horas.
select count(*) as numReservas from reserva where nHoras>3 ;
-- Obtener el número de reservas de más de 3 horas en cada pista.
select idCentro, idPista, count(*) as numReservas from reserva where nHoras > 3 group by idCentro, idPista;
-- Obtener el número de reservas de más de 3 horas en cada centro deportivo.
select idCentro, count(*) as numReservas from reserva where nHoras > 3 group by idCentro;
-- Obtener la información de las pistas que se renovaron en el último año.
select* from pista where datediff(curdate(),fechaUltRenovacion) between 0 and 365;
/*Obtener la información de todos los usuarios que participaron en una determinada reserva (los datos
de la reserva los puedes elegir como quieras) y el rol que tuvieron dichos usuarios en la reserva.*/
select u.*, ur.tipoParticipacion from usuario u join usuarioReserva ur on u.dni = ur.idUsuario where ur.idCentro=8
  and ur.idPista=2 and ur.fecha='2026-02-10' and ur.hora='18:00:00';
/*Obtener los datos de los empleados que llevan trabajando más de un año en la empresa y cuyo DNI
contiene la cadena “17”.*/
select* from empleado where datediff(curdate(),fechaAlta)>365 and fechaBaja is null and dni like '%17%';
-- Obtener el tipo de espacio y el estado actual de la pista o pistas que más reservas tienen.
select p.idCentro,p.idPista,p.tipoEspacio,p.estadoActual,t1.num_reservas from pista p join (select idCentro,idPista,count(*) as num_reservas from reserva group by idCentro,idPista having num_reservas >= all (select count(*) from reserva group by idCentro,idPista)) t1
    on p.idPista=t1.idPista and p.idCentro=t1.idCentro;
-- Obtener los datos de las pistas que tienen más reservas con servicio de limpieza contratado.
select p.* from pista p join (select idCentro,idPista,count(*) as num_reservas from reserva where servicioLimpieza=1 group by idCentro,idPista having num_reservas >= all (select count(*) from reserva where servicioLimpieza=1 group by idCentro,idPista)) t1
    on p.idPista=t1.idPista and p.idCentro=t1.idCentro;
/* Obtener los datos de todas las tareas y los empleados que las han realizado, solo para aquellas que
se han realizado ya.*/
select t.*,e.* from tarea t join tareaempleado te on t.idCentro=te.idCentro and t.idPista=te.idPista and t.idTarea=te.idTarea join empleado e on te.idEmpleado=e.dni where fechaRealizacion is not null;
-- Obtener un listado de las tareas pendientes de realizar.
select* from tarea where fechaRealizacion is null;
/* Obtener todos los datos de los usuarios (personales y de usuario) cuyo nombre contenga una “a” en
cualquier lugar.*/
select* from persona where nombre like '%a%';
/*Obtener los datos de los usuarios que han participado como titulares de reserva en, al menos, 3
reservas.*/
select* from usuario where dni in (select idUsuario from usuarioreserva where tipoParticipacion='titularReserva' group by idUsuario having count(*)>=3) ;
-- Obtener los datos de los usuarios que no han participado en ninguna reserva.
select* from usuario where dni not in (select idusuario from usuarioreserva);
-- Obtener los datos de las pistas que más tareas de mantenimiento tienen asignadas.
select p.* from pista p join (select idCentro,idPista from tarea where tipoTarea='mantenimiento' group by idCentro, idPista having count(*)>= all(select count(*) from tarea where tipoTarea='mantenimiento' group by idCentro, idPista)) t1
on p.idCentro=t1.idCentro and p.idPista=t1.idPista;
/* Obtener los datos de los centros deportivos junto con el número de tareas de cada tipo que tienen
asignadas.*/
select ce.*,t.tipoTarea, count(*) from tarea t join centrodeportivo ce on t.idCentro=ce.idCentro group by t.idCentro,t.tipoTarea;
/*Obtener la duración media de las tareas de limpieza. Solo se deben tener en cuenta las tareas de
limpieza que ya han sido realizadas.*/

/*Obtener los datos personales de los usuarios que en algún momento han sido trabajadores de los
centros deportivos.*/
select* from usuario where dni in (select dni from empleado);
/*Obtener la capacidad de usuarios media, máxima y mínima de todas las pistas deportivas que
pertenezcan a centro deportivos de la localidad de Boecillo.*/
select avg(capUsuarios),max(capUsuarios),min(capUsuarios) from centrodeportivo c join pista p on c.idCentro = p.idCentro where localidad='Boecillo';
-- Obtener la información de la pista, la reserva y los usuarios de dicha reserva.
select* from reserva r join pista p on r.idCentro=p.idCentro and r.idPista=p.idPista join usuarioreserva ur on r.idCentro=ur.idCentro and r.idPista=ur.idPista and r.fecha=ur.fecha and r.hora=ur.hora;
/*Obtener la información de los empleados de mantenimiento junto con el número de tareas que se les
han asignado y junto con el número de tareas que tienen pendiente realizar.*/
select e.*,t1.num_tareas,t2.num_tareas_pendientes from (select dni, count(*) as num_tareas from empleado e join tareaempleado te on e.dni=te.idEmpleado  where tipoEmpleado='mantenimiento' group by dni) t1 join (
    select dni, count(*) as num_tareas_pendientes from empleado e join tareaempleado te on e.dni=te.idEmpleado join tarea t on te.idTarea=t.idTarea and te.idCentro=t.idCentro and te.idPista=t.idPista  where tipoEmpleado='mantenimiento' and t.fechaRealizacion is null group by dni ) t2 on
        t1.dni=t2.dni join empleado e on t2.dni=e.dni;
/* Para una determinada pista (el identificador lo elijes tú), obtener el número total de reservas que tiene
asociadas y la suma total del precio de dichas reservas.*/
select idcentro,idpista, count(*) as num_reservas, sum(precioFinal) as suma_precios from reserva where idCentro=4 and idPista=1 group by idcentro, idpista;
/* Obtener los datos de los 10 mejores clientes, entendiendo por cliente aquel que ha realizado el mayor
gasto en reservas. Se considera que solo paga la reserva el titular de la misma.*/
-- con limit
select u.*,total_gastado from usuario u join (
    select idUsuario, sum(precioFinal) as total_gastado from usuarioreserva ur join reserva r on ur.idCentro=r.idCentro and ur.idPista=r.idPista and ur.fecha=r.fecha and ur.hora=r.hora where tipoParticipacion='titularReserva' group by idUsuario
    order by total_gastado desc limit 10) t1 on u.dni=t1.idUsuario;
-- sin limit
select u.*,total_gastado from usuario u join (  select* from
(select idUsuario, sum(precioFinal) as total_gastado from usuarioreserva ur join reserva r on ur.idCentro=r.idCentro and ur.idPista=r.idPista and ur.fecha=r.fecha and ur.hora=r.hora where tipoParticipacion='titularReserva' group by idUsuario) t1 where 10>(
    select count(*) from (select idUsuario, sum(precioFinal) as total_gastado from usuarioreserva ur join reserva r on ur.idCentro=r.idCentro and ur.idPista=r.idPista and ur.fecha=r.fecha and ur.hora=r.hora where tipoParticipacion='titularReserva' group by idUsuario) t2
        where t2.total_gastado>t1.total_gastado
    )) t3 on u.dni=t3.idUsuario;
/*Para las tareas que tardaron más de dos días en realizarse, obtener los datos de los empleados que
participaron en dichas tareas junto con la clave primaria de la tarea.*/
select e.*, t.idTarea,t.idCentro,t.idPista from tarea t join tareaempleado te on t.idTarea=te.idTarea and t.idCentro=te.idCentro and t.idPista=te.idPista join empleado e on e.dni=te.idEmpleado where datediff(fechaRealizacion,fechaSolicitud)>2;
/* Obtener los datos de los usuarios y las reservas que realizaron (titular de la reserva). Utiliza
operaciones de tipo JOIN. Obtén la información sin columnas repetidas.*/
select u.*,r.* from usuario u join usuarioreserva ur on u.dni=ur.idUsuario join reserva r on ur.idCentro=r.idCentro and ur.idPista=r.idPista and ur.fecha=r.fecha and ur.hora=r.hora where
    tipoParticipacion='titularReserva';
/* Para un determinado empleado de mantenimiento, obtener los datos de todas las tareas que tiene
pendientes, pero solo para aquellas que llevan sin realizarse 5 días o más desde la fecha de solicitud. */
select t.* from empleado e join tareaempleado te on e.dni = te.idEmpleado join tarea t on te.idTarea = t.idTarea and te.idPista = t.idPista and te.idCentro = t.idCentro
    where tipoEmpleado='limpieza' and dni='36000003C' and fechaRealizacion is null and datediff(curdate(),fechaSolicitud)>=5;
-- Obtener la información de la pista o pistas cuyo precio es el más alto.
select* from pista where precioHora >= all ( select precioHora from pista);
-- Para la localidad de Valladolid, obtener el número de pistas clasificadas por su estado actual.
select estadoactual, count(*) from pista p join centrodeportivo ce on p.idCentro = ce.idCentro where localidad='Valladolid' group by estadoActual;
-- Obtener los 3 tipos de pistas que más reservas reciben. Se puede utilizar LIMIT en esta consulta.
select tipoEspacio from pista p join reserva r on p.idPista = r.idPista and p.idCentro = r.idCentro group by tipoEspacio order by count(*) desc limit 3;
/* Obtener los datos completos de los clientes (incluyendo nombre, apellidos y teléfono) que
se registraron en el año 2017.*/
select p.*, tipoUsuario, fechaRegistro, fechaBaja from usuario u join persona p on u.dni = p.dni where year(fechaRegistro)='2017';
-- Obtener el número de pistas que hay de cada tipo.
select tipoEspacio, count(*) from pista group by tipoEspacio;
/*Obtener los datos de las reservas que se hicieron en un determinado centro deportivo cuyo precio final
fue superior a 100€ y además su precio fue diferente del precio final.*/
select* from reserva where idCentro=4 and precioFinal>100 and precio!=precioFinal;
/*Obtener los datos de las reservas cuyo precio final está por debajo de la media del precio de todas las
reservas.*/
select* from reserva where precioFinal < (select avg(precioFinal) from reserva);
/* Obtener los datos de los empleados de limpieza o mantenimiento a los que no se les ha asignado
ninguna tarea. */
select* from empleado where tipoEmpleado in ('limpieza','mantenimiento') and dni not in (select idempleado from tareaempleado);
/*Obtener los datos completos de los empleados que tienen asignadas más de 10 tareas sin realizar
ordenados por el número de tareas que tienen pendientes.*/
select e.* from tarea t join tareaempleado te on t.idTarea = te.idTarea and t.idPista = te.idPista and t.idCentro = te.idCentro
    join empleado e on te.idEmpleado = e.dni  where fechaRealizacion is null group by idEmpleado having count(*)>10 order by count(*);
-- Obtener las localidades en las que no hay centros que dispongan de piscina cubierta.
select localidad from centrodeportivo where localidad not in (select localidad from centrodeportivo ce join pista p on ce.idCentro = p.idCentro where tipoEspacio = 'piscina cubierta' group by localidad) group by localidad;
/*Para un determinado usuario, obtener el número de reservas en las que ha participado como titular y
en las que ha participado como acompañante, junto con todos sus datos personales.*/
select u.*,(select count(*) from usuarioreserva where idUsuario=u.dni and  tipoParticipacion='titularReserva') as num_titular,
       (select count(*) from usuarioreserva where idUsuario=u.dni and  tipoParticipacion='acompañante') as num_acompañante from
            usuario u where dni='36000085N';
/* Obtener todos los datos de los 5 usuarios que han participado en más reservas como titulares. Se
puede utilizar LIMIT en esta consulta.*/
select u.* from usuarioreserva ur join usuario u on ur.idUsuario = u.dni where tipoParticipacion='titularReserva' group by idUsuario
    order by count(*) desc limit 5;
/* Obtener los datos de las pistas de un determinado centro que tienen reservas para una determinada
fecha, incluyendo además el número de reservas que tienen dichas pistas.*/
select p.*,(select count(*) from reserva r where r.idCentro=p.idCentro and r.idPista=p.idPista) as num_reservas
    from pista p where idPista in (select idPista from reserva where idCentro=p.idCentro and fecha='2026-02-12') and idCentro=2;
-- Obtener la fecha en la que se realizaron más reservas en la localidad de “La Cistérniga”.
select fecha as fecha_mas_reservas from reserva r join centrodeportivo cd on r.idCentro=cd.idCentro where localidad='La Cisterniga”' group by fecha
    having count(*) >= all (select count(*) from reserva r join centrodeportivo cd on r.idCentro=cd.idCentro where localidad='La Cisterniga”' group by fecha);
/* Para un determinado centro deportivo, obtener el número de reservas que tiene para cada hora del día
y por tipo de pista. */
select hour(hora),tipoEspacio, count(*) as num_reservas from centrodeportivo cd join pista p
    on cd.idCentro = p.idCentro join reserva r on p.idPista = r.idPista and p.idCentro = r.idCentro
        where r.idCentro=2 group by hour(hora),tipoEspacio order by hour(hora);


