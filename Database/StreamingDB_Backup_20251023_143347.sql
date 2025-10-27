-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS StreamingDB;
USE StreamingDB;

-- Eliminar tablas si existen (en orden correcto por FK)
DROP TABLE IF EXISTS Valoraciones;
DROP TABLE IF EXISTS ContenidoActores;
DROP TABLE IF EXISTS Contenidos;
DROP TABLE IF EXISTS Actores;
DROP TABLE IF EXISTS Generos;

-- Tabla: Generos

CREATE TABLE Generos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
  Descripcion TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar Géneros
INSERT INTO Generos (Id, Nombre, Descripcion) VALUES
(1, 'Acción', 'Películas y series llenas de adrenalina, persecuciones y escenas de combate espectaculares.'),
(2, 'Drama', 'Historias profundas y emotivas que exploran las relaciones humanas y conflictos personales.'),
(3, 'Comedia', 'Contenido humorístico diseñado para entretener y hacer reír al público.'),
(4, 'Ciencia Ficción', 'Mundos futuristas, tecnología avanzada y exploraciones del universo y la realidad.'),
(5, 'Terror', 'Historias diseñadas para asustar y crear tensión en el espectador.'),
(6, 'Thriller', 'Narrativas de suspense que mantienen al público al borde del asiento.'),
(7, 'Romance', 'Historias de amor y relaciones románticas entre personajes.'),
(8, 'Fantasía', 'Mundos mágicos con criaturas míticas y elementos sobrenaturales.'),
(9, 'Animación', 'Contenido animado para todas las edades con historias creativas.'),
(10, 'Documental', 'Contenido educativo e informativo sobre temas reales.');

