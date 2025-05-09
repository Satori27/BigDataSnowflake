CREATE TABLE IF NOT EXISTS fact_sales (
    id SERIAL PRIMARY KEY,

    sale_date_id DATE NOT NULL,
    customer_id INT NOT NULL,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    pet_id INT,
    store_id INT NOT NULL,
    supplier_id INT NOT NULL,

    sale_quantity INT NOT NULL,
    sale_total_price NUMERIC NOT NULL,

    -- Уникальность одной продажи по дате, клиенту, товару и продавцу (можно расширить при необходимости)
    CONSTRAINT uq_fact_sales_unique UNIQUE (
        sale_date_id,
        customer_id,
        seller_id,
        product_id,
        store_id
    ),

    -- Внешние ключи на измерения
    CONSTRAINT fk_fact_sales_date FOREIGN KEY (sale_date_id) REFERENCES dim_date(date_id),
    CONSTRAINT fk_fact_sales_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(id),
    CONSTRAINT fk_fact_sales_seller FOREIGN KEY (seller_id) REFERENCES dim_seller(id),
    CONSTRAINT fk_fact_sales_product FOREIGN KEY (product_id) REFERENCES dim_product(id),
    CONSTRAINT fk_fact_sales_pet FOREIGN KEY (pet_id) REFERENCES dim_pet(id),
    CONSTRAINT fk_fact_sales_store FOREIGN KEY (store_id) REFERENCES dim_store(id),
    CONSTRAINT fk_fact_sales_supplier FOREIGN KEY (supplier_id) REFERENCES dim_supplier(id)
);