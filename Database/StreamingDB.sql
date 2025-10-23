-- Script SQL para crear y poblar la base de datos StreamFlix
-- Base de datos: StreamingDB
-- Sistema de Gesti�n: MySQL

-- Crear la base de datos
DROP DATABASE IF EXISTS StreamingDB;
CREATE DATABASE StreamingDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE StreamingDB;

-- Tabla Generos
CREATE TABLE Generos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT NOT NULL
);

-- Tabla Actores
CREATE TABLE Actores (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Nacionalidad VARCHAR(100) NOT NULL,
    Biografia TEXT
);

-- Tabla Contenidos
CREATE TABLE Contenidos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(200) NOT NULL,
    Descripcion TEXT NOT NULL,
    Anio INT NOT NULL,
    Duracion INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Director VARCHAR(150) NOT NULL,
    Poster VARCHAR(255),
    FechaEstreno DATE NOT NULL,
    NumeroTemporadas INT,
    GeneroId INT NOT NULL,
    FOREIGN KEY (GeneroId) REFERENCES Generos(Id)
);

-- Tabla ContenidoActores (Relaci�n muchos a muchos)
CREATE TABLE ContenidoActores (
    ContenidoId INT NOT NULL,
    ActorId INT NOT NULL,
    Papel VARCHAR(150) NOT NULL,
    EsProtagonista TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (ContenidoId, ActorId),
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id),
    FOREIGN KEY (ActorId) REFERENCES Actores(Id)
);

-- Tabla Valoraciones
CREATE TABLE Valoraciones (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ContenidoId INT NOT NULL,
    NombreUsuario VARCHAR(100) NOT NULL,
    Puntuacion INT NOT NULL,
    Comentario TEXT,
    FechaValoracion DATETIME NOT NULL,
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id)
);

-- INSERTAR DATOS DE EJEMPLO

-- Insertar G�neros
INSERT INTO Generos (Nombre, Descripcion) VALUES
('Acci�n', 'Pel�culas y series llenas de adrenalina, persecuciones y escenas de combate espectaculares.'),
('Drama', 'Historias profundas y emotivas que exploran las relaciones humanas y conflictos personales.'),
('Comedia', 'Contenido humor�stico dise�ado para entretener y hacer re�r al p�blico.'),
('Ciencia Ficci�n', 'Mundos futuristas, tecnolog�a avanzada y exploraciones del universo y la realidad.'),
('Terror', 'Historias dise�adas para asustar y crear tensi�n en el espectador.'),
('Thriller', 'Narrativas de suspense que mantienen al p�blico al borde del asiento.'),
('Romance', 'Historias de amor y relaciones rom�nticas entre personajes.'),
('Fantas�a', 'Mundos m�gicos con criaturas m�ticas y elementos sobrenaturales.'),
('Animaci�n', 'Contenido animado para todas las edades con historias creativas.'),
('Documental', 'Contenido educativo e informativo sobre temas reales.');

