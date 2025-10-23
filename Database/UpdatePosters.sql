-- Script para actualizar los pósters de las películas y series en StreamingDB
-- Ejecutar este script DESPUÉS de crear la base de datos inicial

USE StreamingDB;

-- Actualizar pósters de PELÍCULAS con URLs de TMDb (The Movie Database)
-- Estas son URLs públicas de imágenes de pósters

UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg' WHERE Id = 1;  -- Origen/Inception
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg' WHERE Id = 2;  -- El Padrino
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg' WHERE Id = 3;  -- Cadena Perpetua
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg' WHERE Id = 4;  -- El Caballero Oscuro
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/saHP97rTPS5eLmrLQEcANmKrsFl.jpg' WHERE Id = 5;  -- Forrest Gump
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg' WHERE Id = 6;  -- Matrix
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg' WHERE Id = 7;  -- Interestelar
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg' WHERE Id = 8;  -- Titanic
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg' WHERE Id = 9;  -- El Rey León
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg' WHERE Id = 10; -- Avengers: Endgame

-- Actualizar pósters de SERIES
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg' WHERE Id = 11; -- Breaking Bad
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg' WHERE Id = 12; -- Stranger Things
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg' WHERE Id = 13; -- Game of Thrones
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/4ZdXlsF6JunDPDn7t3HFHO0rJDp.jpg' WHERE Id = 14; -- The Crown
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg' WHERE Id = 15; -- The Mandalorian
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/7DJKHzAz83BmQrWLrYYOqcoKfhR.jpg' WHERE Id = 16; -- The Office
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/56v2KjBlU4XaOv9rVYEQypROD7P.jpg' WHERE Id = 17; -- Dark
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/rgDSzoZhjD3Kf9oIbOdVLzhRbNr.jpg' WHERE Id = 18; -- The Witcher
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/5UaYsGZOFhjFDwQix4B7Pcmw6N5.jpg' WHERE Id = 19; -- Black Mirror
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/f496cm4bnkDtsLlWWpRyIUzjLfP.jpg' WHERE Id = 20; -- Friends

-- Actualizar pósters de películas adicionales
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg' WHERE Id = 21; -- La La Land
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg' WHERE Id = 22; -- Joker
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg' WHERE Id = 23; -- Parásitos
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/56zTpe2xvaA4alU51sRWPoKPYZy.jpg' WHERE Id = 24; -- El Señor de los Anillos
UPDATE Contenidos SET Poster = 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg' WHERE Id = 25; -- Pulp Fiction

-- Verificar que todos los contenidos tienen póster
SELECT 
    Id, 
    Titulo, 
    Tipo,
    CASE 
        WHEN Poster IS NULL THEN 'SIN PÓSTER' 
      WHEN Poster = '' THEN 'PÓSTER VACÍO'
      ELSE 'PÓSTER ASIGNADO' 
    END AS EstadoPoster,
    LEFT(Poster, 50) AS VistaPrevia
FROM Contenidos
ORDER BY Id;

-- Contar cuántos contenidos tienen póster
SELECT 
    'Contenidos con póster' AS Estado,
 COUNT(*) AS Total
FROM Contenidos
WHERE Poster IS NOT NULL AND Poster != ''
UNION ALL
SELECT 
    'Contenidos sin póster',
    COUNT(*)
FROM Contenidos
WHERE Poster IS NULL OR Poster = '';

```
