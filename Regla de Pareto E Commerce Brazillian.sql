-- Pareto de Categoria de Producto por Venta Total

WITH Tabla_Ventas AS (
    SELECT 
        ptra.column2 AS Categoria_de_producto,
        SUM(ordi.price) AS Total_precio,
        SUM(ordi.freight_value) AS Total_flete
    FROM 
        [E Commerce Data Brazilian].[dbo].[orders] ord
    LEFT JOIN
        [E Commerce Data Brazilian].[dbo].[order_items] ordi ON ord.order_id = ordi.order_id
    JOIN
        [E Commerce Data Brazilian].[dbo].[products] pro ON pro.product_id = ordi.product_id
    JOIN 
        [E Commerce Data Brazilian].[dbo].[product_category_name_translation] ptra ON ptra.column1 = pro.product_category_name
    GROUP BY ptra.column2
),
CalculoPorcentaje AS (
    SELECT 
        Categoria_de_producto,
        Total_precio + Total_flete AS monto
    FROM Tabla_Ventas
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY monto DESC) as Indice,
	Categoria_de_producto,
    monto,
	ROUND(monto / (SELECT SUM(monto) FROM CalculoPorcentaje), 2) AS porcentaje_venta,
	ROUND(SUM(monto) OVER (ORDER BY monto DESC), 2) AS suma_acumulada,
	ROUND(CAST(SUM(monto) OVER (ORDER BY monto DESC) / SUM(monto) OVER () AS DECIMAL(18, 6)), 2) AS porcentaje_acumulado
FROM CalculoPorcentaje
ORDER BY monto DESC;


---Pareto de Categoria de Producto, Mes y Año, por Venta Total


WITH Tabla_Ventas AS (
    SELECT 
        MONTH(CONVERT(date, ord.order_purchase_timestamp)) AS Mes,
		YEAR(CONVERT(date, ord.order_purchase_timestamp)) AS Año,
        ptra.column2 AS Categoria_de_producto,
        SUM(ordi.price) AS Total_precio,
        SUM(ordi.freight_value) AS Total_flete
    FROM 
        [E Commerce Data Brazilian].[dbo].[orders] ord
    LEFT JOIN
        [E Commerce Data Brazilian].[dbo].[order_items] ordi ON ord.order_id = ordi.order_id
    JOIN
        [E Commerce Data Brazilian].[dbo].[products] pro ON pro.product_id = ordi.product_id
    JOIN 
        [E Commerce Data Brazilian].[dbo].[product_category_name_translation] ptra ON ptra.column1 = pro.product_category_name
    GROUP BY YEAR(CONVERT(date, ord.order_purchase_timestamp)), MONTH(CONVERT(date, ord.order_purchase_timestamp)),ptra.column2
),
CalculoPorcentaje AS (
    SELECT 
        Año,
		Mes,
		Categoria_de_producto,
        Total_precio + Total_flete AS monto
    FROM Tabla_Ventas
)
 
SELECT 
    ROW_NUMBER() OVER (PARTITION BY año, mes ORDER BY monto DESC) as Indice,
	mes,
	año,
    Categoria_de_producto,
    monto,
    monto / (SELECT SUM(monto) FROM CalculoPorcentaje WHERE Mes = t.Mes and Año = t.Año) AS porcentaje_venta,
    SUM(monto) OVER (PARTITION BY año, mes ORDER BY monto DESC) AS suma_acumulada,
    CAST(SUM(monto) OVER (PARTITION BY año, mes ORDER BY monto DESC) / SUM(monto) OVER (PARTITION BY año, mes) AS DECIMAL(18, 6)) AS porcentaje_acumulado
FROM CalculoPorcentaje AS t
ORDER BY año, mes, monto DESC