-- Insertar Actores
INSERT INTO Actores (Nombre, Apellidos, FechaNacimiento, Nacionalidad, Biografia) VALUES
('Leonardo', 'DiCaprio', '1974-11-11', 'Estadounidense', 'Actor y productor estadounidense ganador del Oscar, conocido por sus papeles en Titanic, Inception y The Revenant.'),
('Scarlett', 'Johansson', '1984-11-22', 'Estadounidense', 'Actriz y cantante estadounidense, reconocida por su papel como Black Widow en el universo Marvel.'),
('Tom', 'Hanks', '1956-07-09', 'Estadounidense', 'Actor legendario ganador de m�ltiples premios Oscar, conocido por Forrest Gump y Cast Away.'),
('Meryl', 'Streep', '1949-06-22', 'Estadounidense', 'Considerada una de las mejores actrices de todos los tiempos, con un r�cord de nominaciones al Oscar.'),
('Denzel', 'Washington', '1954-12-28', 'Estadounidense', 'Actor, director y productor, ganador de dos premios Oscar por su destacada carrera.'),
('Emma', 'Stone', '1988-11-06', 'Estadounidense', 'Actriz ganadora del Oscar, conocida por La La Land y Easy A.'),
('Ryan', 'Gosling', '1980-11-12', 'Canadiense', 'Actor y m�sico canadiense, reconocido por sus papeles en Drive y La La Land.'),
('Morgan', 'Freeman', '1937-06-01', 'Estadounidense', 'Actor legendario con una voz ic�nica, ganador del Oscar por Million Dollar Baby.'),
('Natalie', 'Portman', '1981-06-09', 'Estadounidense-Israel�', 'Actriz ganadora del Oscar por Black Swan, tambi�n conocida por Star Wars.'),
('Brad', 'Pitt', '1963-12-18', 'Estadounidense', 'Actor y productor ganador del Oscar, estrella de pel�culas como Fight Club y Once Upon a Time in Hollywood.'),
('Jennifer', 'Lawrence', '1990-08-15', 'Estadounidense', 'Actriz ganadora del Oscar, conocida por Los Juegos del Hambre y Silver Linings Playbook.'),
('Christian', 'Bale', '1974-01-30', 'Brit�nico', 'Actor brit�nico conocido por su transformaci�n f�sica en roles como Batman y The Machinist.'),
('Cate', 'Blanchett', '1969-05-14', 'Australiana', 'Actriz australiana ganadora de dos premios Oscar, reconocida por Elizabeth y Blue Jasmine.'),
('Robert', 'Downey Jr.', '1965-04-04', 'Estadounidense', 'Actor ic�nico conocido por su papel de Iron Man en el universo cinematogr�fico de Marvel.'),
('Anne', 'Hathaway', '1982-11-12', 'Estadounidense', 'Actriz ganadora del Oscar por Los Miserables, tambi�n conocida por El Diablo Viste a la Moda.');

-- Insertar Contenidos (Pel�culas)
INSERT INTO Contenidos (Titulo, Descripcion, Anio, Duracion, Tipo, Director, FechaEstreno, NumeroTemporadas, GeneroId) VALUES
('Origen', 'Un ladr�n que roba secretos corporativos a trav�s del uso de la tecnolog�a de compartir sue�os recibe la tarea inversa de plantar una idea en la mente de un CEO.', 
 2010, 148, 'Pelicula', 'Christopher Nolan', '2010-07-16', NULL, 4),
('El Padrino', 'La historia de una dinast�a criminal de Nueva York y c�mo el hijo menor de la familia se convierte en el nuevo jefe.', 
 1972, 175, 'Pelicula', 'Francis Ford Coppola', '1972-03-24', NULL, 2),
('Cadena Perpetua', 'Dos hombres encarcelados forjan una amistad a lo largo de varios a�os, encontrando consuelo y eventual redenci�n a trav�s de actos de decencia com�n.', 
 1994, 142, 'Pelicula', 'Frank Darabont', '1994-09-23', NULL, 2),
('El Caballero Oscuro', 'Cuando la amenaza conocida como el Joker causa estragos en Gotham, Batman debe aceptar una de las pruebas psicol�gicas y f�sicas m�s grandes.', 
 2008, 152, 'Pelicula', 'Christopher Nolan', '2008-07-18', NULL, 1),
('Forrest Gump', 'Las presidencias de Kennedy y Johnson, Vietnam, Watergate y otros eventos hist�ricos se desarrollan desde la perspectiva de un hombre de Alabama con un coeficiente intelectual de 75.', 
 1994, 142, 'Pelicula', 'Robert Zemeckis', '1994-07-06', NULL, 2),
('Matrix', 'Un hacker descubre que la realidad tal como la conoce es una simulaci�n creada por m�quinas para controlar a la humanidad.', 
 1999, 136, 'Pelicula', 'Lana y Lilly Wachowski', '1999-03-31', NULL, 4),
