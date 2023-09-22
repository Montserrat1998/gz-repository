WITH 

  sales AS (
    SELECT
      date_date
      ,orders_id
      ,pdt_id AS products_id
      ,revenue AS turnover
      ,quantity AS qty
    FROM `gz_raw_data.raw_gz_sales`
    WHERE revenue > 0
    )

  ,product AS (
    SELECT
      products_id
      ,CAST(purchSE_PRICE AS FLOAT64) AS purchase_price
    FROM `gz_raw_data.raw_gz_product`
  )

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id
  ###########
	-- qty --
	,s.qty
  -- revenue --
  ,s.turnover
  -- cost --
  ,purchase_price AS purchase_price
	,ROUND(s.qty*purchase_price,2) AS purchase_cost
	-- margin --
	,ROUND(s.turnover-s.qty*purchase_price,2) AS product_margin
  ,ROUND(SAFE_DIVIDE((s.turnover-s.qty*purchase_price), s.turnover), 2) AS product_margin_percent
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id