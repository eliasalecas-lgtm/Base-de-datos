-- Obtener el nombre y apellidos de todos los jugadores franceses.
select nombre,apellidos from jugador where nacionalidad='Francesa';
-- Obtener los datos de los partidos que acabaron en empate.
select* from partido where puntosLocal=puntosVisitante;

select* from partido;

show tables;
describe partido;