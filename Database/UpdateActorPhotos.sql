-- Script para agregar columna Foto a la tabla Actores y actualizar con fotos reales
-- Ejecutar este script DESPUÉS de crear la base de datos inicial

USE StreamingDB;

-- Agregar columna Foto a la tabla Actores
ALTER TABLE Actores 
ADD COLUMN Foto VARCHAR(255) NULL;

-- Actualizar fotos de actores con URLs de TMDb (The Movie Database)
-- Estas son URLs públicas de fotos de actores

UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg' WHERE Id = 1;  -- Leonardo DiCaprio
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg' WHERE Id = 2;  -- Scarlett Johansson
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/xxCxMHy0AaN0VPPBDJD8aBnPqPr.jpg' WHERE Id = 3;  -- Tom Hanks
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/3CdVRGwqdDi8wMFeqmIlI8UQZJo.jpg' WHERE Id = 4;  -- Meryl Streep
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/jj2kZqJobjom36wlhlYhc38nTwN.jpg' WHERE Id = 5;  -- Denzel Washington
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/iZjMFM73uxhNG2nTKevFqhSGFnW.jpg' WHERE Id = 6;  -- Emma Stone
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg' WHERE Id = 7;  -- Ryan Gosling
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/oIciQWr8VwKoR8TmAw1rKInfPoy.jpg' WHERE Id = 8;  -- Morgan Freeman
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/edPU5HxncLWa1YkgRPNkSd68ONG.jpg' WHERE Id = 9;  -- Natalie Portman
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/ajNaPmXVVMJFg9GWmu6MJzTaXdV.jpg' WHERE Id = 10; -- Brad Pitt
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/k6l8BWX1yqfGt95enzEkHoPvON4.jpg' WHERE Id = 11; -- Jennifer Lawrence
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/7Ptkjgp6cPKGqLJh4FwAvcIY7rS.jpg' WHERE Id = 12; -- Christian Bale
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/9V83uemR0ra9Wd9iRXTMlfAQlTB.jpg' WHERE Id = 13; -- Cate Blanchett
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg' WHERE Id = 14; -- Robert Downey Jr.
UPDATE Actores SET Foto = 'https://image.tmdb.org/t/p/w500/bKJJjyI6N0cgqZILgUOPPvPUhiB.jpg' WHERE Id = 15; -- Anne Hathaway

-- Verificar que todos los actores tienen foto
SELECT 
    Id, 
    CONCAT(Nombre, ' ', Apellidos) AS NombreCompleto,
    Nacionalidad,
    CASE 
        WHEN Foto IS NULL THEN '? SIN FOTO' 
        WHEN Foto = '' THEN '?? VACÍO'
        ELSE '? OK' 
    END AS EstadoFoto,
    LEFT(Foto, 60) AS VistaPrevia
FROM Actores
ORDER BY Id;

-- Contar cuántos actores tienen foto
SELECT 
    'Actores con foto' AS Estado,
    COUNT(*) AS Total
FROM Actores
WHERE Foto IS NOT NULL AND Foto != ''
UNION ALL
SELECT 
    'Actores sin foto',
    COUNT(*)
FROM Actores
WHERE Foto IS NULL OR Foto = '';

