-- Очистка (на случай повторного запуска)
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS property_images CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Таблица пользователей
CREATE TABLE users (
                       id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       role VARCHAR(20) NOT NULL,
                       phone VARCHAR(20),
                       created_at TIMESTAMPTZ DEFAULT now()
);

-- Таблица объектов недвижимости
CREATE TABLE properties (
                            id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                            owner_id INT NOT NULL,
                            title VARCHAR(200) NOT NULL,
                            description TEXT,
                            price_per_month NUMERIC(10,2) NOT NULL,
                            address VARCHAR(200) NOT NULL,
                            city VARCHAR(100),
                            property_type VARCHAR(50),
                            area NUMERIC(10,2),
                            rooms INT,
                            created_at TIMESTAMPTZ DEFAULT now(),
                            is_available BOOLEAN DEFAULT TRUE,
                            CONSTRAINT fk_properties_owner FOREIGN KEY (owner_id)
                                REFERENCES users (id) ON DELETE CASCADE
);

-- Таблица изображений
CREATE TABLE property_images (
                                 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                                 property_id INT NOT NULL,
                                 url VARCHAR(255) NOT NULL,
                                 is_main BOOLEAN DEFAULT FALSE,
                                 CONSTRAINT fk_images_property FOREIGN KEY (property_id)
                                     REFERENCES properties (id) ON DELETE CASCADE
);

-- Таблица бронирований
CREATE TABLE bookings (
                          id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                          property_id INT NOT NULL,
                          tenant_id INT NOT NULL,
                          start_date DATE NOT NULL,
                          end_date DATE NOT NULL,
                          status VARCHAR(20) NOT NULL,
                          total_price NUMERIC(10,2),
                          created_at TIMESTAMPTZ DEFAULT now(),
                          CONSTRAINT fk_bookings_property FOREIGN KEY (property_id)
                              REFERENCES properties (id) ON DELETE CASCADE,
                          CONSTRAINT fk_bookings_tenant FOREIGN KEY (tenant_id)
                              REFERENCES users (id) ON DELETE CASCADE,
                          CONSTRAINT chk_dates CHECK (end_date >= start_date)
);

-- Таблица отзывов
CREATE TABLE reviews (
                         id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         property_id INT NOT NULL,
                         user_id INT NOT NULL,
                         rating INT,
                         comment TEXT,
                         created_at TIMESTAMPTZ DEFAULT now(),
                         CONSTRAINT reviews_rating_check CHECK (rating >= 1 AND rating <= 5),
                         CONSTRAINT fk_reviews_property FOREIGN KEY (property_id)
                             REFERENCES properties (id) ON DELETE CASCADE,
                         CONSTRAINT fk_reviews_user FOREIGN KEY (user_id)
                             REFERENCES users (id) ON DELETE CASCADE
);