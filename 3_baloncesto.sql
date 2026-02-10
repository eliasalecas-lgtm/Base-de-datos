-- Obtener el nombre y apellidos de todos los jugadores franceses.
select nombre,apellidos from jugador where nacionalidad='Francesa';
-- Obtener los datos de los partidos que acabaron en empate.
select* from partido where puntosLocal=puntosVisitante;
-- Obtener los datos de los partidos donde los equipos local y visitante eran de la misma localidad.
select* from partido where  idPartido in (select idPartido from (
    select idPartido,eLocal.localidad as local,eVisitante.localidad as visitante
        from partido p,equipo eLocal,equipo eVisitante
            where p.idEquipoLocal=eLocal.idEquipo and p.idEquipoVisitante=eVisitante.idEquipo) t1
                where t1.local=t1.visitante);
select* from partido where
    (select localidad from equipo where idEquipo=idEquipoLocal)
        =(select localidad from equipo where idEquipo=idEquipoVisitante);
select p.* from partido p join equipo eLocal on p.idEquipoLocal=eLocal.idEquipo
    join equipo eVisitante on p.idEquipoVisitante = eVisitante.idEquipo
        where eLocal.localidad=eVisitante.localidad;
-- Obtener los datos de los partidos donde el equipo local era español.
select* from partido where (select pais from equipo where idEquipo=idEquipoLocal)='Espana';
-- Obtener los datos de los jugadores ordenados por edad.
select* from jugador order by edad;
-- Obtener el número de jugadores que hay de cada nacionalidad.
select nacionalidad,count(*) from jugador group by nacionalidad;
/* Obtener los datos de todos los jugadores ordenados por equipo y además por orden
alfabético (primero apellidos y después el nombre).*/
select* from jugador order by idEquipo,apellidos,nombre;
-- Obtener el número de jugadores de cada equipo.
select equipo.nombre,count(*) from jugador,equipo where jugador.idEquipo=equipo.idEquipo group by equipo.nombre ;
-- Obtener la valoración media de un determinado jugador (el idJugador puede tomar cualquier valor).
select idJ,avg(valoracion) from datosjugadorpartido where idJ=2;
-- Obtener los datos del jugador cuya valoración media es la más alta.
select* from jugador where idJugador in (
    select idJ from (select idJ,avg(valoracion) from datosjugadorpartido group by idJ having
        avg(valoracion)=(select max(t) from (
            select idJ,avg(valoracion) t from datosjugadorpartido group by idJ) as t1))as t2);
SELECT j.* FROM jugador j
         JOIN ( SELECT idJ, AVG(valoracion) AS media FROM datosjugadorpartido GROUP BY idJ) m
              ON j.idJugador = m.idJ
WHERE m.media = ( SELECT MAX(media) FROM (
             SELECT AVG(valoracion) AS media FROM datosjugadorpartido GROUP BY idJ) x);
-- Obtener los datos del jugador que más puntos ha anotado de media.
select j.* from jugador j join (
    select idJ, avg(puntos) as media from datosjugadorpartido group by idJ) m
        on j.idJugador=m.idJ where m.media=(
            select max(media) from (
                select avg(puntos) as media from datosjugadorpartido group by idJ) n);
-- Obtener los datos del jugador que ha sido titular más veces.
select j.* from jugador j join (
    select idJ,count(*) as titular1 from datosjugadorpartido where titular=1  group by idJ) m
        on j.idJugador=m.idJ where m.titular1=(
            select max(titular1) from (select count(*) as titular1 from datosjugadorpartido where titular=1 group by idJ)t3);
-- Obtener los datos del jugador que ha sido menos veces titular.
select j.* from jugador j join (
    select idJ,count(*) as titular1 from datosjugadorpartido where titular=0  group by idJ) m
        on j.idJugador=m.idJ where m.titular1=(
            select max(titular1) from (select count(*) as titular1 from datosjugadorpartido where titular=0 group by idJ)t3);
