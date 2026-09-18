
   /* ============================================================
  Crear base de datos
   ============================================================ */

CREATE DATABASE Ventas_Tech_DB;
GO

/* ============================================================
 Posicionarse en base de datos
   ============================================================ */

USE Ventas_Tech_DB;
GO

DROP TABLE IF EXISTS dbo.VENTAS;
DROP TABLE IF EXISTS dbo.DimClientes;
DROP TABLE IF EXISTS dbo.DimProducto;
DROP TABLE IF EXISTS dbo.DimCategoria;
DROP TABLE IF EXISTS dbo.DimCanal_Venta;
DROP TABLE IF EXISTS dbo.DimTerritorio;


/* ============================================================
  Crear tablas de dimension
   ============================================================ */

CREATE TABLE dbo.DimCategoria (
    id_Categoria INT PRIMARY KEY,
    Nombre_Categoria NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.DimCanal_Venta (
    id_Canal INT PRIMARY KEY,
    Nombre_Canal NVARCHAR(150) NOT NULL
);

CREATE TABLE dbo.DimProducto (
    id_Producto INT PRIMARY KEY,
    Nombre_Producto NVARCHAR(50) NOT NULL,
    Precio_Producto NVARCHAR(50) NOT NULL,
    Cantidad NVARCHAR (50) NOT NULL,
    id_categoria INT FOREIGN KEY REFERENCES dbo.DimCategoria
);

CREATE TABLE dbo.DimTerritorio (
    id_Territorio INT PRIMARY KEY,
    Codigo_postal NVARCHAR(50) NOT NULL,
);
    
CREATE TABLE dbo.DimClientes (
    id_Cliente INT PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Ciudad NVARCHAR (50) NOT NULL,
    Telefono NVARCHAR(50) NOT NULL,
    Domicilio NVARCHAR(50) NOT NULL,
    Fecha_registro DATE NOT NULL,
    ID_Territorio INT FOREIGN KEY REFERENCES dbo.DimTerritorio
);

GO

/* ============================================================
  Crear tabla de Hechos (Fact) 
   ============================================================ */

CREATE TABLE dbo.VENTAS (
    ID_Venta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    Cantidad INT NOT NULL, 
    Total_venta DECIMAL (18,2) NOT NULL,
    Porcentaje_descuento DECIMAL (10,2) NULL,
        

    id_Cliente INT NOT NULL,
    id_Producto INT NOT NULL,
    id_Categoria INT NOT NULL,
    id_Canal INT NOT NULL,
    id_Territorio INT NOT NULL,

    -- Crear Constraints FK
    
    CONSTRAINT FK_id_Cliente FOREIGN KEY (id_Cliente) REFERENCES dbo.DimClientes(id_Cliente),
    CONSTRAINT FK_Producto FOREIGN KEY (id_Producto) REFERENCES dbo.DimProducto(id_Producto),
    CONSTRAINT FK_Categoria FOREIGN KEY (id_Categoria) REFERENCES dbo.DimCategoria(id_Categoria),
    CONSTRAINT FK_Canal FOREIGN KEY (id_Canal) REFERENCES dbo.DimCanal_Venta(id_Canal),
    CONSTRAINT FK_Territorio FOREIGN KEY (id_Territorio) REFERENCES dbo.DimTerritorio(id_Territorio),
);
GO

SELECT * FROM DimCanal_Venta 

INSERT INTO dbo.DimCanal_Venta (id_Canal, Nombre_Canal)
VALUES 
    (1, 'e-commerce'),
    (2, 'local_fisico');

SELECT * FROM DimCategoria

INSERT INTO DimCategoria (id_Categoria, Nombre_Categoria)
VALUES
(1, 'Monitores'),
(2, 'Teclados'),
(3, 'Audio'),
(4, 'Mouses'),
(5, 'Seguridad'),
(6, 'Notebooks'),
(7, 'Tablets'),
(8, 'Accesorios')
;

SELECT * FROM DimTerritorio

ALTER TABLE dbo.DimTerritorio
ADD 
    Codigo_Provincia VARCHAR(5) NULL,
    Provincia NVARCHAR(100) NULL,
    Ciudad NVARCHAR(100) NULL;


INSERT INTO dbo.DimTerritorio (id_Territorio, Codigo_Provincia, Provincia, Ciudad, Codigo_postal)
VALUES 
(1, 'CBA', 'Córdoba', 'Vicuña Mackenna', '6140'),
(2, 'CBA', 'Córdoba', 'Córdoba Capital', '5000'),
(3, 'BSAS', 'Buenos Aires', 'Bahía Blanca', '8000'),
(4, 'LP', 'La Pampa', 'Santa Rosa', '6300'),
(5, 'SAL', 'Salta', 'Tartagal', '4650'),
(6, 'MDZ', 'Mendoza', 'San Rafael', '5600'),
(7, 'CH', 'Chubut', 'Puerto Madryn', '9120');


SELECT * FROM DimProducto

ALTER TABLE dbo.DimProducto
ALTER COLUMN Precio_Producto DECIMAL(10, 2) NOT NULL;

ALTER TABLE dbo.DimProducto
ALTER COLUMN Cantidad INT NOT NULL;

INSERT INTO dbo.DimProducto (id_Producto, Nombre_Producto, Precio_Producto, Cantidad, id_categoria)
VALUES
(1, 'Monitor 24 Pulgadas Full HD', 185000.00, 15, 1),
(2, 'Monitor Curvo 27 Pulgadas', 320000.50, 8, 1),
(3, 'Teclado Mecánico RGB', 65000.00, 25, 2),
(4, 'Auriculares Inalámbricos Bluetooth', 42000.00, 30, 3),
(5, 'Mouse Ergonómico Inalámbrico', 28500.00, 40, 4),
(6, 'Cámara de Seguridad WiFi 1080p', 54000.00, 12, 5),
(7, 'Notebook 15.6 i5 16GB RAM', 890000.00, 6, 6),
(8, 'Tablet 10 Pulgadas 64GB', 210000.00, 10, 7),
(9, 'Soporte para Notebook de Aluminio', 19500.00, 50, 8);



SELECT * FROM DimClientes

INSERT INTO dbo.DimClientes (id_Cliente, Nombre, Email, Ciudad, Telefono, Domicilio, Fecha_registro, ID_Territorio)
VALUES
(1, 'Lucas Gómez', 'lucas.gomez@email.com', 'Vicuña Mackenna', '1145678901', 'Av. San Martín 123', '2023-01-15', 1),
(2, 'Sofía Martínez', 'sofia.martinez@email.com', 'Córdoba Capital', '3512345678', 'Bv. Chacabuco 450', '2023-02-20', 2),
(3, 'Mariano López', 'mariano.lopez@email.com', 'Bahía Blanca', '2914567890', 'Calle Alsina 88', '2023-03-05', 3),
(4, 'Valeria Romero', 'valeria.romero@email.com', 'Santa Rosa', '2954123456', 'Av. España 520', '2023-04-12', 4),
(5, 'Carlos Fernández', 'carlos.f@email.com', 'Tartagal', '3876543210', 'Belgrano 340', '2023-05-18', 5),
(6, 'Lucía Álvarez', 'lucia.alvarez@email.com', 'San Rafael', '2604567890', 'Mitre 710', '2023-06-22', 6),
(7, 'Martín Díaz', 'martin.diaz@email.com', 'Puerto Madryn', '2804123456', 'Roca 205', '2023-07-10', 7),
(8, 'Florencia Herrera', 'flor.herrera@email.com', 'Córdoba Capital', '3519876543', 'Av. Colón 1500', '2023-08-01', 2);

SELECT * FROM VENTAS

INSERT INTO dbo.VENTAS (Fecha, Cantidad, Total_venta, Porcentaje_descuento, id_Cliente, id_Producto, id_Categoria, id_Canal, id_Territorio)
VALUES
-- Venta 1: Monitor 24" (Cat 1, $185.000 x 2 con 5% desc) a Lucas en Vicuña Mackenna por e-commerce
('2023-09-01', 2, 351500.00, 0.05, 1, 1, 1, 1, 1),

-- Venta 2: Teclado Mecánico (Cat 2, $65.000 x 1) a Sofía en Cba Capital por local físico
('2023-09-03', 1, 65000.00, 0.00, 2, 3, 2, 2, 2),

-- Venta 3: Notebook i5 (Cat 6, $890.000 x 3 con 10% desc) a Mariano en Bahía Blanca por e-commerce
('2023-09-10', 3, 2403000.00, 0.10, 3, 7, 6, 1, 3),

-- Venta 4: Auriculares Bluetooth (Cat 3, $42.000 x 2) a Valeria en Santa Rosa por e-commerce
('2023-09-15', 2, 84000.00, 0.00, 4, 4, 3, 1, 4),

-- Venta 5: Cámara de Seguridad (Cat 5, $54.000 x 4 con 15% desc) a Carlos en Tartagal por local físico
('2023-09-20', 4, 183600.00, 0.15, 5, 6, 5, 2, 5),

-- Venta 6: Tablet 10" (Cat 7, $210.000 x 1) a Lucía en San Rafael por e-commerce
('2023-09-25', 1, 210000.00, 0.00, 6, 8, 7, 1, 6),

-- Venta 7: Mouse Ergonómico (Cat 4, $28.500 x 3) a Martín en Puerto Madryn por e-commerce
('2023-10-02', 3, 85500.00, 0.00, 7, 5, 4, 1, 7),

-- Venta 8: Soporte Notebook (Cat 8, $19.500 x 5 con 5% desc) a Florencia en Cba Capital por local físico
('2023-10-05', 5, 92625.00, 0.05, 8, 9, 8, 2, 2),

-- Venta 9: Monitor Curvo 27" (Cat 1, $320.000,50 x 1) a Sofía en Cba Capital por e-commerce
('2023-10-12', 1, 320000.50, 0.00, 2, 2, 1, 1, 2);


--Profes me llevo mucho tiempo entre los trabajos que actualmente tengo y la vida misma, recibi mucha ayuda de Ticher
-- mas que nada en la carga de las ventas y datos de clientes porque no se me caía una idea lit. Pero acá quedo! -- 