('Interestelar', 'Un equipo de exploradores viaja a trav�s de un agujero de gusano en el espacio en un intento de asegurar la supervivencia de la humanidad.', 
 2014, 169, 'Pelicula', 'Christopher Nolan', '2014-11-07', NULL, 4),
('Titanic', 'Una arist�crata de diecisiete a�os se enamora de un artista amable pero pobre a bordo del lujoso y desafortunado RMS Titanic.', 
 1997, 194, 'Pelicula', 'James Cameron', '1997-12-19', NULL, 7),
('El Rey Le�n', 'El pr�ncipe le�n Simba y su padre son el objetivo del t�o de Simba, que quiere ascender al trono.', 
 1994, 88, 'Pelicula', 'Roger Allers, Rob Minkoff', '1994-06-24', NULL, 9),
('Avengers: Endgame', 'Despu�s de los eventos devastadores de Infinity War, los Vengadores se re�nen una vez m�s para deshacer las acciones de Thanos.', 
 2019, 181, 'Pelicula', 'Anthony y Joe Russo', '2019-04-26', NULL, 1);

-- Insertar Contenidos (Series)
INSERT INTO Contenidos (Titulo, Descripcion, Anio, Duracion, Tipo, Director, FechaEstreno, NumeroTemporadas, GeneroId) VALUES
('Breaking Bad', 'Un profesor de qu�mica de secundaria diagnosticado con c�ncer de pulm�n se asocia con un exalumno para fabricar y vender metanfetamina.', 
 2008, 47, 'Serie', 'Vince Gilligan', '2008-01-20', 5, 2),
('Stranger Things', 'Cuando un ni�o desaparece, su madre, un jefe de polic�a y sus amigos deben enfrentarse a fuerzas extraordinarias para recuperarlo.', 
 2016, 51, 'Serie', 'Matt y Ross Duffer', '2016-07-15', 4, 4),
('Game of Thrones', 'Nueve familias nobles luchan por el control de las tierras de Westeros, mientras un antiguo enemigo regresa despu�s de estar dormido durante miles de a�os.', 
 2011, 57, 'Serie', 'David Benioff, D.B. Weiss', '2011-04-17', 8, 8),
('The Crown', 'Sigue la vida pol�tica de la reina Isabel II y los eventos que dieron forma a la segunda mitad del siglo XX.', 
 2016, 58, 'Serie', 'Peter Morgan', '2016-11-04', 6, 2),
('The Mandalorian', 'Las aventuras de un cazarrecompensas solitario en los confines de la galaxia, lejos de la autoridad de la Nueva Rep�blica.', 
 2019, 40, 'Serie', 'Jon Favreau', '2019-11-12', 3, 4),
('The Office', 'Una mirada documental a la vida cotidiana de los empleados de la sucursal de Scranton de Dunder Mifflin Paper Company.', 
 2005, 22, 'Serie', 'Greg Daniels', '2005-03-24', 9, 3),
('Dark', 'Un ni�o desaparecido lleva a cuatro familias en una b�squeda fren�tica de respuestas mientras desentra�an una conspiraci�n que abarca tres generaciones.', 
 2017, 60, 'Serie', 'Baran bo Odar', '2017-12-01', 3, 6),
('The Witcher', 'Geralt de Rivia, un cazador de monstruos solitario, lucha por encontrar su lugar en un mundo donde las personas a menudo son m�s malvadas que las bestias.', 
 2019, 60, 'Serie', 'Lauren Schmidt Hissrich', '2019-12-20', 3, 8),
('Black Mirror', 'Una antolog�a que explora un futuro retorcido y de alta tecnolog�a donde los mayores innovaciones y los instintos m�s oscuros de la humanidad chocan.', 
 2011, 60, 'Serie', 'Charlie Brooker', '2011-12-04', 6, 4),