/* Obtener los datos del jugador cuya valoración media es la más alta y que haya sido titular en,
al menos, 4 partidos.*/
select j.* from jugador j join (
    select idj,avg(valoracion) as valomax from datosjugadorpartido group by idj) m
        on j.idJugador=m.idJ join (
            select idj,count(*) as titular1 from datosjugadorpartido where titular=1 group by idj) n
                on m.idJ=n.idJ where m.valomax=(
                    select max(valomax) from (select idj,avg(valoracion) as valomax from datosjugadorpartido group by idj)p)
                         and n.titular1>=4;
-- Obtener los nombres de los equipos.
select nombre from equipo;
-- Obtener el nombre, apellidos y altura de aquellos jugadores que son menores de 25 años.
select nombre,apellidos,alturaCM from jugador where edad<25;
-- Obtener la localidad de un equipo a partir de su id.
select localidad from equipo where idEquipo=1;
-- Obtener el nombre y apellidos de los jugadores de Perú.
select nombre,apellidos from jugador where nacionalidad='peruana';
-- Obtener la puntuación de un determinado partido.
select idP,sum(puntos) from datosjugadorpartido group by idP;
-- Obtener los datos de los equipos cuya localidad empieza por la letra M.
select* from equipo where localidad like 'M%';
-- Obtener los datos de los jugadores que miden entre 1,90 y 2 metros (ambos incluidos).
select* from jugador where alturaCM between 190 and 200;
/* Obtener los equipos que no pertenecen a una determinada lista de localidades (la lista la
debes construir tú en la propia consulta). */
select* from equipo where localidad not in ('Madrid', 'Valencia', 'Sevilla');
-- Obtener los datos de los jugadores que tienen entre 20 y 30 años.
select* from jugador where edad between 20 and 30;
-- Obtener los datos de los jugadores obtenidos en orden alfabético por apellidos y nombre.
select* from jugador order by apellidos,nombre;
/* Obtener los datos de los jugadores obtenidos en orden alfabético por apellidos y nombre y en
orden descendente de edad (los más mayores primero). */
select* from jugador order by apellidos,nombre,edad desc ;
-- Obtener los 10 partidos con la mayor diferencia de puntos.
select p.* from partido p join
    (select idPartido,abs(puntosLocal-puntosVisitante) as diferencia from partido order by diferencia desc limit 10) t1
        on p.idPartido=t1.idPartido;
/* Obtener los datos de los equipos cuya localidad contiene una letra “a” y una letra “o” en ese
orden y en cualquier posición.*/
select* from equipo where localidad like '%a%o%' ;
-- Mostrar la cantidad de jugadores que tiene cada equipo junto con el id del equipo.
select e.idEquipo,e.nombre,count(*) from equipo e join jugador j on e.idEquipo = j.idEquipo
    group by e.idEquipo;
-- Obtener la altura media de los jugadores de cada equipo.
select e.nombre,m.media from equipo e join (select idEquipo,avg(alturaCM) as media from jugador group by idEquipo) m on
    e.idEquipo=m.idEquipo;
/*Obtener el número de jugadores mayores de 25 años que hay en cada equipo, pero solo
para aquellos equipos que tienen más de 3 jugadores mayores de 25 años.*/
select j.idEquipo, count(*) as mayores_25 from jugador j join  (
    select e.idEquipo,count(*) as may25 from equipo e join jugador j on e.idEquipo = j.idEquipo
        where edad>25 group by e.idEquipo having may25>3) m on j.idEquipo=m.idEquipo group by j.idEquipo;
-- Obtener los nombres de los equipos que tienen jugadores mayores de 30 años.
select e.nombre from equipo e join jugador j on e.idEquipo = j.idEquipo where j.edad>30 group by e.nombre;
-- Obtener los datos de los jugadores que miden más que la media de altura de toda la liga.
select* from jugador where alturaCM>(select avg(alturaCM) from jugador);











