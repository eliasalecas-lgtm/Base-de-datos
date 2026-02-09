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





select* from datosjugadorpartido;
select* from equipo;

show tables;
describe datosjugadorpartido;
use baloncesto2;

-- Obtener los datos del jugador que más puntos ha anotado de media.
-- Obtener los datos del jugador que ha sido titular más veces.
-- Obtener los datos del jugador que ha sido menos veces titular.
/* Obtener los datos del jugador cuya valoración media es la más alta y que haya sido titular en,
al menos, 4 partidos.*/







