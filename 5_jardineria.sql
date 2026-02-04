-- Obtener el código de oficina y la ciudad donde haya oficinas.

-- Obtener el número de clientes de cada país.
select pais,count(*) from cliente group by pais;
/* Obtener el pago medio del año 2005 (utilizar la función YEAR sobre el campo de tipo
date correspondiente).*/
select avg(total) from pago where YEAR(fecha_pago)=2009;
-- Obtener el número de pedidos que hay en cada estado ordenado por el número de pedidos.
select count(*),estado from pedido group by estado;
-- Obtener el precio del producto más barato y más caro.
select min(precio_venta), max(precio_venta) from producto;
-- Obtener el nombre del cliente con más límite de crédito.

/*Obtener el nombre, el primer apellido y el cargo de los empleados que no representan a
ningún cliente.*/


-- Obtener el primer y último pago para el cliente con código de cliente 1.
select* from pago where (fecha_pago =(select min(fecha_pago) from pago where codigo_cliente=1)
    or fecha_pago =(select max(fecha_pago) from pago where codigo_cliente=1))
                    and  codigo_cliente=1;

show tables;
describe pedido;