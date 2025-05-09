CREATE TABLE IF NOT EXISTS dim_pet_category (
    id SERIAL PRIMARY KEY,
    category TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_location (
    id SERIAL PRIMARY KEY,
    country TEXT,
    state TEXT,
    city TEXT,
    postal_code TEXT,
    location TEXT 
);


CREATE TABLE IF NOT EXISTS dim_pet (
    id SERIAL PRIMARY KEY,
    type TEXT,
    name TEXT,
    breed TEXT,
    pet_category_id INT REFERENCES dim_pet_category(id)
);

CREATE TABLE IF NOT EXISTS dim_customer (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INT,
    email TEXT UNIQUE,
    location_id INT REFERENCES dim_location(id)
);

CREATE TABLE IF NOT EXISTS dim_seller (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT UNIQUE,
    location_id INT REFERENCES dim_location(id)
);

CREATE TABLE IF NOT EXISTS dim_product (
    id SERIAL PRIMARY KEY,
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

CREATE TABLE IF NOT EXISTS dim_store (
    id SERIAL PRIMARY KEY,
    name TEXT,
    location_id INT REFERENCES dim_location(id),
    phone TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS dim_supplier (
    id SERIAL PRIMARY KEY,
    name TEXT,
    contact TEXT,
    email TEXT UNIQUE,
    phone TEXT,
    address TEXT,
    location_id INT REFERENCES dim_location(id)
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    quarter INT,
    month INT,
    day INT,
    weekday TEXT
);
