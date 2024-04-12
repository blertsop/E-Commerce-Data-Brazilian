
-- Obtener información de mis tablas

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS

-- Conteo de registros

SELECT count(*) as Conteo
FROM customers

SELECT count(*) as Conteo
FROM geolocation

SELECT count(*) as Conteo
FROM order_items

SELECT count(*) as Conteo
FROM order_payments

SELECT count(*) as Conteo
FROM order_reviews

SELECT count(*) as Conteo
FROM orders

SELECT count(*) as Conteo
FROM products

SELECT count(*) as Conteo
FROM sellers

SELECT count(*) as Conteo
FROM geolocation

SELECT count(*) as Conteo
FROM product_category_name_translation

-- Conteo de registros unicos de las Primary Keys.


SELECT COUNT(DISTINCT order_id) AS Distintos_Order_ID
FROM orders;

SELECT COUNT(DISTINCT order_id) AS Distintos_Order_ID
FROM order_items;

SELECT COUNT(DISTINCT customer_id) AS Distintos_Customer_ID
FROM customers;

SELECT COUNT(DISTINCT product_id) AS Distintos_Product_ID
FROM products;

SELECT COUNT(DISTINCT seller_id) AS Distintos_Seller_ID
FROM sellers;

SELECT COUNT(DISTINCT column1) AS Distintos_Column1
FROM product_category_name_translation;

-- Conteo de registros unicos de las Foreign Keys


SELECT COUNT(DISTINCT customer_zip_code_prefix) AS Distintos_Customer_Zip_Code_Prefix
FROM customers;

SELECT COUNT(DISTINCT product_id) AS Distintos_Product_ID
FROM order_items;

SELECT COUNT(DISTINCT seller_id) AS Distintos_Seller_ID
FROM order_items;

SELECT COUNT(DISTINCT order_id) AS Distintos_Order_ID
FROM order_items;

SELECT COUNT(DISTINCT order_id) AS Distintos_Order_ID
FROM order_payments;

SELECT COUNT(DISTINCT order_id) AS Distintos_Order_ID
FROM order_reviews;

SELECT COUNT(DISTINCT customer_id) AS Distintos_Customer_ID
FROM orders;

SELECT COUNT(DISTINCT product_category_name) AS Distintos_Product_Category_Name
FROM products;

SELECT COUNT(DISTINCT seller_zip_code_prefix) AS Distintos_Seller_Zip_Code_Prefix
FROM sellers;

-- Calculo del minimo, maximo, promedio y desviacion estandar

SELECT 
    ROUND(MIN(payment_value), 2) AS Minimo,
    ROUND(MAX(payment_value), 2) AS Maximo,
    ROUND(AVG(payment_value), 2) AS Promedio,
    ROUND(STDEV(payment_value), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN payment_value IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM order_payments;

SELECT 
    ROUND(MIN(price), 2) AS Minimo,
    ROUND(MAX(price), 2) AS Maximo,
    ROUND(AVG(price), 2) AS Promedio,
    ROUND(STDEV(price), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN price IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM order_items;

SELECT 
    ROUND(MIN(freight_value), 2) AS Minimo,
    ROUND(MAX(freight_value), 2) AS Maximo,
    ROUND(AVG(freight_value), 2) AS Promedio,
    ROUND(STDEV(freight_value), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN freight_value IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM order_items;

SELECT 
    ROUND(MIN(CONVERT(float, review_score)), 2) AS Minimo,
    ROUND(MAX(CONVERT(float, review_score)), 2) AS Maximo,
    ROUND(AVG(CONVERT(float, review_score)), 2) AS Promedio,
    ROUND(STDEV(CONVERT(float, review_score)), 2) AS Desviacion_Estandar,
    COUNT(CASE
        WHEN review_score IS NULL THEN 1
        ELSE NULL
     END) AS Valores_nulls
FROM order_reviews;


SELECT 
    ROUND(MIN(product_weight_g), 2) AS Minimo,
    ROUND(MAX(product_weight_g), 2) AS Maximo,
    ROUND(AVG(product_weight_g), 2) AS Promedio,
    ROUND(STDEV(product_weight_g), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN product_weight_g IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM products;

SELECT 
    ROUND(MIN(product_length_cm), 2) AS Minimo,
    ROUND(MAX(product_length_cm), 2) AS Maximo,
    ROUND(AVG(product_length_cm), 2) AS Promedio,
    ROUND(STDEV(product_length_cm), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN product_length_cm IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM products;

SELECT 
    ROUND(MIN(product_height_cm), 2) AS Minimo,
    ROUND(MAX(product_height_cm), 2) AS Maximo,
    ROUND(AVG(product_height_cm), 2) AS Promedio,
    ROUND(STDEV(product_height_cm), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN product_height_cm IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM products;

SELECT 
    ROUND(MIN(product_width_cm), 2) AS Minimo,
    ROUND(MAX(product_width_cm), 2) AS Maximo,
    ROUND(AVG(product_width_cm), 2) AS Promedio,
    ROUND(STDEV(product_width_cm), 2) AS Desviacion_Estandar,
	SUM(CASE
        WHEN product_width_cm IS NULL THEN 1
        ELSE 0
     END  ) AS Valores_nulls
FROM products;
