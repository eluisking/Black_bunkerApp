-- Crear tabla de miembros
CREATE TABLE members (
    id_member SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(60),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT now()
);

-- Crear tabla de roles
CREATE TABLE roles (
    id_role SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL CHECK (name IN ('admin', 'coach', 'usuario'))
);

-- Crear tabla intermedia para múltiples roles
CREATE TABLE member_roles (
    id_memeber_rol SERIAL PRIMARY KEY,
    fk_id_member INTEGER REFERENCES members(id_member) ON DELETE CASCADE,
    fk_id_role INTEGER REFERENCES roles(id_role) ON DELETE CASCADE
);

-- Crear tabla de suscripciones
CREATE TABLE subscriptions (
    id_subcription SERIAL PRIMARY KEY,
    fk_id_member INTEGER REFERENCES members(id_member) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('activo', 'inactivo')) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

-- Crear tabla de eventos
CREATE TABLE events (
    id_event SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(150),
    event_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

-- Crear tabla de logros (relacionando miembros con eventos)
CREATE TABLE achievements (
    id_achievement SERIAL PRIMARY KEY,
    fk_id_member INTEGER REFERENCES members(id_member) ON DELETE CASCADE,
    fk_id_event INTEGER REFERENCES events(id_event) ON DELETE CASCADE,
    position INT, -- Posición obtenida (opcional)
    created_at TIMESTAMP DEFAULT now()
);
