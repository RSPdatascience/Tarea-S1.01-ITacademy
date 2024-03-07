# NIVEL 1
-- Ejercicio 2: Nombre, email y país de cada compañía, datos ordenados en función del nombre de las compañías
SELECT 
    company_name AS 'Companía',
    email AS 'E-mail',
    country AS 'País'
FROM
    company
ORDER BY company_name;

-- Ejercicio 3: Listado de los países que están realizando compras
-- Añado de mi parte recuento de transacciones por si hubiera paises registrados que no han hecho transacciones
-- También añado un having `Número de transacciones` > 0 por lo mismo. En este caso todos los paises registrados han hecho transacciones
SELECT DISTINCT
    country AS País,
    COUNT(transaction.id) AS `Número de transacciones`
FROM
    transaction
        JOIN
    company ON transaction.company_id = company.id
GROUP BY País
HAVING `Número de transacciones` > 0
ORDER BY `Número de transacciones` DESC;

# Ejercicio 4: Desde cuántos países se realizan las compras
SELECT 
    COUNT(DISTINCT country) AS 'Número de paises'
FROM
    transaction
        JOIN
    company ON transaction.company_id = company.id;

# Ejercicio 5: País y nombre de compañía 'b-2354'.
SELECT 
    id, company_name AS 'Compañía', country AS 'País'
FROM
    company
WHERE
    id = 'b-2354';

-- Ejercicio 6 Compañía con mayor gasto medio
SELECT 
    company_id, company_name, AVG(amount) AS `Gasto medio`
FROM
    transaction
        JOIN
    company ON transaction.company_id = company.id
GROUP BY company_id
ORDER BY `Gasto medio` DESC
LIMIT 1;


SELECT 
    COUNT(id) AS Repeticiones
FROM
    company
GROUP BY id
HAVING Repeticiones = 0;


# Nivel 2
-- Ejercicio 1: existen compañías con identificadores (id) duplicados?
SELECT 
    company_name AS Compañía, COUNT(id) AS `Registros duplicados`
FROM
    company
GROUP BY Compañía
HAVING `Registros duplicados` > 1
ORDER BY `Registros duplicados` DESC; 
    

-- Ejercicio 2: ¿Qué día se realizaron las cinco ventas más costosas? Muestra la fecha de la transacción y el sumatorio de la cantidad de dinero.
-- Según Lucía, en realidad hay que sacar los cinco días con mayor cantidad vendida. Añado Número de transacciones también, que es un dato interesante aunque no se pide

SELECT 
    DATE(timestamp) AS Fecha,
    SUM(amount) AS `Cantidad vendida`,
    COUNT(amount) AS `Número de transacciones`
FROM
    transaction
GROUP BY Fecha
ORDER BY `Cantidad vendida` DESC
LIMIT 5;

-- Ejercicio 3: ¿Qué día se realizaron las cinco ventas de menor valor? Muestra la fecha de la transacción y el sumatorio de la cantidad de dinero.
-- Según Lucía, hay que sacar los 5 días con menor cantidad vendida. Añado Número de transacciones también, que es un dato interesante aunque no se pide

SELECT 
    DATE(timestamp) AS Fecha,
    SUM(amount) AS `Cantidad vendida`,
    COUNT(amount) AS `Número de transacciones`
FROM
    transaction
GROUP BY Fecha
ORDER BY `Cantidad vendida`
LIMIT 5;


-- Ejercicio 4 ¿Cuál es la media de gasto por país? Presenta los resultados ordenados de mayor a menor promedio.
SELECT 
    country AS País, AVG(amount) AS Promedio
FROM
    company
        JOIN
    transaction ON transaction.company_id = company.id
GROUP BY country
ORDER BY Promedio DESC;

-- Nivel 3
-- Ejercicio 1: Nombre, teléfono y país de las compañías, cantidad total gastada, 
-- de aquellas que realizaron transacciones con un gasto comprendido entre 100 y 200 euros. 
-- Ordena los resultados de mayor a menor cantidad gastada.   

SELECT 
    company_name AS Empresa,
    phone AS Teléfono,
    country AS País,
    SUM(amount) AS Cantidad
FROM
    company
        JOIN
    transaction ON transaction.company_id = company.id
GROUP BY Empresa
HAVING Cantidad BETWEEN 100 AND 200
ORDER BY Cantidad DESC;


-- Ejercicio 2: Indica el nombre de las compañías que realizaron compras el 16 de marzo de 2022, 28 de febrero de 2022 y 13 de febrero de 2022.
-- Añado también cantidad total correspondiente al día por si interesa
SELECT 
    company_name AS Empresa,
    DATE(timestamp) AS Fecha,
    SUM(amount) AS Cantidad
FROM
    company
        JOIN
    transaction ON transaction.company_id = company.id
WHERE
    DATE(timestamp) IN ('2022-03-16' , '2022-02-28', '2022-02-13')
GROUP BY Empresa
ORDER BY Fecha desc;
