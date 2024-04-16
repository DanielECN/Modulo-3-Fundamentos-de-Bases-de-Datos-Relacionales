-- CREACION DATABASE --

CREATE DATABASE IF NOT EXISTS AlkeWallet;
USE AlkeWallet;

-- CREACION TABLA DE USUARIOS --

CREATE TABLE IF NOT EXISTS Usuarios(
		user_id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(80),
		correo_electronico VARCHAR(100),
		contraseña VARCHAR(100),
		saldo DECIMAL(10,2),
		fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CREACION TABLA DE TRANSACCIONES --

CREATE TABLE IF NOT EXISTS Transacciones(
		transaccion_id INT AUTO_INCREMENT PRIMARY KEY,
        sender_user_id INT,
        receiver_user_id INT,
        importe DECIMAL(10,2),
        transation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (sender_user_id) REFERENCES usuarios(user_id),
        FOREIGN KEY (receiver_user_id) REFERENCES usuarios(user_id)
);

-- CREACION TABLA DE MONEDAS --

CREATE TABLE IF NOT EXISTS Monedas(
		currency_id INT AUTO_INCREMENT PRIMARY kEY,
        currency_name VARCHAR(50),
        currency_symbol VARCHAR(5)
);

-- INSERTAR USUARIOS Y TRANSACCIONES  --

INSERT INTO  Usuarios  (Nombre, correo_electronico, contraseña, Saldo)
VALUES 
	("Ana García", "ana.garcia@email.com", ShA2("claveSegura123",256), 10000),
    ("Carlos Rodríguez", "carlos.rodriguez@email.com", ShA2("MiPassw0rd!",256), 3000),
    ("Pedro Martínez", "carlos.rodriguez@email.com", ShA2("MiPassw0rd!",256), 3000),
    ("Carlos Rodríguez", "pedro.martinez@email.com", ShA2("Martinez123",256), 2000),
    ("Laura Fernández", "laura.fernandez@email.com", ShA2("F3rn@nd3z",256), 6000);
    
INSERT INTO  Transacciones (sender_user_id, receiver_user_id, importe)
    VALUES 
		(1, 2, 25000.20),
        (1, 3, 50000),
        (2, 3, 1230000),
        (3, 1, 5000),
        (2, 1, 25000);
        	
INSERT INTO  Monedas (currency_name, currency_symbol)
	
    VALUES
		("DOLAR", "$"),
        ("EURO", "Є"),
        ("Libra esternina", "£");
        
-- Consulta para obtener el nombre de la moneda elegida por un usuario específico --

ALTER TABLE usuarios
ADD moneda_escogida VARCHAR(50), ADD currency_symbol VARCHAR(5);

UPDATE usuarios
SET moneda_escogida = 'DOLAR', currency_symbol = "$"
WHERE user_id = '1'; 

UPDATE usuarios
SET moneda_escogida = 'EURO', currency_symbol = "Є"
WHERE user_id = '2'; 

UPDATE usuarios
SET moneda_escogida = 'EURO', currency_symbol = "Є"
WHERE user_id = '3'; 

UPDATE usuarios
SET moneda_escogida = 'DOLAR', currency_symbol = "$"
WHERE user_id = '4'; 

UPDATE usuarios
SET moneda_escogida = 'Libra esternina', currency_symbol = "£"
WHERE user_id = '5'; 

SELECT nombre, moneda_escogida, currency_symbol FROM usuarios WHERE user_id = 1;

-- Consulta para obtener las transacciones realizadas por un usuario específico --

SELECT transaccion_id, sender_user_id, importe, transation_date, u.nombre AS nombre_usuario
FROM Transacciones t
JOIN Usuarios u ON t.sender_user_id = u.user_id WHERE user_id = 1;

-- Consulta para obtener todos los usuarios registrados --

SELECT * FROM usuarios;

-- Consulta para obtener todas las monedas registradas --

SELECT * FROM monedas;

-- Consulta para obtener todas las transacciones registradas --

SELECT * FROM transacciones;

-- - Consulta para obtener todas las transacciones realizadas por un usuario específico --

SELECT t.*, u.nombre AS nombre_usuario
FROM Transacciones t
JOIN Usuarios u ON t.sender_user_id = u.user_id OR t.receiver_user_id = u.user_id WHERE user_id = 3;

-- - Consulta para obtener todas las transacciones recibidas por un usuario específico

SELECT transaccion_id, receiver_user_id, importe, transation_date, u.nombre AS nombre_usuario
FROM Transacciones t
JOIN Usuarios u ON t.receiver_user_id = u.user_id WHERE user_id = 3;

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico --

UPDATE usuarios
SET correo_electronico = 'nuevo_correo_del_usuario_numero_uno@email.com'
WHERE user_id = 1;

SELECT * FROM usuarios;

-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) --

ALTER TABLE Transacciones
ADD CONSTRAINT fk_sender_user_id
FOREIGN KEY (sender_user_id)
REFERENCES Usuarios (user_id)
ON DELETE CASCADE;

ALTER TABLE Transacciones
ADD CONSTRAINT fk_receiver_user_id
FOREIGN KEY (receiver_user_id)
REFERENCES Usuarios (user_id)
ON DELETE CASCADE;

DELETE FROM Usuarios
WHERE user_id = 1;

SELECT * FROM usuarios;

-- Sentencia para DDL modificar el nombre de la columna correo_electronico por email --

ALTER TABLE usuarios
CHANGE correo_electronico 
email VARCHAR(100);

SELECT * FROM usuarios;









        