('Friends', 'Sigue la vida personal y profesional de seis amigos veintea�eros viviendo en Manhattan.', 
 1994, 22, 'Serie', 'David Crane, Marta Kauffman', '1994-09-22', 10, 3);

-- Insertar relaciones ContenidoActores
INSERT INTO ContenidoActores (ContenidoId, ActorId, Papel, EsProtagonista) VALUES
-- Origen
(1, 1, 'Dom Cobb', 1),
-- El Caballero Oscuro
(4, 12, 'Bruce Wayne / Batman', 1),
-- Forrest Gump
(5, 3, 'Forrest Gump', 1),
-- Interestelar
(7, 15, 'Amelia Brand', 1),
-- Titanic
(8, 1, 'Jack Dawson', 1),
-- Avengers: Endgame
(10, 14, 'Tony Stark / Iron Man', 1),
(10, 2, 'Natasha Romanoff / Black Widow', 1),
-- Breaking Bad
(11, 8, 'Narrador (voz)', 0),
-- Stranger Things
(12, 9, 'Productora Ejecutiva', 0),
-- The Mandalorian
(15, 9, 'Actriz invitada', 0),
-- Cadena Perpetua
(3, 8, 'Red', 1),
-- El Padrino
(2, 5, 'Actor de reparto', 0),
-- Matrix
(6, 7, 'Papel secundario', 0),
-- La La Land (a�adiremos m�s contenido)
-- El Rey Le�n
(9, 3, 'Woody (voz)', 0);

-- A�adir m�s contenidos
INSERT INTO Contenidos (Titulo, Descripcion, Anio, Duracion, Tipo, Director, FechaEstreno, NumeroTemporadas, GeneroId) VALUES
('La La Land', 'Un pianista de jazz y una aspirante a actriz se enamoran mientras intentan conciliar sus aspiraciones para el futuro.', 
 2016, 128, 'Pelicula', 'Damien Chazelle', '2016-12-09', NULL, 7),
('Joker', 'En Gotham City, Arthur Fleck, un comediante fracasado, se sumerge en la locura y se convierte en un asesino psic�pata.', 
 2019, 122, 'Pelicula', 'Todd Phillips', '2019-10-04', NULL, 2),
('Par�sitos', 'La codicia y la discriminaci�n de clases amenazan la relaci�n simbi�tica reci�n formada entre la rica familia Park y el clan indigente Kim.', 
 2019, 132, 'Pelicula', 'Bong Joon-ho', '2019-05-30', NULL, 6),
('El Se�or de los Anillos: La Comunidad del Anillo', 'Un hobbit se embarca en una b�squeda para destruir un anillo poderoso antes de que caiga en manos del mal.', 
 2001, 178, 'Pelicula', 'Peter Jackson', '2001-12-19', NULL, 8),
('Pulp Fiction', 'Las vidas de dos sicarios, un boxeador, un g�nster y su esposa se entrelazan en cuatro historias de violencia y redenci�n.', 
 1994, 154, 'Pelicula', 'Quentin Tarantino', '1994-10-14', NULL, 6);

-- M�s relaciones de actores
INSERT INTO ContenidoActores (ContenidoId, ActorId, Papel, EsProtagonista) VALUES
(21, 6, 'Mia Dolan', 1),
(21, 7, 'Sebastian Wilder', 1),
(24, 10, 'Papel secundario', 0),
(25, 10, 'Vincent Vega', 1);

-- Insertar Valoraciones
INSERT INTO Valoraciones (ContenidoId, NombreUsuario, Puntuacion, Comentario, FechaValoracion) VALUES
-- Origen
(1, 'CineFiloMX', 5, 'Una obra maestra del cine moderno. Christopher Nolan nos regala una experiencia visual y narrativa incre�ble.', '2023-01-15 14:30:00'),
(1, 'MovieLover2023', 5, 'Inception es una pel�cula que hay que ver varias veces para apreciar todos sus detalles. Impresionante!', '2023-02-20 18:45:00'),
(1, 'ReviewerPro', 4, 'Excelente pel�cula aunque un poco compleja. DiCaprio brillante como siempre.', '2023-03-10 10:15:00'),
(1, 'FilmFan', 5, 'La mejor pel�cula de ciencia ficci�n de la �ltima d�cada. Soundtrack �pico.', '2023-04-05 20:00:00'),

