# ?? Diagrama de la Base de Datos - StreamFlix

## Estructura Visual de las Tablas

```
???????????????????????????????????????????????????????????????????????????????
?                         SISTEMA STREAMFLIX                                   ?
?                    Base de Datos: StreamingDB                                ?
???????????????????????????????????????????????????????????????????????????????

????????????????????
?     GENEROS      ? 1
???????????????????? ?
? PK Id (int)      ? ?
?    Nombre        ? ?
?    Descripcion   ? ?
???????????????????? ?
                     ? 1:N
                     ?
???????????????????? ?
?   CONTENIDOS     ? N
????????????????????
? PK Id (int)      ?
?    Titulo        ?????????????????
?    Descripcion   ?               ?
?    Anio          ?               ?
?    Duracion      ?               ? 1:N
?    Tipo (enum)   ?               ?
?    Director      ?               ?
?    FechaEstreno  ?               ?
?    NumTemporadas ?               ?
? FK GeneroId      ?????????????????
????????????????????
        ? 1                    ? N
        ?                      ?
        ? N:M                  ? 1:N
        ?                      ?
        ?                      ?
????????????????????    ????????????????????
? CONTENIDOACTORES ?    ?   VALORACIONES   ?
????????????????????    ????????????????????
? PK ContenidoId   ?    ? PK Id (int)      ?
? PK ActorId       ?    ? FK ContenidoId   ?
?    Papel         ?    ?    NombreUsuario ?
?    EsProtagonista?    ?    Puntuacion    ?
????????????????????    ?    Comentario    ?
        ?               ?    FechaValoracion?
        ?               ????????????????????
        ? N
        ?
        ? N:M
???????????????????? N
?     ACTORES      ?
????????????????????
? PK Id (int)      ?
?    Nombre        ?
?    Apellidos     ?
?    FechaNacimiento?
?    Nacionalidad  ?
?    Biografia     ?
????????????????????
```

---

## Relaciones Detalladas

### 1?? **Generos ? Contenidos** (1:N)
- **Tipo:** Uno a Muchos
- **Explicaci�n:** Un g�nero puede tener muchos contenidos, pero cada contenido pertenece a un solo g�nero
- **Ejemplo:** El g�nero "Acci�n" tiene m�ltiples pel�culas como "Avengers", "Matrix", etc.

### 2?? **Contenidos ? Actores** (N:M)
- **Tipo:** Muchos a Muchos
- **Tabla Intermedia:** ContenidoActores
- **Explicaci�n:** Un contenido puede tener muchos actores, y un actor puede estar en muchos contenidos
- **Campos Adicionales:** 
  - `Papel`: Nombre del personaje que interpreta
  - `EsProtagonista`: Indica si es el actor principal
- **Ejemplo:** Leonardo DiCaprio est� en "Inception" y "Titanic"

### 3?? **Contenidos ? Valoraciones** (1:N)
- **Tipo:** Uno a Muchos
- **Explicaci�n:** Un contenido puede tener muchas valoraciones de diferentes usuarios
- **Ejemplo:** "Breaking Bad" tiene 3 valoraciones de usuarios distintos

---

## Definici�n de Tablas

### ?? Tabla: GENEROS

| Campo       | Tipo         | Restricciones |
|-------------|--------------|---------------|
| Id          | INT          | PK, AUTO_INCREMENT |
| Nombre      | VARCHAR(100) | NOT NULL |
| Descripcion | TEXT         | NOT NULL |

**Registros:** 10 g�neros (Acci�n, Drama, Comedia, Ciencia Ficci�n, Terror, Thriller, Romance, Fantas�a, Animaci�n, Documental)

---

### ?? Tabla: ACTORES

| Campo          | Tipo         | Restricciones |
|----------------|--------------|---------------|
| Id             | INT          | PK, AUTO_INCREMENT |
| Nombre         | VARCHAR(100) | NOT NULL |
| Apellidos      | VARCHAR(100) | NOT NULL |
| FechaNacimiento| DATE         | NOT NULL |
| Nacionalidad   | VARCHAR(100) | NOT NULL |
| Biografia      | TEXT         | NULL |

**Registros:** 15 actores reconocidos internacionalmente

---

### ?? Tabla: CONTENIDOS

| Campo          | Tipo         | Restricciones |
|----------------|--------------|---------------|
| Id             | INT          | PK, AUTO_INCREMENT |
| Titulo         | VARCHAR(200) | NOT NULL |
| Descripcion    | TEXT         | NOT NULL |
| Anio           | INT          | NOT NULL |
| Duracion       | INT          | NOT NULL (minutos) |
| Tipo           | VARCHAR(50)  | NOT NULL (Pelicula/Serie) |
| Director       | VARCHAR(150) | NOT NULL |
| Poster         | VARCHAR(255) | NULL |
| FechaEstreno   | DATE         | NOT NULL |
| NumTemporadas  | INT          | NULL (solo para series) |
| GeneroId       | INT          | FK ? Generos(Id) |

**Registros:** 25 contenidos (pel�culas y series famosas)

