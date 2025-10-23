# StreamFlix - Plataforma de Streaming

## Descripción del Proyecto
StreamFlix es una aplicación web ASP.NET Core MVC que simula una plataforma de streaming tipo Netflix/HBO. Permite consultar películas, series, actores, géneros y ver estadísticas completas del catálogo.

**Desarrollado por:** Carlos de Alda García  
**Tecnologías:** ASP.NET Core 8.0, Entity Framework Core, MySQL, Bootstrap 5

---

## Estructura de la Base de Datos

La aplicación utiliza **5 tablas relacionadas**:

### 1. **Generos**
- Almacena los diferentes géneros cinematográficos
- Relación: **Uno a muchos** con Contenidos

### 2. **Actores**
- Información de actores y actrices
- Campos: Nombre, Apellidos, Fecha de Nacimiento, Nacionalidad, Biografía
- Relación: **Muchos a muchos** con Contenidos (a través de ContenidoActores)

### 3. **Contenidos**
- Películas y series de la plataforma
- Campos: Título, Descripción, Año, Duración, Tipo, Director, Fecha de Estreno
- Relación: **Muchos a uno** con Generos
- Relación: **Uno a muchos** con Valoraciones
- Relación: **Muchos a muchos** con Actores

### 4. **ContenidoActores** (Tabla intermedia)
- Gestiona la relación muchos a muchos entre Contenidos y Actores
- Campos adicionales: Papel (nombre del personaje), EsProtagonista
- Clave primaria compuesta: (ContenidoId, ActorId)

### 5. **Valoraciones**
- Reseñas y puntuaciones de usuarios
- Campos: NombreUsuario, Puntuación (1-5), Comentario, Fecha
- Relación: **Muchos a uno** con Contenidos

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

### ?? Página Principal
- Muestra contenidos destacados recientes
- Accesos rápidos a las diferentes secciones
- Diseño atractivo tipo Netflix

### ?? Contenidos
- **Listado completo** con filtros por tipo (Película/Serie) y género
- **Búsqueda avanzada** por título, director o descripción
- **Vista detallada** de cada contenido con:
  - Información completa
  - Reparto con actores
  - Valoraciones de usuarios
  - Promedio de puntuación con estrellas

### ?? Actores
- Listado de todos los actores
- **Búsqueda** por nombre, apellidos o nacionalidad
- **Filmografía completa** de cada actor
- Información personal y biografía

### ??? Géneros
- Catálogo de géneros disponibles
- Vista de todos los contenidos por género
- Estadísticas por género

### ?? Estadísticas (Página de análisis con LINQ)
- **Contadores:** Total de contenidos, películas, series, actores, géneros y valoraciones
- **Top 5 Mejor Valorados:** Contenidos con mejor puntuación promedio
- **Géneros Populares:** Los 5 géneros con más contenidos
- **Actores Destacados:** Los 5 actores con más producciones
- **Lanzamientos Recientes:** Los últimos 5 contenidos añadidos
- **Distribución por Año:** Gráfico de barras con contenidos por año
- **Promedio de Valoración General:** Calculado con LINQ

---

## Requisitos del Sistema

- **.NET 8.0 SDK** o superior
- **MySQL Server** (XAMPP, WampServer o MySQL instalado)
- **Visual Studio 2022** o **Visual Studio Code**
- **Navegador web moderno** (Chrome, Edge, Firefox)

---

## Instrucciones de Instalación

### 1. Configurar la Base de Datos

1. Inicia **MySQL** (desde XAMPP, WampServer o directamente)
2. Abre **phpMyAdmin** o cualquier cliente MySQL
3. Ejecuta el script SQL ubicado en:
   ```
   Database/StreamingDB.sql
   ```
4. Esto creará la base de datos `StreamingDB` con todas las tablas y datos de ejemplo

### 2. Configurar la Conexión

