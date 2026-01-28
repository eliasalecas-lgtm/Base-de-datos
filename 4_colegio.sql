/* Obtener el nombre y apellidos de los alumnos que tienen entre 8 y 10 años. No se pueden
utilizar operadores aritméticos.*/
select nombre, apellidos from alumno where edad between 8 and 10;
-- Realiza la misma consulta que en el apartado anterior con operadores aritméticos.
select nombre, apellidos from alumno where edad>=8 and edad<=10;
-- Obtener los datos de los alumnos cuyo dni empiece por 17.
select* from alumno where dni like '17%';
/* Obtener los datos de los profesores cuya especialidad sea Lengua, Historia o Matemáticas.
No se puede utilizar el operador OR. */
select* from profesor where especialidad in ('Lengua', 'Historia', 'Matemáticas');
-- Realiza la misma consulta que en el apartado anterior utilizando el operador OR.
select*from profesor where especialidad='Lengua' or especialidad='Historia' or especialidad='Matemáticas';
-- Obtener los datos de los 10 profesores con más antigüedad cuya especialidad sea Lengua.
select*from profesor where especialidad='Lengua' order by antiguedad limit 10;
-- Obtener el número de profesores que hay de cada especialidad.
select especialidad, count(*) from profesor group by especialidad;
-- Obtener el número de grupos que hay en cada etapa educativa.
select etapa, count(*) from matricula group by etapa;
-- Obtener el profesor con más antigüedad de los que son tutores en primero de secundaria.


select* from profesor where dni in (
select tutor from clase where etapa='Secundaria' and numeroCurso='1')
order by antiguedad;

select min(antiguedad) from profesor;

select* from clase;

describe clase;
describe profesor;
show tables;