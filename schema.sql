-- Base de données Mr E LIVRÉ & TRANSPORT - Version Globale
-- Compatible : Supabase / Neon / PostgreSQL Cloud

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('ADMIN', 'DRIVER', 'CLIENT', 'SHOP_OWNER')),
    phone_verified BOOLEAN DEFAULT FALSE,
    otp_code VARCHAR(6),
    otp_expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS driver_kyc (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    driver_id UUID REFERENCES users(id) ON DELETE CASCADE,
    id_card_number VARCHAR(50) NOT NULL,
    id_card_image_url VARCHAR(255),
    driver_license_url VARCHAR(255),
    vehicle_registration_url VARCHAR(255),
    vehicle_type VARCHAR(20) NOT NULL CHECK (vehicle_type IN ('MOTO', 'TAXI', 'AUTO', 'BUS')),
    license_plate VARCHAR(30) NOT NULL,
    kyc_status VARCHAR(20) DEFAULT 'PENDING' CHECK (kyc_status IN ('PENDING', 'APPROVED', 'REJECTED')),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID REFERENCES users(id) ON DELETE CASCADE,
    shop_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    location_address VARCHAR(255) NOT NULL,
    location_lat NUMERIC(10, 8) NOT NULL,
    location_lng NUMERIC(11, 8) NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    shop_id UUID REFERENCES shops(id) ON DELETE CASCADE,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rides_and_deliveries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(20) NOT NULL CHECK (type IN ('DELIVERY', 'PASSENGER_TRANSPORT')),
    client_id UUID REFERENCES users(id),
    driver_id UUID REFERENCES users(id),
    shop_id UUID REFERENCES shops(id),
    pickup_location VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    fare_amount NUMERIC(10, 2) NOT NULL,
    commission_amount NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    payment_method VARCHAR(30) DEFAULT 'MOBILE_MONEY',
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'ACCEPTED', 'COMPLETED', 'CANCELLED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