-- El Padrino
(2, 'ClasicosCine', 5, 'La mejor pel�cula de la historia. Una obra de arte del cine.', '2023-01-10 12:00:00'),
(2, 'CineFanatico', 5, 'Marlon Brando inolvidable. Una pel�cula que nunca envejece.', '2023-02-14 16:30:00'),
(2, 'MovieBuff', 5, 'Perfecci�n cinematogr�fica. Cada escena es ic�nica.', '2023-03-20 09:45:00'),

-- Cadena Perpetua
(3, 'DramaLover', 5, 'La mejor pel�cula de todos los tiempos seg�n IMDb y estoy de acuerdo. Emotiva y brillante.', '2023-01-25 15:20:00'),
(3, 'FilmCritic', 5, 'Morgan Freeman y Tim Robbins en su mejor actuaci�n. Una historia de esperanza inolvidable.', '2023-02-28 11:30:00'),
(3, 'CineExpert', 5, 'Una obra maestra que te deja pensando d�as despu�s de verla.', '2023-03-15 19:00:00'),

-- El Caballero Oscuro
(4, 'SuperheroFan', 5, 'La mejor pel�cula de superh�roes jam�s hecha. Heath Ledger legendario como Joker.', '2023-01-18 13:45:00'),
(4, 'BatmanLover', 5, 'Christopher Nolan reinvent� el g�nero de superh�roes. Oscura, intensa y perfecta.', '2023-02-22 17:15:00'),
(4, 'MovieAddict', 5, 'El Joker de Heath Ledger es el mejor villano de la historia del cine.', '2023-03-30 14:30:00'),

-- Forrest Gump
(5, 'EmotionalViewer', 5, 'Una pel�cula que te hace re�r y llorar. Tom Hanks espectacular.', '2023-01-12 10:30:00'),
(5, 'ClassicFan', 5, 'La vida es como una caja de bombones... Una pel�cula para ver una y otra vez.', '2023-02-17 16:45:00'),
(5, 'CinemaLove', 4, 'Emotiva y entra�able. Una de las mejores de los 90.', '2023-03-25 12:00:00'),

-- Matrix
(6, 'SciFiFan', 5, 'Revolucion� el cine de acci�n y ciencia ficci�n. Efectos visuales incre�bles.', '2023-01-20 14:00:00'),
(6, 'TechGeek', 5, 'Adelantada a su tiempo. La escena de las balas a c�mara lenta es ic�nica.', '2023-02-25 18:30:00'),
(6, 'MovieNerd', 4, 'Gran pel�cula aunque las secuelas no estuvieron a la altura.', '2023-03-18 11:15:00'),

-- Interestelar
(7, 'SpaceLover', 5, 'Nolan otra vez demostrando por qu� es un genio. Visualmente impresionante.', '2023-01-22 15:45:00'),
(7, 'ScienceNerd', 5, 'Una pel�cula sobre el amor, el tiempo y el espacio. La ciencia bien representada.', '2023-02-27 19:00:00'),
(7, 'FilmEnthusiast', 5, 'La escena del agujero negro me dej� sin palabras. Obra maestra.', '2023-03-22 13:30:00'),

-- Titanic
(8, 'RomanticSoul', 5, 'La historia de amor m�s �pica del cine. DiCaprio y Winslet perfectos.', '2023-01-14 16:00:00'),
(8, 'ClassicLover', 5, 'Una pel�cula que marc� una generaci�n. El coraz�n seguir� adelante.', '2023-02-19 20:15:00'),
(8, 'MovieGoer', 4, '�pica y emotiva, aunque un poco larga.', '2023-03-28 10:45:00'),

