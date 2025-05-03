-- === FACT TABLE ===

CREATE TABLE IF NOT EXISTS fact_sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customer(customer_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    product_id INT REFERENCES dim_product(product_id),
    store_id INT REFERENCES dim_store(store_id),
    supplier_id INT REFERENCES dim_supplier(supplier_id),
    pet_category_id INT REFERENCES dim_pet_category(category_id),
    sale_date DATE REFERENCES dim_date(date),
    quantity INT,
    total_price NUMERIC
);

-- === INSERT INTO FACT TABLE ===

INSERT INTO fact_sales (
    customer_id, seller_id, product_id, store_id, supplier_id, pet_category_id, sale_date, quantity, total_price
)
SELECT
    c.customer_id,
    s.seller_id,
    p.product_id,
    st.store_id,
    sup.supplier_id,
    pc.category_id,
    ss.sale_date,
    ss.sale_quantity,
    ss.sale_total_price
FROM staging_sales ss
JOIN dim_customer c ON
    c.first_name = ss.customer_first_name AND
    c.last_name = ss.customer_last_name AND
    c.email = ss.customer_email

JOIN dim_seller s ON
    s.first_name = ss.seller_first_name AND
    s.last_name = ss.seller_last_name AND
    s.email = ss.seller_email

JOIN dim_product p ON
    p.name = ss.product_name AND
    p.price = ss.product_price AND
    p.category = ss.product_category

JOIN dim_store st ON
    st.name = ss.store_name AND
    st.city = ss.store_city AND
    st.phone = ss.store_phone

JOIN dim_supplier sup ON
    sup.name = ss.supplier_name AND
    sup.email = ss.supplier_email

JOIN dim_pet_category pc ON
    pc.pet_category = ss.pet_category

JOIN dim_date d ON
    d.date = ss.sale_date;
