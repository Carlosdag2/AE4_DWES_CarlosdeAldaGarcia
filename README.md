# StreamFlix - Plataforma de Streaming

## Descripci�n del Proyecto
StreamFlix es una aplicaci�n web ASP.NET Core MVC que simula una plataforma de streaming tipo Netflix/HBO. Permite consultar pel�culas, series, actores, g�neros y ver estad�sticas completas del cat�logo.

**Desarrollado por:** Carlos de Alda Garc�a  
**Tecnolog�as:** ASP.NET Core 8.0, Entity Framework Core, MySQL, Bootstrap 5

---

## Estructura de la Base de Datos

La aplicaci�n utiliza **5 tablas relacionadas**:

### 1. **Generos**
- Almacena los diferentes g�neros cinematogr�ficos
- Relaci�n: **Uno a muchos** con Contenidos

### 2. **Actores**
- Informaci�n de actores y actrices
- Campos: Nombre, Apellidos, Fecha de Nacimiento, Nacionalidad, Biograf�a
- Relaci�n: **Muchos a muchos** con Contenidos (a trav�s de ContenidoActores)

### 3. **Contenidos**
- Pel�culas y series de la plataforma
- Campos: T�tulo, Descripci�n, A�o, Duraci�n, Tipo, Director, Fecha de Estreno
- Relaci�n: **Muchos a uno** con Generos
- Relaci�n: **Uno a muchos** con Valoraciones
- Relaci�n: **Muchos a muchos** con Actores

### 4. **ContenidoActores** (Tabla intermedia)
- Gestiona la relaci�n muchos a muchos entre Contenidos y Actores
- Campos adicionales: Papel (nombre del personaje), EsProtagonista
- Clave primaria compuesta: (ContenidoId, ActorId)

### 5. **Valoraciones**
- Rese�as y puntuaciones de usuarios
- Campos: NombreUsuario, Puntuaci�n (1-5), Comentario, Fecha
- Relaci�n: **Muchos a uno** con Contenidos

---

## Diagrama de Relaciones

```
Generos (1) ----< (N) Contenidos (N) >----< (N) Actores
                         |
                         |
                        (1)
                         |
                        (N)
                    Valoraciones

Tabla intermedia: ContenidoActores (con campos adicionales)
```

---

## Funcionalidades Implementadas

### ?? P�gina Principal
- Muestra contenidos destacados recientes
- Accesos r�pidos a las diferentes secciones
- Dise�o atractivo tipo Netflix

### ?? Contenidos
- **Listado completo** con filtros por tipo (Pel�cula/Serie) y g�nero
- **B�squeda avanzada** por t�tulo, director o descripci�n
- **Vista detallada** de cada contenido con:
  - Informaci�n completa
  - Reparto con actores
  - Valoraciones de usuarios
  - Promedio de puntuaci�n con estrellas

### ?? Actores
- Listado de todos los actores
- **B�squeda** por nombre, apellidos o nacionalidad
- **Filmograf�a completa** de cada actor
- Informaci�n personal y biograf�a

### ??? G�neros
- Cat�logo de g�neros disponibles
- Vista de todos los contenidos por g�nero
- Estad�sticas por g�nero

### ?? Estad�sticas (P�gina de an�lisis con LINQ)
- **Contadores:** Total de contenidos, pel�culas, series, actores, g�neros y valoraciones
- **Top 5 Mejor Valorados:** Contenidos con mejor puntuaci�n promedio
- **G�neros Populares:** Los 5 g�neros con m�s contenidos
- **Actores Destacados:** Los 5 actores con m�s producciones
- **Lanzamientos Recientes:** Los �ltimos 5 contenidos a�adidos
- **Distribuci�n por A�o:** Gr�fico de barras con contenidos por a�o
- **Promedio de Valoraci�n General:** Calculado con LINQ

---

## Requisitos del Sistema

- **.NET 8.0 SDK** o superior
- **MySQL Server** (XAMPP, WampServer o MySQL instalado)
- **Visual Studio 2022** o **Visual Studio Code**
- **Navegador web moderno** (Chrome, Edge, Firefox)

---

## Instrucciones de Instalaci�n

### 1. Configurar la Base de Datos

1. Inicia **MySQL** (desde XAMPP, WampServer o directamente)
2. Abre **phpMyAdmin** o cualquier cliente MySQL
3. Ejecuta el script SQL ubicado en:
   ```
   Database/StreamingDB.sql
   ```
4. Esto crear� la base de datos `StreamingDB` con todas las tablas y datos de ejemplo

### 2. Configurar la Conexi�n

