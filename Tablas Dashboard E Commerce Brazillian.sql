

--- Tabla Ventas 


SELECT 
  CONVERT(
    date, ord.order_purchase_timestamp
  ) AS Fecha_Compra, 
  FORMAT(
    ord.order_purchase_timestamp, 'hh:mm tt'
  ) AS Hora_Compra, 
  ord.order_id AS Id_Orden, 
  pro.product_id AS Id_Producto, 
  ord.order_status AS Estatus_de_orden, 
  ordi.order_item_id AS Numero_items_orden, 
  ptra.column2 AS Categoria_de_producto, 
  ordi.price AS Precio, 
  ordi.freight_value AS Costo_Flete 
FROM 
  [E Commerce Data Brazilian].[dbo].[order_items] ordi 
  LEFT JOIN [E Commerce Data Brazilian].[dbo].[orders] ord ON ord.order_id = ordi.order_id 
  LEFT JOIN [E Commerce Data Brazilian].[dbo].[products] pro on pro.product_id = ordi.product_id 
  LEFT JOIN [E Commerce Data Brazilian].[dbo].[product_category_name_translation] ptra on ptra.column1 = pro.product_category_name 
ORDER BY 
  Fecha_Compra, 
  Hora_Compra;


  --- Tabla Dimension Producto


 SELECT 
  pro.product_id AS Id_Producto,
  ptra.column2 AS Categoria_de_producto,
  pro.product_weight_g AS Peso_producto, 
  pro.product_length_cm AS Longitud_producto, 
  pro.product_height_cm AS Altura_producto, 
  pro.product_width_cm AS Ancho_producto
 FROM 
  [E Commerce Data Brazilian].[dbo].[products] pro
  LEFT JOIN [E Commerce Data Brazilian].[dbo].[product_category_name_translation] ptra on ptra.column1 = pro.product_category_name 
WHERE pro.product_category_name IS NOT NULL OR ptra.column2 IS NOT NULL 
  
--- Tabla dimension Geolocalizacion


SELECT 
    DISTINCT ordi.order_id as Id_Orden,
    cust.customer_city as Ciudad,
	cust.customer_state as Estado,
	cust.customer_zip_code_prefix as Codigo_Postal,
    geo.geolocation_lat as Latitud,
    geo.geolocation_lng as Longitud
FROM 
    [E Commerce Data Brazilian].[dbo].[order_items] ordi 
LEFT JOIN 
    [E Commerce Data Brazilian].[dbo].[orders] ord ON ord.order_id = ordi.order_id
LEFT JOIN
    [E Commerce Data Brazilian].[dbo].[customers] cust ON cust.customer_id = ord.customer_id
LEFT JOIN
    (
    SELECT 
        geolocation_zip_code_prefix,
        MIN(geolocation_lat) AS geolocation_lat,
        MIN(geolocation_lng) AS geolocation_lng
    FROM 
        [E Commerce Data Brazilian].[dbo].[geolocation]
    GROUP BY 
        geolocation_zip_code_prefix
    ) geo ON geo.geolocation_zip_code_prefix = cust.customer_zip_code_prefix


--- Tabla Estatus de orden

SELECT 
   CONVERT(date, ord.order_purchase_timestamp) AS Fecha_Compra,
   ordp.order_id,
   ordp.payment_type
FROM  (
    SELECT DISTINCT order_id, payment_type
    FROM [E Commerce Data Brazilian].[dbo].[order_payments]
) ordp
JOIN [E Commerce Data Brazilian].[dbo].[orders] ord
ON ordp.order_id = ord.order_id;



