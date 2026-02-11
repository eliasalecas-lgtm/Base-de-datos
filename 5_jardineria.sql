-- Obtener el código de oficina y la ciudad donde haya oficinas.
select codigo_oficina, ciudad from oficina;
-- Obtener el número de clientes de cada país.
select pais,count(*) from cliente group by pais;
/* Obtener el pago medio del año 2005 (utilizar la función YEAR sobre el campo de tipo
date correspondiente).*/
select avg(total) from pago where YEAR(fecha_pago)=2009;
-- Obtener el número de pedidos que hay en cada estado ordenado por el número de pedidos.
select estado,count(*) from pedido group by estado order by count(*);
-- Obtener el precio del producto más barato y más caro.
select min(precio_venta), max(precio_venta) from producto;
-- Obtener el nombre del cliente con más límite de crédito.
select* from cliente where limite_credito >= all (select limite_credito from cliente);
/* Obtener el nombre, el primer apellido y el cargo de los empleados que no representan a
ningún cliente. */
select nombre,apellido1,puesto from empleado where codigo_empleado not in (
    select codigo_empleado_rep_ventas from cliente group by codigo_empleado_rep_ventas);
/*Obtener los datos de cada cliente y el nombre y apellido de sus respectivos representantes
de ventas.*/
select c.*,e.nombre as nombre_empleado,e.apellido1 as apellido_empleado from cliente c join empleado e
    on c.codigo_empleado_rep_ventas=e.codigo_empleado;
/*Obtener el nombre de los clientes que no hayan realizado pagos junto con los nombres y
apellidos de sus representantes de ventas.*/
select c.nombre_cliente,concat (e.nombre,' ',e.apellido1,' ',e.apellido2) as representantes_ventas from (select codigo_cliente, nombre_cliente,codigo_empleado_rep_ventas from cliente where codigo_cliente not in (select codigo_cliente from pago)) c
    join empleado e on c.codigo_empleado_rep_ventas=e.codigo_empleado;
-- Obtener el primer y último pago para el cliente con código de cliente 1.


show tables;
describe pedido;
describe oficina;
select* from oficina;