1. Abre el archivo `appsettings.json`
2. Verifica la cadena de conexi�n:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=StreamingDB;User=root;Password=;"
   }
   ```
3. **Ajusta** el usuario y contrase�a seg�n tu configuraci�n de MySQL

### 3. Restaurar Paquetes NuGet

Abre una terminal en la carpeta del proyecto y ejecuta:
```bash
dotnet restore
```

### 4. Ejecutar la Aplicaci�n

```bash
dotnet run
```

O desde Visual Studio: presiona **F5** o **Ctrl+F5**

### 5. Acceder a la Aplicaci�n

Abre tu navegador en:
```
https://localhost:7xxx
```
(El puerto se mostrar� en la consola al ejecutar)

---

## Paquetes NuGet Utilizados

- **Pomelo.EntityFrameworkCore.MySql** (v9.0.0) - Proveedor de Entity Framework para MySQL
- **Microsoft.EntityFrameworkCore** - ORM para acceso a datos
- **Bootstrap 5** - Framework CSS (incluido por CDN)
- **Bootstrap Icons** - Iconos (incluido por CDN)

---

## Caracter�sticas Destacadas

### ? Vistas Tipadas (@model)
Todas las vistas utilizan modelos tipados para un acceso seguro a los datos

### ? Relaciones Complejas
- **Uno a muchos:** Genero ? Contenidos, Contenido ? Valoraciones
- **Muchos a muchos:** Contenidos ? Actores (con tabla intermedia personalizada)

### ? Consultas LINQ Avanzadas
- Filtrado din�mico
- Ordenamiento
- Agregaciones (Count, Average, Sum)
- Agrupaciones (GroupBy)
- Includes para cargar relaciones

### ? Dise�o Responsive
- Funciona perfectamente en m�viles, tablets y escritorio
- Uso de Bootstrap 5 Grid System

### ? B�squedas y Filtros
- B�squeda textual con `.Contains()`
- Filtros m�ltiples combinados
- Resultados din�micos

---

## Datos de Ejemplo

La base de datos incluye:
- **10 g�neros** cinematogr�ficos
- **15 actores** reconocidos
- **25 contenidos** (pel�culas y series famosas)
- **15+ relaciones** actor-contenido
- **30+ valoraciones** de usuarios

---

## Estructura del Proyecto

```
AE4_DWES_CarlosdeAldaGarcia/
??? Controllers/
?   ??? HomeController.cs
?   ??? ContenidosController.cs
?   ??? ActoresController.cs
?   ??? GenerosController.cs
?   ??? EstadisticasController.cs
??? Models/
?   ??? Genero.cs
?   ??? Actor.cs
?   ??? Contenido.cs
?   ??? ContenidoActor.cs
?   ??? Valoracion.cs
?   ??? ErrorViewModel.cs
??? Data/
?   ??? StreamingContext.cs
??? Views/
?   ??? Home/
?   ??? Contenidos/
?   ??? Actores/
?   ??? Generos/
?   ??? Estadisticas/
?   ??? Shared/
??? Database/
?   ??? StreamingDB.sql
??? appsettings.json
```

---

## Gu�a para la Exposici�n

### 1. Introducci�n (2 min)
- Presentar el proyecto: "StreamFlix - Plataforma de Streaming"
- Explicar el objetivo: Sistema de consulta de pel�culas y series

### 2. Base de Datos (3 min)
- Mostrar las **5 tablas** y sus relaciones:
  - Generos, Actores, Contenidos, ContenidoActores, Valoraciones
- Explicar la relaci�n **muchos a muchos** con tabla intermedia
- Mencionar la cantidad de datos cargados

### 3. Demostraci�n (5 min)
- **P�gina principal:** Contenidos destacados
- **Cat�logo de contenidos:** Filtros y b�squeda
- **Detalle de contenido:** Informaci�n completa con actores y valoraciones
- **Actores:** Filmograf�a completa
- **G�neros:** Contenidos por categor�a
- **Estad�sticas:** Mostrar las consultas LINQ agregadas

### 4. C�digo (3 min)
- Mostrar un modelo (ej: `Contenido.cs`) con sus relaciones
- Mostrar el `StreamingContext.cs` con la configuraci�n de Entity Framework
- Mostrar una consulta LINQ en un controlador (ej: estad�sticas)
- Mostrar una vista tipada (ej: `Details.cshtml`)

### 5. Conclusi�n (1 min)
- Resumen de tecnolog�as utilizadas
- Retos superados
- Posibles mejoras futuras

---

## Posibles Mejoras Futuras

- ? Sistema de autenticaci�n de usuarios
- ? Agregar, editar y eliminar contenidos (CRUD completo)
- ? Sistema de favoritos por usuario
- ? Integraci�n de trailers de YouTube
- ? API REST para consumo externo
- ? Paginaci�n en los listados
- ? M�s filtros avanzados (rango de a�os, duraci�n, etc.)

---

## Consultas LINQ Destacadas

### Contenidos mejor valorados
```csharp
var mejores = await _context.Contenidos
    .Include(c => c.Valoraciones)
    .Where(c => c.Valoraciones.Any())
    .OrderByDescending(c => c.Valoraciones.Average(v => v.Puntuacion))
    .Take(5)
    .ToListAsync();
```

### Distribuci�n por a�o
```csharp
var distribucion = await _context.Contenidos
    .GroupBy(c => c.Anio)
    .Select(g => new { Anio = g.Key, Cantidad = g.Count() })
    .OrderByDescending(x => x.Anio)
    .Take(10)
    .ToDictionaryAsync(x => x.Anio, x => x.Cantidad);
```

---

## Soporte y Contacto

**Desarrollador:** Carlos de Alda Garc�a  
**Proyecto:** AE4 - DWES  
**Framework:** ASP.NET Core 8.0 MVC

---

## Licencia

Este proyecto es un trabajo acad�mico desarrollado para la asignatura de Desarrollo Web en Entorno Servidor.

---

**�Disfruta explorando StreamFlix! ????**