-- Tabla: Actores
CREATE TABLE Actores (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Nacionalidad VARCHAR(100) NOT NULL,
    Biografia TEXT,
    Foto VARCHAR(500)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar Actores
INSERT INTO Actores (Id, Nombre, Apellidos, FechaNacimiento, Nacionalidad, Biografia, Foto) VALUES
(1, 'Leonardo', 'DiCaprio', '1974-11-11', 'Estadounidense', 'Actor y productor estadounidense ganador del Oscar, conocido por sus papeles en Titanic, Inception y The Revenant.', 'https://image.tmdb.org/t/p/w500/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg'),
(2, 'Scarlett', 'Johansson', '1984-11-22', 'Estadounidense', 'Actriz y cantante estadounidense, reconocida por su papel como Black Widow en el universo Marvel.', 'https://image.tmdb.org/t/p/w500/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg'),
(3, 'Tom', 'Hanks', '1956-07-09', 'Estadounidense', 'Actor legendario ganador de múltiples premios Oscar, conocido por Forrest Gump y Cast Away.', 'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1257937597.jpg?crop=1xw:1.0xh;center,top&resize=640:*'),
(4, 'Meryl', 'Streep', '1949-06-22', 'Estadounidense', 'Considerada una de las mejores actrices de todos los tiempos, con un récord de nominaciones al Oscar.', 'https://es.web.img3.acsta.net/pictures/17/01/10/13/53/476324.jpg'),
(5, 'Denzel', 'Washington', '1954-12-28', 'Estadounidense', 'Actor, director y productor, ganador de dos premios Oscar por su destacada carrera.', 'https://image.tmdb.org/t/p/w500/jj2kZqJobjom36wlhlYhc38nTwN.jpg'),
(6, 'Emma', 'Stone', '1988-11-06', 'Estadounidense', 'Actriz ganadora del Oscar, conocida por La La Land y Easy A.', 'https://hips.hearstapps.com/es.h-cdn.co/fotoes/images/cinefilia/mapa-de-las-estrellas-emma-stone/30345283-1-esl-ES/Mapa-de-las-estrellas-Emma-Stone.jpg?resize=640:*'),
(7, 'Ryan', 'Gosling', '1980-11-12', 'Canadiense', 'Actor y músico canadiense, reconocido por sus papeles en Drive y La La Land.', 'https://image.tmdb.org/t/p/w500/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg'),
(8, 'Morgan', 'Freeman', '1937-06-01', 'Estadounidense', 'Actor legendario con una voz icónica, ganador del Oscar por Million Dollar Baby.', 'https://m.media-amazon.com/images/M/MV5BMTc0MDMyMzI2OF5BMl5BanBnXkFtZTcwMzM2OTk1MQ@@._V1_FMjpg_UX1000_.jpg'),
(9, 'Natalie', 'Portman', '1981-06-09', 'Estadounidense-Israelí', 'Actriz ganadora del Oscar por Black Swan, también conocida por Star Wars.', 'https://image.tmdb.org/t/p/w500/edPU5HxncLWa1YkgRPNkSd68ONG.jpg'),
(10, 'Brad', 'Pitt', '1963-12-18', 'Estadounidense', 'Actor y productor ganador del Oscar, estrella de películas como Fight Club y Once Upon a Time in Hollywood.', 'https://image.tmdb.org/t/p/w500/ajNaPmXVVMJFg9GWmu6MJzTaXdV.jpg'),
(11, 'Jennifer', 'Lawrence', '1990-08-15', 'Estadounidense', 'Actriz ganadora del Oscar, conocida por Los Juegos del Hambre y Silver Linings Playbook.', 'https://image.tmdb.org/t/p/w500/k6l8BWX1yqfGt95enzEkHoPvON4.jpg'),
(12, 'Christian', 'Bale', '1974-01-30', 'Británico', 'Actor británico conocido por su transformación física en roles como Batman y The Machinist.', 'https://upload.wikimedia.org/wikipedia/commons/0/0a/Christian_Bale-7837.jpg'),
(13, 'Cate', 'Blanchett', '1969-05-14', 'Australiana', 'Actriz australiana ganadora de dos premios Oscar, reconocida por Elizabeth y Blue Jasmine.', 'https://image.tmdb.org/t/p/w500/9V83uemR0ra9Wd9iRXTMlfAQlTB.jpg'),
(14, 'Robert', 'Downey Jr.', '1965-04-04', 'Estadounidense', 'Actor icónico conocido por su papel de Iron Man en el universo cinematográfico de Marvel.', 'https://image.tmdb.org/t/p/w500/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
(15, 'Anne', 'Hathaway', '1982-11-12', 'Estadounidense', 'Actriz ganadora del Oscar por Los Miserables, también conocida por El Diablo Viste a la Moda.', 'https://upload.wikimedia.org/wikipedia/commons/0/03/Anne_Hathaway_at_The_Apprentice_in_NYC_03_%28cropped2%29.jpg'),
(16, 'Mauro Ezequiel', 'Lombardo Quiroga', '1996-06-24', 'Argentina', 'Conocido artísticamente como Duki, es un rapero y trapero argentino. Surgió de las batallas de freestyle de El Quinto Escalón y se convirtió en uno de los artistas urbanos más importantes de Latinoamérica.', 'https://imagenes.elpais.com/resizer/v2/PUNXVKFLRNDMLNED23A4Q5ZWXM.jpg?auth=48b7d7a33597654e6294cc3e27fc76630ee8b3e82940d2e663a3b67dff261bc0&width=980&height=980&smart=true');

-- Tabla: Contenidos
CREATE TABLE Contenidos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(200) NOT NULL,
    Descripcion TEXT NOT NULL,
    Anio INT NOT NULL,
    Duracion INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Director VARCHAR(200) NOT NULL,
    Poster VARCHAR(500),
    FechaEstreno DATE NOT NULL,
    NumeroTemporadas INT,
    GeneroId INT NOT NULL,
    FOREIGN KEY (GeneroId) REFERENCES Generos(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar Contenidos
INSERT INTO Contenidos (Id, Titulo, Descripcion, Anio, Duracion, Tipo, Director, Poster, FechaEstreno, NumeroTemporadas, GeneroId) VALUES
(1, 'Origen', 'Un ladrón que roba secretos corporativos a través del uso de la tecnología de compartir sueños recibe la tarea inversa de plantar una idea en la mente de un CEO.', 2010, 148, 'Pelicula', 'Christopher Nolan', 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg', '2010-07-16', NULL, 4),
(2, 'El Padrino', 'La historia de una dinastía criminal de Nueva York y cómo el hijo menor de la familia se convierte en el nuevo jefe.', 1972, 175, 'Pelicula', 'Francis Ford Coppola', 'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', '1972-03-24', NULL, 2),
(3, 'Cadena Perpetua', 'Dos hombres encarcelados forjan una amistad a lo largo de varios años, encontrando consuelo y eventual redención a través de actos de decencia común.', 1994, 142, 'Pelicula', 'Frank Darabont', 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', '1994-09-23', NULL, 2),
(4, 'El Caballero Oscuro', 'Cuando la amenaza conocida como el Joker causa estragos en Gotham, Batman debe aceptar una de las pruebas psicológicas y físicas más grandes.', 2008, 152, 'Pelicula', 'Christopher Nolan', 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', '2008-07-18', NULL, 1),
(5, 'Forrest Gump', 'Las presidencias de Kennedy y Johnson, Vietnam, Watergate y otros eventos históricos se desarrollan desde la perspectiva de un hombre de Alabama con un coeficiente intelectual de 75.', 1994, 142, 'Pelicula', 'Robert Zemeckis', 'https://image.tmdb.org/t/p/w500/saHP97rTPS5eLmrLQEcANmKrsFl.jpg', '1994-07-06', NULL, 2),
(6, 'Matrix', 'Un hacker descubre que la realidad tal como la conoce es una simulación creada por máquinas para controlar a la humanidad.', 1999, 136, 'Pelicula', 'Lana y Lilly Wachowski', 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg', '1999-03-31', NULL, 4),
(7, 'Interestelar', 'Un equipo de exploradores viaja a través de un agujero de gusano en el espacio en un intento de asegurar la supervivencia de la humanidad.', 2014, 169, 'Pelicula', 'Christopher Nolan', 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', '2014-11-07', NULL, 4),
(8, 'Titanic', 'Una aristócrata de diecisiete años se enamora de un artista amable pero pobre a bordo del lujoso y desafortunado RMS Titanic.', 1997, 194, 'Pelicula', 'James Cameron', 'https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg', '1997-12-19', NULL, 7),
(9, 'El Rey León', 'El príncipe león Simba y su padre son el objetivo del tío de Simba, que quiere ascender al trono.', 1994, 88, 'Pelicula', 'Roger Allers, Rob Minkoff', 'https://image.tmdb.org/t/p/w500/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg', '1994-06-24', NULL, 9),
(10, 'Avengers: Endgame', 'Después de los eventos devastadores de Infinity War, los Vengadores se reúnen una vez más para deshacer las acciones de Thanos.', 2019, 181, 'Pelicula', 'Anthony y Joe Russo', 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg', '2019-04-26', NULL, 1),
(11, 'Breaking Bad', 'Un profesor de química de secundaria diagnosticado con cáncer de pulmón se asocia con un exalumno para fabricar y vender metanfetamina.', 2008, 47, 'Serie', 'Vince Gilligan', 'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg', '2008-01-20', 5, 2),
(12, 'Stranger Things', 'Cuando un niño desaparece, su madre, un jefe de policía y sus amigos deben enfrentarse a fuerzas extraordinarias para recuperarlo.', 2016, 51, 'Serie', 'Matt y Ross Duffer', 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg', '2016-07-15', 4, 4),
(13, 'Game of Thrones', 'Nueve familias nobles luchan por el control de las tierras de Westeros, mientras un antiguo enemigo regresa después de estar dormido durante miles de años.', 2011, 57, 'Serie', 'David Benioff, D.B. Weiss', 'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg', '2011-04-17', 8, 8),
(14, 'The Crown', 'Sigue la vida política de la reina Isabel II y los eventos que dieron forma a la segunda mitad del siglo XX.', 2016, 58, 'Serie', 'Peter Morgan', 'https://www.orientaserie.it/wp-content/uploads/2022/09/ab217271cbd9975a3e352f3690edeb5a-691x1024.png', '2016-11-04', 6, 2),
(15, 'The Mandalorian', 'Las aventuras de un cazarrecompensas solitario en los confines de la galaxia, lejos de la autoridad de la Nueva República.', 2019, 40, 'Serie', 'Jon Favreau', 'https://image.tmdb.org/t/p/w500/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg', '2019-11-12', 3, 4),
(16, 'The Office', 'Una mirada documental a la vida cotidiana de los empleados de la sucursal de Scranton de Dunder Mifflin Paper Company.', 2005, 22, 'Serie', 'Greg Daniels', 'https://m.media-amazon.com/images/M/MV5BZjQwYzBlYzUtZjhhOS00ZDQ0LWE0NzAtYTk4MjgzZTNkZWEzXkEyXkFqcGc@._V1_.jpg', '2005-03-24', 9, 3),
(17, 'Dark', 'Un niño desaparecido lleva a cuatro familias en una búsqueda frenética de respuestas mientras desentrañan una conspiración que abarca tres generaciones.', 2017, 60, 'Serie', 'Baran bo Odar', 'https://image.tmdb.org/t/p/w500/56v2KjBlU4XaOv9rVYEQypROD7P.jpg', '2017-12-01', 3, 6),
(18, 'The Witcher', 'Geralt de Rivia, un cazador de monstruos solitario, lucha por encontrar su lugar en un mundo donde las personas a menudo son más malvadas que las bestias.', 2019, 60, 'Serie', 'Lauren Schmidt Hissrich', 'https://m.media-amazon.com/images/M/MV5BOTQzMzNmMzUtODgwNS00YTdhLTg5N2MtOWU1YTc4YWY3NjRlXkEyXkFqcGc@._V1_.jpg', '2019-12-20', 3, 8),
(19, 'Black Mirror', 'Una antología que explora un futuro retorcido y de alta tecnología donde los mayores innovaciones y los instintos más oscuros de la humanidad chocan.', 2011, 60, 'Serie', 'Charlie Brooker', 'https://m.media-amazon.com/images/M/MV5BMGRjZDBjODMtMWQ1Zi00MWRkLTk5YTMtMDU1NTNkMzhkM2QwXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', '2011-12-04', 6, 4),
(20, 'Friends', 'Sigue la vida personal y profesional de seis amigos veinteañeros viviendo en Manhattan.', 1994, 22, 'Serie', 'David Crane, Marta Kauffman', 'https://m.media-amazon.com/images/M/MV5BOTU2YmM5ZjctOGVlMC00YTczLTljM2MtYjhlNGI5YWMyZjFkXkEyXkFqcGc@._V1_.jpg', '1994-09-22', 10, 3),
(21, 'La La Land', 'Un pianista de jazz y una aspirante a actriz se enamoran mientras intentan conciliar sus aspiraciones para el futuro.', 2016, 128, 'Pelicula', 'Damien Chazelle', 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg', '2016-12-09', NULL, 7),
(22, 'Joker', 'En Gotham City, Arthur Fleck, un comediante fracasado, se sumerge en la locura y se convierte en un asesino psicópata.', 2019, 122, 'Pelicula', 'Todd Phillips', 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg', '2019-10-04', NULL, 2),
(23, 'Parásitos', 'La codicia y la discriminación de clases amenazan la relación simbiótica recién formada entre la rica familia Park y el clan indigente Kim.', 2019, 132, 'Pelicula', 'Bong Joon-ho', 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', '2019-05-30', NULL, 6),
(24, 'El Señor de los Anillos: La Comunidad del Anillo', 'Un hobbit se embarca en una búsqueda para destruir un anillo poderoso antes de que caiga en manos del mal.', 2001, 178, 'Pelicula', 'Peter Jackson', 'https://image.tmdb.org/t/p/w500/56zTpe2xvaA4alU51sRWPoKPYZy.jpg', '2001-12-19', NULL, 8),
(25, 'Pulp Fiction', 'Las vidas de dos sicarios, un boxeador, un gánster y su esposa se entrelazan en cuatro historias de violencia y redención.', 1994, 154, 'Pelicula', 'Quentin Tarantino', 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg', '1994-10-14', NULL, 6),
(26, 'Rockstar Duki desde el fin del mundo', 'Documental que sigue la vida del artista argentino Duki en los meses previos a su histórico concierto en el estadio de Vélez. Un recorrido íntimo por su carrera, desde sus inicios en El Quinto Escalón hasta convertirse en uno de los referentes del trap latino.', 2025, 90, 'Pelicula', 'Tomas Segovia', 'https://es.web.img3.acsta.net/c_310_420/img/af/0d/af0d7fb87afb7c2de5995e6a9aa6c635.jpg', '2025-10-02', NULL, 10);

-- Tabla: ContenidoActores (Relación N:M)
CREATE TABLE ContenidoActores (
    ContenidoId INT NOT NULL,
    ActorId INT NOT NULL,
    Papel VARCHAR(200) NOT NULL,
    EsProtagonista BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (ContenidoId, ActorId),
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id),
    FOREIGN KEY (ActorId) REFERENCES Actores(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar Reparto (ContenidoActores)
INSERT INTO ContenidoActores (ContenidoId, ActorId, Papel, EsProtagonista) VALUES
(1, 1, 'Dom Cobb', TRUE),
(2, 5, 'Actor de reparto', FALSE),
(3, 8, 'Red', TRUE),
(4, 12, 'Bruce Wayne / Batman', TRUE),
(5, 3, 'Forrest Gump', TRUE),
(6, 7, 'Papel secundario', FALSE),
(7, 15, 'Amelia Brand', TRUE),
(8, 1, 'Jack Dawson', TRUE),
(9, 3, 'Woody (voz)', FALSE),
(10, 2, 'Natasha Romanoff / Black Widow', TRUE),
(10, 14, 'Tony Stark / Iron Man', TRUE),
(11, 8, 'Narrador (voz)', FALSE),
(12, 9, 'Productora Ejecutiva', FALSE),
(15, 9, 'Actriz invitada', FALSE),
(21, 6, 'Mia Dolan', TRUE),
(21, 7, 'Sebastian Wilder', TRUE),
(24, 10, 'Papel secundario', FALSE),
(25, 10, 'Vincent Vega', TRUE),
(26, 16, 'Protagonista / Artista', TRUE);

-- Tabla: Valoraciones
CREATE TABLE Valoraciones (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ContenidoId INT NOT NULL,
    NombreUsuario VARCHAR(100) NOT NULL,
    Puntuacion INT NOT NULL,
    Comentario TEXT,
    FechaValoracion DATETIME NOT NULL,
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar Valoraciones
INSERT INTO Valoraciones (Id, ContenidoId, NombreUsuario, Puntuacion, Comentario, FechaValoracion) VALUES
(1, 1, 'CineFiloMX', 5, 'Una obra maestra del cine moderno. Christopher Nolan nos regala una experiencia visual y narrativa increíble.', '2023-01-15 14:30:00'),
(2, 1, 'MovieLover2023', 5, 'Inception es una película que hay que ver varias veces para apreciar todos sus detalles. Impresionante!', '2023-02-20 18:45:00'),
(3, 1, 'ReviewerPro', 4, 'Excelente película aunque un poco compleja. DiCaprio brillante como siempre.', '2023-03-10 10:15:00'),
(4, 1, 'FilmFan', 5, 'La mejor película de ciencia ficción de la última década. Soundtrack épico.', '2023-04-05 20:00:00'),
(5, 2, 'ClasicosCine', 5, 'La mejor película de la historia. Una obra de arte del cine.', '2023-01-10 12:00:00'),
(6, 2, 'CineFanatico', 5, 'Marlon Brando inolvidable. Una película que nunca envejece.', '2023-02-14 16:30:00'),
(7, 2, 'MovieBuff', 5, 'Perfección cinematográfica. Cada escena es icónica.', '2023-03-20 09:45:00'),
(8, 3, 'DramaLover', 5, 'La mejor película de todos los tiempos según IMDb y estoy de acuerdo. Emotiva y brillante.', '2023-01-25 15:20:00'),
(9, 3, 'FilmCritic', 5, 'Morgan Freeman y Tim Robbins en su mejor actuación. Una historia de esperanza inolvidable.', '2023-02-28 11:30:00'),
(10, 3, 'CineExpert', 5, 'Una obra maestra que te deja pensando días después de verla.', '2023-03-15 19:00:00'),
(11, 4, 'SuperheroFan', 5, 'La mejor película de superhéroes jamás hecha. Heath Ledger legendario como Joker.', '2023-01-18 13:45:00'),
(12, 4, 'BatmanLover', 5, 'Christopher Nolan reinventó el género de superhéroes. Oscura, intensa y perfecta.', '2023-02-22 17:15:00'),
(13, 4, 'MovieAddict', 5, 'El Joker de Heath Ledger es el mejor villano de la historia del cine.', '2023-03-30 14:30:00'),
(14, 5, 'EmotionalViewer', 5, 'Una película que te hace reír y llorar. Tom Hanks espectacular.', '2023-01-12 10:30:00'),
(15, 5, 'ClassicFan', 5, 'La vida es como una caja de bombones... Una película para ver una y otra vez.', '2023-02-17 16:45:00'),
(16, 5, 'CinemaLove', 4, 'Emotiva y entrañable. Una de las mejores de los 90.', '2023-03-25 12:00:00'),
(17, 6, 'SciFiFan', 5, 'Revolucionó el cine de acción y ciencia ficción. Efectos visuales increíbles.', '2023-01-20 14:00:00'),
(18, 6, 'TechGeek', 5, 'Adelantada a su tiempo. La escena de las balas a cámara lenta es icónica.', '2023-02-25 18:30:00'),
(19, 6, 'MovieNerd', 4, 'Gran película aunque las secuelas no estuvieron a la altura.', '2023-03-18 11:15:00'),
(20, 7, 'SpaceLover', 5, 'Nolan otra vez demostrando por qué es un genio. Visualmente impresionante.', '2023-01-22 15:45:00'),
(21, 7, 'ScienceNerd', 5, 'Una película sobre el amor, el tiempo y el espacio. La ciencia bien representada.', '2023-02-27 19:00:00'),
(22, 7, 'FilmEnthusiast', 5, 'La escena del agujero negro me dejó sin palabras. Obra maestra.', '2023-03-22 13:30:00'),
(23, 8, 'RomanticSoul', 5, 'La historia de amor más épica del cine. DiCaprio y Winslet perfectos.', '2023-01-14 16:00:00'),
(24, 8, 'ClassicLover', 5, 'Una película que marcó una generación. El corazón seguirá adelante.', '2023-02-19 20:15:00'),
(25, 8, 'MovieGoer', 4, 'Épica y emotiva, aunque un poco larga.', '2023-03-28 10:45:00'),
(26, 11, 'SeriesAddict', 5, 'La mejor serie de todos los tiempos. Walter White es un personaje inolvidable.', '2023-01-16 12:30:00'),
(27, 11, 'TVFanatic', 5, 'Cada temporada mejor que la anterior. Perfección en estado puro.', '2023-02-21 17:45:00'),
(28, 11, 'BingeFan', 5, 'No puedes dejar de ver un capítulo tras otro. Adictiva.', '2023-03-19 14:15:00'),
(29, 12, 'NetflixLover', 5, 'Nostalgia de los 80 con una historia increíble. Los niños actúan genial.', '2023-01-19 11:00:00'),
(30, 12, 'SciFiSeries', 4, 'Muy entretenida aunque la última temporada no estuvo tan buena.', '2023-02-24 15:30:00'),
(31, 12, 'TeenDrama', 5, 'Una serie que atrapa desde el primer episodio. El Upside Down es aterrador.', '2023-03-27 18:00:00'),
(32, 13, 'FantasyFan', 4, 'Épica hasta la temporada 7. El final decepcionó pero el viaje valió la pena.', '2023-01-21 13:15:00'),
(33, 13, 'SeriesKing', 5, 'Dragones, intrigas políticas y batallas épicas. Televisión de primer nivel.', '2023-02-26 19:30:00'),
(34, 13, 'WesterosLover', 3, 'Grandes primeras temporadas pero el final arruinó la serie.', '2023-03-24 16:45:00'),
(35, 15, 'StarWarsFan', 5, 'La mejor serie de Star Wars. Baby Yoda es adorable.', '2023-01-23 14:45:00'),
(36, 15, 'DisneyPlus', 5, 'This is the way. Cada episodio es como una mini película.', '2023-02-28 20:00:00'),
(37, 15, 'SciFiWatcher', 4, 'Muy buena pero esperaba más desarrollo de personajes.', '2023-03-26 12:30:00'),
(38, 21, 'MusicLover', 5, 'Una carta de amor a Los Ángeles y al cine musical. Emma Stone y Ryan Gosling brillan.', '2023-01-24 15:00:00'),
(39, 21, 'RomanticDreamer', 5, 'La escena del planetario es mágica. Damien Chazelle es un genio.', '2023-03-01 18:45:00'),
(40, 21, 'JazzFan', 4, 'Gran película y soundtrack increíble, aunque el final es agridulce.', '2023-03-29 11:00:00'),
(41, 4, 'ActionHero', 5, 'Nolan elevó las películas de superhéroes a otro nivel.', '2023-04-10 15:30:00'),
(42, 7, 'CosmicDreamer', 5, 'La banda sonora de Hans Zimmer te pone la piel de gallina.', '2023-04-12 17:00:00'),
(43, 10, 'MarvelFan', 5, 'El final perfecto para la saga del infinito. Épico en todos los sentidos.', '2023-04-15 19:30:00'),
(44, 11, 'ChemistryTeacher', 5, 'Como profesor de química, esta serie es increíblemente precisa y adictiva.', '2023-04-18 14:00:00'),
(45, 13, 'BookReader', 4, 'Los libros son mejores pero la serie tiene producción increíble.', '2023-04-20 16:15:00'),
(46, 26, 'ModoDiablo', 5, 'Increíble documental que muestra el lado humano de Duki. Muy emotivo ver su evolución desde El Quinto Escalón.', '2025-10-05 19:30:00'),
(47, 26, 'TrapArgentino', 5, 'Un antes y después en los documentales musicales argentinos. Muestra el sacrificio detrás del éxito.', '2025-10-10 21:15:00'),
(48, 26, 'FanDuki2024', 4, 'Me hizo llorar varias veces. Ver todo lo que pasó para llegar a Vélez es inspirador.', '2025-10-15 16:45:00');
