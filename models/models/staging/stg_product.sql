SELECT
products_id
,CAST(purchSE_price AS FLOAT64) AS purchase_prices
FROM `gz_raw_data.raw_gz_product`