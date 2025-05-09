INSERT INTO dim_location (country, state, city, postal_code, location) -- 1
SELECT DISTINCT
    customer_country, NULL, NULL, customer_postal_code, NULL
FROM staging_sales
UNION
SELECT DISTINCT
    seller_country, NULL, NULL, seller_postal_code, NULL
FROM staging_sales
UNION
SELECT DISTINCT
    store_country, store_state, store_city, NULL, store_location
FROM staging_sales
UNION
SELECT DISTINCT
    supplier_country, NULL, supplier_city, NULL, NULL
FROM staging_sales
ON CONFLICT DO NOTHING;

INSERT INTO dim_pet_category (category)  -- 2
SELECT DISTINCT pet_category
FROM staging_sales
WHERE pet_category IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO dim_pet (type, name, breed, pet_category_id) -- 3
SELECT DISTINCT
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed,
    pc.id
FROM staging_sales s
JOIN dim_pet_category pc ON s.pet_category = pc.category
ON CONFLICT DO NOTHING;

INSERT INTO dim_customer (first_name, last_name, age, email, location_id) -- 4
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    l.id
FROM staging_sales s
JOIN dim_location l
  ON l.country = s.customer_country AND l.postal_code = s.customer_postal_code
ON CONFLICT DO NOTHING;

INSERT INTO dim_seller (first_name, last_name, email, location_id) -- 5
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    l.id
FROM staging_sales s
JOIN dim_location l
  ON l.country = s.seller_country AND l.postal_code = s.seller_postal_code
ON CONFLICT DO NOTHING;

INSERT INTO dim_store (name, location_id, phone, email) -- 6
SELECT DISTINCT
    store_name,
    l.id,
    store_phone,
    store_email
FROM staging_sales s
JOIN dim_location l
  ON l.country = s.store_country AND l.state = s.store_state AND l.city = s.store_city AND l.location = s.store_location
ON CONFLICT DO NOTHING;

INSERT INTO dim_supplier (name, contact, email, phone, address, location_id) -- 7
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    l.id
FROM staging_sales s
JOIN dim_location l
  ON l.country = s.supplier_country AND l.city = s.supplier_city
ON CONFLICT DO NOTHING;

INSERT INTO dim_product ( -- 8
    name, category, price, weight, color, size, brand,
    material, description, rating, reviews, release_date, expiry_date
)
SELECT DISTINCT
    product_name,
    product_category,
    product_price,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date
FROM staging_sales
ON CONFLICT DO NOTHING;

INSERT INTO dim_date (date_id, year, quarter, month, day, weekday) -- 9
SELECT DISTINCT
    sale_date,
    EXTRACT(YEAR FROM sale_date),
    EXTRACT(QUARTER FROM sale_date),
    EXTRACT(MONTH FROM sale_date),
    EXTRACT(DAY FROM sale_date),
    TO_CHAR(sale_date, 'Day')
FROM staging_sales
WHERE sale_date IS NOT NULL
ON CONFLICT DO NOTHING;
