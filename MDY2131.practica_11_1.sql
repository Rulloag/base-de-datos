SELECT
    TO_CHAR (c.numrun ,'999G999G999')||'-'|| c.dvrun AS " Rut",
    c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.apmaterno AS "NOMBRE CLIENTE",
    po.nombre_prof_ofic AS PROFESION,
    tc.nombre_tipo_contrato,
    SUM(p.monto_total_ahorrado) AS MONTO,
    CASE WHEN SUM(p.monto_total_ahorrado) BETWEEN 100000 AND 1000000 THEN 'BRONCE'
WHEN SUM(p.monto_total_ahorrado) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
WHEN SUM(p.monto_total_ahorrado) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
WHEN SUM(p.monto_total_ahorrado) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
WHEN SUM(p.monto_total_ahorrado) > 15000000 THEN 'PLATINUM'
END "CATEGORIA CLIENTE"
FROM cliente c
    JOIN profesion_oficio po ON c.cod_prof_ofic = po.cod_prof_ofic
    JOIN tipo_contrato tc ON c.cod_tipo_contrato = tc.cod_tipo_contrato
    JOIN producto_inversion_cliente p ON c.nro_cliente = p.nro_cliente
GROUP BY c.numrun,c.dvrun,
    c.pnombre, c.snombre, c.appaterno, c.apmaterno,
    po.nombre_prof_ofic,
    tc.nombre_tipo_contrato
ORDER BY c.appaterno, MONTO DESC
;   