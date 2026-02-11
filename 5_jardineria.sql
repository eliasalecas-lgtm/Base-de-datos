-- Obtener el código de oficina y la ciudad donde haya oficinas.
select codigo_oficina, ciudad from oficina;
-- Obtener el número de empleados de la compañía.
select count(*) from empleado;
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
/*Obtener el número total de ventas de los productos que hayan facturado más de 3000 euros.
Se debe obtener el nombre, las unidades vendidas, el total facturado y el total facturado con
impuestos (IVA = 18%).*/
select p.nombre,m.total_ventas,m.total_facturado,m.total_facturado_iva from producto p join (select codigo_producto,sum(cantidad) as total_ventas,sum(cantidad*precio_unidad) as total_facturado,
    sum(cantidad*precio_unidad)*1.18 as total_facturado_iva
        from detalle_pedido group by codigo_producto) m on p.codigo_producto=m.codigo_producto where m.total_facturado>3000;
-- Obtener las direcciones de las oficinas que tengan clientes cuya ciudad sea Fuenlabrada.
select* from oficina where ciudad='Fuenlabrada';
/* Obtener los datos del cliente (total de pedidos, código de cliente y nombre de cliente) del que
hizo el pedido más caro.*/
select t1.*,t2.total_pedidos from (select c.codigo_cliente,c.nombre_cliente from cliente c join pedido p on c.codigo_cliente=p.codigo_cliente join (
    select codigo_pedido,sum(cantidad*precio_unidad) as total_precio from detalle_pedido group by codigo_pedido) m on p.codigo_pedido=m.codigo_pedido
        where m.total_precio>=all (select sum(cantidad*precio_unidad) from detalle_pedido group by codigo_pedido)) t1 join (
            select codigo_cliente, count(*) as total_pedidos from pedido group by codigo_cliente) t2 on t1.codigo_cliente=t2.codigo_cliente;

-- Obtener la ciudad y el teléfono de las oficinas de Estados Unidos (EEUU).



select codigo_cliente, count(*) from pedido group by codigo_cliente;

select t1.*,t2.total_pedidos from (select c.codigo_cliente,c.nombre_cliente from cliente c join pedido p on c.codigo_cliente=p.codigo_cliente join
       (select codigo_pedido,sum(cantidad*precio_unidad) as total_precio from detalle_pedido group by codigo_pedido) m on p.codigo_pedido=m.codigo_pedido
        where m.total_precio>=all (select sum(cantidad*precio_unidad) from detalle_pedido group by codigo_pedido)) t1 join (
            select codigo_cliente, count(*) as total_pedidos from pedido group by codigo_cliente) t2 on t1.codigo_cliente=t2.codigo_cliente;



select codigo_pedido,sum(cantidad*precio_unidad) from detalle_pedido group by codigo_pedido;


show tables;
describe cliente;
select* from oficina;
select* from gama_producto;
select* from cliente;
select codigo_cliente, count(*) from pedido group by codigo_cliente;
select * from detalle_pedido;




-- Obtener el primer y último pago para el cliente con código de cliente 1.
select* from pago where codigo_cliente=1 and fecha_pago in ((select min(fecha_pago) from pago where codigo_cliente=1),
                                                            (select max(fecha_pago) from pago where codigo_cliente=1));
--
