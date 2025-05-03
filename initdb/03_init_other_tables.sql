-- === DIMENSIONS ===

-- CUSTOMER
CREATE TABLE IF NOT EXISTS dim_customer (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INT,
    email TEXT,
    country TEXT,
    postal_code TEXT,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT
);

INSERT INTO dim_customer (first_name, last_name, age, email, country, postal_code, pet_type, pet_name, pet_breed)
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
FROM staging_sales;

-- SELLER
CREATE TABLE IF NOT EXISTS dim_seller (
    seller_id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

INSERT INTO dim_seller (first_name, last_name, email, country, postal_code)
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM staging_sales;

-- PRODUCT
CREATE TABLE IF NOT EXISTS dim_product (
    product_id SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    price NUMERIC,
    weight NUMERIC,
    color TEXT,
    size TEXT,
    brand TEXT,
    material TEXT,
    description TEXT,
    rating NUMERIC,
    reviews INT,
    release_date DATE,
    expiry_date DATE
);

INSERT INTO dim_product (name, category, price, weight, color, size, brand, material, description, rating, reviews, release_date, expiry_date)
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
FROM staging_sales;

-- STORE
CREATE TABLE IF NOT EXISTS dim_store (
    store_id SERIAL PRIMARY KEY,
    name TEXT,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    phone TEXT,
    email TEXT
);

INSERT INTO dim_store (name, location, city, state, country, phone, email)
SELECT DISTINCT
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM staging_sales;

-- SUPPLIER
CREATE TABLE IF NOT EXISTS dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    name TEXT,
    contact TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    city TEXT,
    country TEXT
);

INSERT INTO dim_supplier (name, contact, email, phone, address, city, country)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM staging_sales;

-- DATE
CREATE TABLE IF NOT EXISTS dim_date (
    date DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    weekday TEXT
);

INSERT INTO dim_date (date, year, month, day, weekday)
SELECT DISTINCT
    sale_date,
    EXTRACT(YEAR FROM sale_date),
    EXTRACT(MONTH FROM sale_date),
    EXTRACT(DAY FROM sale_date),
    TO_CHAR(sale_date, 'Day')
FROM staging_sales;

-- PET CATEGORY
CREATE TABLE IF NOT EXISTS dim_pet_category (
    category_id SERIAL PRIMARY KEY,
    pet_category TEXT UNIQUE
);

INSERT INTO dim_pet_category (pet_category)
SELECT DISTINCT pet_category FROM staging_sales;