1. Abre el archivo `appsettings.json`
2. Verifica la cadena de conexión:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=StreamingDB;User=root;Password=;"
   }
   ```
3. **Ajusta** el usuario y contraseña según tu configuración de MySQL

### 3. Restaurar Paquetes NuGet

Abre una terminal en la carpeta del proyecto y ejecuta:
```bash
dotnet restore
```

### 4. Ejecutar la Aplicación

```bash
dotnet run
```

O desde Visual Studio: presiona **F5** o **Ctrl+F5**

### 5. Acceder a la Aplicación

Abre tu navegador en:
```
https://localhost:7xxx
```
(El puerto se mostrará en la consola al ejecutar)

---

## Paquetes NuGet Utilizados

- **Pomelo.EntityFrameworkCore.MySql** (v9.0.0) - Proveedor de Entity Framework para MySQL
- **Microsoft.EntityFrameworkCore** - ORM para acceso a datos
- **Bootstrap 5** - Framework CSS (incluido por CDN)
- **Bootstrap Icons** - Iconos (incluido por CDN)

---

## Características Destacadas

### ? Vistas Tipadas (@model)
Todas las vistas utilizan modelos tipados para un acceso seguro a los datos

### ? Relaciones Complejas
- **Uno a muchos:** Genero ? Contenidos, Contenido ? Valoraciones
- **Muchos a muchos:** Contenidos ? Actores (con tabla intermedia personalizada)

### ? Consultas LINQ Avanzadas
- Filtrado dinámico
- Ordenamiento
- Agregaciones (Count, Average, Sum)
- Agrupaciones (GroupBy)
- Includes para cargar relaciones

### ? Diseño Responsive
- Funciona perfectamente en móviles, tablets y escritorio
- Uso de Bootstrap 5 Grid System

### ? Búsquedas y Filtros
- Búsqueda textual con `.Contains()`
- Filtros múltiples combinados
- Resultados dinámicos

---

## Datos de Ejemplo

La base de datos incluye:
- **10 géneros** cinematográficos
- **15 actores** reconocidos
- **25 contenidos** (películas y series famosas)
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

## Guía para la Exposición

### 1. Introducción (2 min)
- Presentar el proyecto: "StreamFlix - Plataforma de Streaming"
- Explicar el objetivo: Sistema de consulta de películas y series

### 2. Base de Datos (3 min)
- Mostrar las **5 tablas** y sus relaciones:
  - Generos, Actores, Contenidos, ContenidoActores, Valoraciones
- Explicar la relación **muchos a muchos** con tabla intermedia
- Mencionar la cantidad de datos cargados

### 3. Demostración (5 min)
- **Página principal:** Contenidos destacados
- **Catálogo de contenidos:** Filtros y búsqueda
- **Detalle de contenido:** Información completa con actores y valoraciones
- **Actores:** Filmografía completa
- **Géneros:** Contenidos por categoría
- **Estadísticas:** Mostrar las consultas LINQ agregadas

### 4. Código (3 min)
- Mostrar un modelo (ej: `Contenido.cs`) con sus relaciones
- Mostrar el `StreamingContext.cs` con la configuración de Entity Framework
- Mostrar una consulta LINQ en un controlador (ej: estadísticas)
- Mostrar una vista tipada (ej: `Details.cshtml`)

### 5. Conclusión (1 min)
- Resumen de tecnologías utilizadas
- Retos superados
- Posibles mejoras futuras

---

## Posibles Mejoras Futuras

- ? Sistema de autenticación de usuarios
- ? Agregar, editar y eliminar contenidos (CRUD completo)
- ? Sistema de favoritos por usuario
- ? Integración de trailers de YouTube
- ? API REST para consumo externo
- ? Paginación en los listados
- ? Más filtros avanzados (rango de años, duración, etc.)

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

### Distribución por año
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

**Desarrollador:** Carlos de Alda García  
**Proyecto:** AE4 - DWES  
**Framework:** ASP.NET Core 8.0 MVC

---

## Licencia

Este proyecto es un trabajo académico desarrollado para la asignatura de Desarrollo Web en Entorno Servidor.

---

**¡Disfruta explorando StreamFlix! ????**