---

### ?? Tabla: CONTENIDOACTORES (Intermedia)

| Campo          | Tipo         | Restricciones |
|----------------|--------------|---------------|
| ContenidoId    | INT          | PK, FK ? Contenidos(Id) |
| ActorId        | INT          | PK, FK ? Actores(Id) |
| Papel          | VARCHAR(150) | NOT NULL |
| EsProtagonista | TINYINT(1)   | NOT NULL, DEFAULT 0 |

**Clave Primaria Compuesta:** (ContenidoId, ActorId)  
**Registros:** 15+ relaciones actor-contenido

---

### ? Tabla: VALORACIONES

| Campo          | Tipo         | Restricciones |
|----------------|--------------|---------------|
| Id             | INT          | PK, AUTO_INCREMENT |
| ContenidoId    | INT          | FK ? Contenidos(Id) |
| NombreUsuario  | VARCHAR(100) | NOT NULL |
| Puntuacion     | INT          | NOT NULL (1-5) |
| Comentario     | TEXT         | NULL |
| FechaValoracion| DATETIME     | NOT NULL |

**Registros:** 30+ valoraciones de usuarios ficticios

---

## Ejemplos de Datos

### Ejemplo de G�nero
```sql
Id: 1
Nombre: "Acci�n"
Descripcion: "Pel�culas y series llenas de adrenalina..."
```

### Ejemplo de Actor
```sql
Id: 1
Nombre: "Leonardo"
Apellidos: "DiCaprio"
FechaNacimiento: 1974-11-11
Nacionalidad: "Estadounidense"
Biografia: "Actor y productor estadounidense..."
```

### Ejemplo de Contenido
```sql
Id: 1
Titulo: "Origen"
Descripcion: "Un ladr�n que roba secretos corporativos..."
Anio: 2010
Duracion: 148
Tipo: "Pelicula"
Director: "Christopher Nolan"
FechaEstreno: 2010-07-16
GeneroId: 4 (Ciencia Ficci�n)
```

### Ejemplo de ContenidoActor
```sql
ContenidoId: 1 (Origen)
ActorId: 1 (Leonardo DiCaprio)
Papel: "Dom Cobb"
EsProtagonista: 1 (true)
```

### Ejemplo de Valoraci�n
```sql
Id: 1
ContenidoId: 1 (Origen)
NombreUsuario: "CineFiloMX"
Puntuacion: 5
Comentario: "Una obra maestra del cine moderno..."
FechaValoracion: 2023-01-15 14:30:00
```

---

## Consultas SQL de Ejemplo

### Obtener todos los contenidos de un g�nero
```sql
SELECT c.* 
FROM Contenidos c
WHERE c.GeneroId = 1;
```

### Obtener actores de una pel�cula
```sql
SELECT a.Nombre, a.Apellidos, ca.Papel, ca.EsProtagonista
FROM Actores a
JOIN ContenidoActores ca ON a.Id = ca.ActorId
WHERE ca.ContenidoId = 1;
```

### Promedio de valoraciones de un contenido
```sql
SELECT AVG(v.Puntuacion) AS Promedio
FROM Valoraciones v
WHERE v.ContenidoId = 1;
```

### Contenidos mejor valorados
```sql
SELECT c.Titulo, AVG(v.Puntuacion) AS Promedio
FROM Contenidos c
JOIN Valoraciones v ON c.Id = v.ContenidoId
GROUP BY c.Id, c.Titulo
ORDER BY Promedio DESC
LIMIT 5;
```

---

## �ndices y Optimizaciones

### �ndices Autom�ticos
- **PRIMARY KEY** en todas las tablas (Id)
- **FOREIGN KEYS** crean �ndices autom�ticamente

### �ndices Sugeridos (Futura optimizaci�n)
```sql
CREATE INDEX idx_contenidos_tipo ON Contenidos(Tipo);
CREATE INDEX idx_contenidos_anio ON Contenidos(Anio);
CREATE INDEX idx_valoraciones_puntuacion ON Valoraciones(Puntuacion);
CREATE INDEX idx_actores_nacionalidad ON Actores(Nacionalidad);
```

---

## Integridad Referencial

? **ON DELETE CASCADE** - No implementado para mantener datos hist�ricos  
? **FOREIGN KEYS** - Todas las relaciones est�n protegidas  
? **NOT NULL** - Campos obligatorios bien definidos  
? **DEFAULT VALUES** - EsProtagonista tiene valor por defecto

---

## Tama�o Estimado de la Base de Datos

| Tabla            | Registros | Tama�o Aprox. |
|------------------|-----------|---------------|
| Generos          | 10        | 2 KB          |
| Actores          | 15        | 8 KB          |
| Contenidos       | 25        | 15 KB         |
| ContenidoActores | 15+       | 3 KB          |
| Valoraciones     | 30+       | 12 KB         |
| **TOTAL**        | **95+**   | **? 40 KB**   |

---

**Nota:** Este diagrama es orientativo. La base de datos est� completamente normalizada y sigue las mejores pr�cticas de dise�o relacional.
