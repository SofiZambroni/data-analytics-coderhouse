
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


