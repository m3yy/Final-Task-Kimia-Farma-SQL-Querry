SELECT 
  t.transaction_id, 
  t.date, 
  t.branch_id, 
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating,
  t.rating AS Transaction_Rating,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price,
  t.discount_percentage,
   CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
  END AS persentase_gross_laba,
 (t.price * (1 - t.discount_percentage / 100)) AS nett_sales,
 ((t.price * (1 - t.discount_percentage / 100)) * 
    CASE
      WHEN t.price <= 50000 THEN 0.10
      WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
      WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
      WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
      WHEN t.price > 500000 THEN 0.30
    END
  ) AS nett_profit,
 ((t.price * (1 - t.discount_percentage / 100)) + 
    ((t.price * (1 - t.discount_percentage / 100)) * 
      CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        WHEN t.price > 500000 THEN 0.30
      END
    )
  ) AS harga_jual_akhir,
 t.rating 

FROM `kf_dataset.kf_final_transaction` AS t
JOIN `kf_dataset.kf_kantor_cabang` AS c
  ON t.branch_id = c.branch_id
  JOIN `kf_dataset.kf_product` AS p
  ON t.product_id = p.product_id
