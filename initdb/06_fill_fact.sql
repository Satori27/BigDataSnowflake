INSERT INTO fact_sales (
    sale_date_id,
    customer_id,
    seller_id,
    product_id,
    pet_id,
    store_id,
    supplier_id,
    sale_quantity,
    sale_total_price
)
SELECT
    dd.date_id,
    dc.id,
    ds.id,
    dp.id,
    dpet.id,
    dst.id,
    dsup.id,
    s.sale_quantity,
    s.sale_total_price
FROM staging_sales s
JOIN dim_date dd ON dd.date_id = s.sale_date

JOIN dim_customer dc ON dc.first_name = s.customer_first_name
                     AND dc.last_name = s.customer_last_name
                     AND dc.age = s.customer_age
                     AND dc.email = s.customer_email

JOIN dim_seller ds ON ds.first_name = s.seller_first_name
                   AND ds.last_name = s.seller_last_name
                   AND ds.email = s.seller_email

JOIN dim_product dp ON dp.name = s.product_name
                    AND dp.category = s.product_category
                    AND dp.price = s.product_price

LEFT JOIN dim_pet_category dpc ON dpc.category = s.pet_category
LEFT JOIN dim_pet dpet ON dpet.type = s.customer_pet_type
                      AND dpet.name = s.customer_pet_name
                      AND dpet.breed = s.customer_pet_breed
                      AND dpet.pet_category_id = dpc.id

JOIN dim_store dst ON dst.name = s.store_name

JOIN dim_supplier dsup ON dsup.name = s.supplier_name
                       AND dsup.email = s.supplier_email

ON CONFLICT DO NOTHING;