-- Breaking Bad
(11, 'SeriesAddict', 5, 'La mejor serie de todos los tiempos. Walter White es un personaje inolvidable.', '2023-01-16 12:30:00'),
(11, 'TVFanatic', 5, 'Cada temporada mejor que la anterior. Perfecci�n en estado puro.', '2023-02-21 17:45:00'),
(11, 'BingeFan', 5, 'No puedes dejar de ver un cap�tulo tras otro. Adictiva.', '2023-03-19 14:15:00'),

-- Stranger Things
(12, 'NetflixLover', 5, 'Nostalgia de los 80 con una historia incre�ble. Los ni�os act�an genial.', '2023-01-19 11:00:00'),
(12, 'SciFiSeries', 4, 'Muy entretenida aunque la �ltima temporada no estuvo tan buena.', '2023-02-24 15:30:00'),
(12, 'TeenDrama', 5, 'Una serie que atrapa desde el primer episodio. El Upside Down es aterrador.', '2023-03-27 18:00:00'),

-- Game of Thrones
(13, 'FantasyFan', 4, '�pica hasta la temporada 7. El final decepcion� pero el viaje vali� la pena.', '2023-01-21 13:15:00'),
(13, 'SeriesKing', 5, 'Dragones, intrigas pol�ticas y batallas �picas. Televisi�n de primer nivel.', '2023-02-26 19:30:00'),
(13, 'WesterosLover', 3, 'Grandes primeras temporadas pero el final arruin� la serie.', '2023-03-24 16:45:00'),

-- The Mandalorian
(15, 'StarWarsFan', 5, 'La mejor serie de Star Wars. Baby Yoda es adorable.', '2023-01-23 14:45:00'),
(15, 'DisneyPlus', 5, 'This is the way. Cada episodio es como una mini pel�cula.', '2023-02-28 20:00:00'),
(15, 'SciFiWatcher', 4, 'Muy buena pero esperaba m�s desarrollo de personajes.', '2023-03-26 12:30:00'),

-- La La Land
(21, 'MusicLover', 5, 'Una carta de amor a Los �ngeles y al cine musical. Emma Stone y Ryan Gosling brillan.', '2023-01-24 15:00:00'),
(21, 'RomanticDreamer', 5, 'La escena del planetario es m�gica. Damien Chazelle es un genio.', '2023-03-01 18:45:00'),
(21, 'JazzFan', 4, 'Gran pel�cula y soundtrack incre�ble, aunque el final es agridulce.', '2023-03-29 11:00:00'),

-- A�adir m�s valoraciones para otros contenidos
(4, 'ActionHero', 5, 'Nolan elev� las pel�culas de superh�roes a otro nivel.', '2023-04-10 15:30:00'),
(7, 'CosmicDreamer', 5, 'La banda sonora de Hans Zimmer te pone la piel de gallina.', '2023-04-12 17:00:00'),
(10, 'MarvelFan', 5, 'El final perfecto para la saga del infinito. �pico en todos los sentidos.', '2023-04-15 19:30:00'),
(11, 'ChemistryTeacher', 5, 'Como profesor de qu�mica, esta serie es incre�blemente precisa y adictiva.', '2023-04-18 14:00:00'),
(13, 'BookReader', 4, 'Los libros son mejores pero la serie tiene producci�n incre�ble.', '2023-04-20 16:15:00');

-- Verificar datos insertados
SELECT 'G�neros insertados:' AS Info, COUNT(*) AS Total FROM Generos
UNION ALL
SELECT 'Actores insertados:', COUNT(*) FROM Actores
UNION ALL
SELECT 'Contenidos insertados:', COUNT(*) FROM Contenidos
UNION ALL
SELECT 'Relaciones Contenido-Actor:', COUNT(*) FROM ContenidoActores
UNION ALL
SELECT 'Valoraciones insertadas:', COUNT(*) FROM Valoraciones;
