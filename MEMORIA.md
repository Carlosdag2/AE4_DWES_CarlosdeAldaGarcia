# MEMORIA DEL PROYECTO
## Aplicación de Gestión de Plataforma de Streaming

---

**Autor:** Carlos de Alda García  
**Fecha:** 24 de octubre 2025  
**Asignatura:** Desarrollo Web en Entorno Servidor (DWES)  
**Actividad Evaluable:** AE4

---

## ÍNDICE

1. [Introducción](#1-introducción)
2. [Análisis de Tecnologías para Acceso a Datos en .NET](#2-análisis-de-tecnologías-para-acceso-a-datos-en-net)
   - 2.1. [ADO.NET](#21-adonet)
   - 2.2. [Entity Framework Core](#22-entity-framework-core)
   - 2.3. [Dapper](#23-dapper)
   - 2.4. [Comparativa y Elección](#24-comparativa-y-elección)
3. [Diseño de la Base de Datos](#3-diseño-de-la-base-de-datos)
   - 3.1. [Modelo Entidad-Relación](#31-modelo-entidad-relación)
   - 3.2. [Tablas y Relaciones](#32-tablas-y-relaciones)
4. [Arquitectura de la Aplicación](#4-arquitectura-de-la-aplicación)
   - 4.1. [Patrón MVC](#41-patrón-mvc)
   - 4.2. [Estructura del Proyecto](#42-estructura-del-proyecto)
5. [Modelos de Datos](#5-modelos-de-datos)
6. [Controladores](#6-controladores)
7. [Vistas](#7-vistas)
8. [Funcionalidades Implementadas](#8-funcionalidades-implementadas)
9. [Tecnologías Utilizadas](#9-tecnologías-utilizadas)

---

## 1. INTRODUCCIÓN

Esta aplicación web ha sido desarrollada como parte de la Actividad Evaluable 4 de la asignatura de Desarrollo Web en Entorno Servidor. El proyecto consiste en una **plataforma de gestión de contenidos de streaming** similar a Netflix, HBO o Amazon Prime Video.

### Contexto de la Aplicación

La aplicación permite gestionar una base de datos de contenidos audiovisuales (películas y series), actores, géneros y valoraciones de usuarios. Los usuarios pueden:

- Explorar el catálogo de contenidos disponibles
- Buscar contenidos por título, año, tipo o género
- Ver información detallada de cada contenido, incluyendo su reparto
- Consultar información sobre actores y sus filmografías
- Ver géneros y los contenidos asociados
- Acceder a estadísticas sobre el catálogo

### Objetivos del Proyecto

1. Implementar una aplicación web completa usando ASP.NET Core con Razor Pages
2. Utilizar Entity Framework Core para el acceso a datos
3. Aplicar el patrón de diseño Modelo-Vista-Controlador (MVC)
4. Diseñar e implementar una base de datos relacional con MySQL
5. Crear una interfaz de usuario moderna y responsive
6. Implementar funcionalidades de búsqueda y filtrado avanzadas

---

## 2. ANÁLISIS DE TECNOLOGÍAS PARA ACCESO A DATOS EN .NET

En el ecosistema .NET existen varias tecnologías para el acceso a bases de datos. A continuación se analizan las principales opciones:

### 2.1. ADO.NET

**ADO.NET** (ActiveX Data Objects .NET) es la tecnología fundamental de acceso a datos en .NET, proporcionando acceso directo a bases de datos relacionales.

#### Características

- **Bajo nivel**: Proporciona control total sobre las operaciones de base de datos
- **Rendimiento**: Al ser de bajo nivel, ofrece el mejor rendimiento posible
- **Complejidad**: Requiere escribir SQL manualmente y gestionar conexiones
- **Sin mapeo**: No proporciona mapeo objeto-relacional (ORM)

#### Ventajas

-  Máximo control sobre las consultas SQL
-  Excelente rendimiento en operaciones críticas
-  Menor sobrecarga de memoria
-  Ideal para consultas complejas específicas

#### Desventajas

-  Mayor complejidad en el desarrollo
-  Más código repetitivo (boilerplate)
-  Propenso a errores de SQL injection si no se usa correctamente
-  No proporciona abstracción de la base de datos

#### Ejemplo de uso

```csharp
using (SqlConnection connection = new SqlConnection(connectionString))
{
    connection.Open();
    SqlCommand command = new SqlCommand("SELECT * FROM Contenidos WHERE Id = @Id", connection);
    command.Parameters.AddWithValue("@Id", id);
    
    using (SqlDataReader reader = command.ExecuteReader())
    {
        if (reader.Read())
   {
            var contenido = new Contenido
    {
 Id = reader.GetInt32(0),
       Titulo = reader.GetString(1),
 // ... más propiedades
        };
 }
    }
}
```

---

### 2.2. Entity Framework Core

**Entity Framework Core (EF Core)** es un ORM (Object-Relational Mapper) moderno, ligero y extensible que permite trabajar con bases de datos usando objetos .NET.

#### Características

- **ORM completo**: Mapeo automático entre objetos y tablas
- **LINQ**: Consultas usando Language Integrated Query
- **Code First o Database First**: Flexibilidad en el enfoque de desarrollo
- **Migraciones**: Gestión de cambios en el esquema de base de datos
- **Lazy Loading**: Carga diferida de datos relacionados

#### Ventajas

-  Productividad: Reduce significativamente el código necesario
-  Abstracción de base de datos: Facilita cambiar de motor de BD
-  LINQ: Consultas fuertemente tipadas y verificadas en tiempo de compilación
-  Migraciones automáticas: Gestión del esquema de base de datos
-  Change Tracking: Seguimiento automático de cambios en entidades
-  Gran ecosistema y documentación
-  Soporte para múltiples bases de datos

#### Desventajas

-  Curva de aprendizaje inicial
-  Menor rendimiento que ADO.NET en operaciones específicas
-  Mayor uso de memoria
-  Puede generar consultas SQL no óptimas en casos complejos

#### Ejemplo de uso

```csharp
public class StreamingContext : DbContext
{
    public DbSet<Contenido> Contenidos { get; set; }
    public DbSet<Actor> Actores { get; set; }
}

// Consultas con LINQ
var contenidos = await _context.Contenidos
    .Include(c => c.Genero)
    .Include(c => c.Valoraciones)
    .Where(c => c.Tipo == TipoContenido.Pelicula)
    .OrderBy(c => c.Titulo)
    .ToListAsync();
```

---

### 2.3. Dapper

**Dapper** es un micro-ORM desarrollado por Stack Overflow que combina la simplicidad de ADO.NET con algunas características de un ORM.

#### Características

- **Micro-ORM**: Ligero y rápido
- **Mapeo automático**: De resultados SQL a objetos
- **SQL directo**: Usa consultas SQL escritas manualmente
- **Alto rendimiento**: Casi tan rápido como ADO.NET puro

#### Ventajas

-  Excelente rendimiento (cercano a ADO.NET)
-  Simple y fácil de aprender
-  Control total sobre SQL
-  Ligero (sin sobrecarga significativa)
-  Mapeo automático de resultados

#### Desventajas

-  Sin change tracking
-  Sin lazy loading
-  Sin migraciones automáticas
-  Requiere escribir SQL manualmente
-  Menos características que EF Core

#### Ejemplo de uso

```csharp
using (var connection = new MySqlConnection(connectionString))
{
    var contenidos = await connection.QueryAsync<Contenido>(
        "SELECT * FROM Contenidos WHERE GeneroId = @GeneroId",
   new { GeneroId = generoId }
    );
}
```

---

### 2.4. Comparativa y Elección

#### Tabla Comparativa

| Característica | ADO.NET | Entity Framework Core | Dapper |
|----------------|---------|----------------------|--------|
| **Nivel de abstracción** | Bajo | Alto | Medio |
| **Rendimiento** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Productividad** | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Curva de aprendizaje** | Media | Alta | Baja |
| **Mapeo ORM** | ❌ | ✅ | Limitado |
| **LINQ** | ❌ | ✅ | ❌ |
| **Migraciones** | ❌ | ✅ | ❌ |
| **Change Tracking** | ❌ | ✅ | ❌ |
| **Control SQL** | Total | Limitado | Total |
| **Uso de memoria** | Bajo | Alto | Bajo |

#### Elección: Entity Framework Core

Para este proyecto se ha elegido **Entity Framework Core** por las siguientes razones:

1. **Productividad**: Permite desarrollar más rápido reduciendo el código boilerplate
2. **Abstracción**: Facilita trabajar con objetos en lugar de SQL directamente
3. **LINQ**: Proporciona consultas fuertemente tipadas y seguras
4. **Relaciones**: Manejo automático de relaciones complejas (muchos a muchos, uno a muchos)
5. **Migraciones**: No aplica directamente en este proyecto Database First, pero es una ventaja
6. **Ecosistema**: Amplia documentación y comunidad
7. **Ideal para proyectos educativos**: Permite centrarse en la lógica de negocio

#### Configuración en el Proyecto

```csharp
// Program.cs
builder.Services.AddDbContext<StreamingContext>(options =>
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

// StreamingContext.cs
public class StreamingContext : DbContext
{
    public DbSet<Genero> Generos { get; set; }
    public DbSet<Actor> Actores { get; set; }
    public DbSet<Contenido> Contenidos { get; set; }
    public DbSet<ContenidoActor> ContenidoActores { get; set; }
    public DbSet<Valoracion> Valoraciones { get; set; }
}
```

---

## 3. DISEÑO DE LA BASE DE DATOS

### 3.1. Modelo Entidad-Relación

La base de datos ha sido diseñada siguiendo principios de normalización y modelo relacional. Las entidades principales son:

- **Generos**: Categorías de contenido (Acción, Drama, Comedia, etc.)
- **Actores**: Información sobre actores y actrices
- **Contenidos**: Películas y series de la plataforma
- **ContenidoActores**: Relación muchos a muchos entre contenidos y actores
- **Valoraciones**: Opiniones y puntuaciones de usuarios

### 3.2. Tablas y Relaciones

#### Tabla: Generos

```sql
CREATE TABLE Generos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT NOT NULL
)
```

**Propósito**: Almacenar las categorías o géneros de contenido.

**Relaciones**:
- Un género puede tener múltiples contenidos (1:N con Contenidos)

---

#### Tabla: Actores

```sql
CREATE TABLE Actores (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Nacionalidad VARCHAR(100) NOT NULL,
    Biografia TEXT,
    Foto VARCHAR(500)
)
```

**Propósito**: Almacenar información sobre actores y actrices.

**Relaciones**:
- Un actor puede participar en múltiples contenidos (N:M con Contenidos a través de ContenidoActores)

---

#### Tabla: Contenidos

```sql
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
)
```

**Propósito**: Almacenar películas y series de la plataforma.

**Campos destacados**:
- `Tipo`: Pelicula o Serie
- `NumeroTemporadas`: Solo aplica a series
- `Duracion`: En minutos (para películas es la duración total, para series es por episodio)

**Relaciones**:
- Pertenece a un género (N:1 con Generos)
- Tiene múltiples actores (N:M con Actores a través de ContenidoActores)
- Tiene múltiples valoraciones (1:N con Valoraciones)

---

#### Tabla: ContenidoActores (Tabla Intermedia)

```sql
CREATE TABLE ContenidoActores (
    ContenidoId INT NOT NULL,
    ActorId INT NOT NULL,
    Papel VARCHAR(200) NOT NULL,
    EsProtagonista BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (ContenidoId, ActorId),
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id),
    FOREIGN KEY (ActorId) REFERENCES Actores(Id)
)
```

**Propósito**: Relación muchos a muchos entre Contenidos y Actores.

**Campos adicionales**:
- `Papel`: Personaje interpretado
- `EsProtagonista`: Indica si es actor principal

---

#### Tabla: Valoraciones

```sql
CREATE TABLE Valoraciones (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ContenidoId INT NOT NULL,
    NombreUsuario VARCHAR(100) NOT NULL,
    Puntuacion INT NOT NULL,
    Comentario TEXT,
    FechaValoracion DATETIME NOT NULL,
    FOREIGN KEY (ContenidoId) REFERENCES Contenidos(Id)
)
```

**Propósito**: Almacenar reseñas y puntuaciones de usuarios.

**Relaciones**:
- Pertenece a un contenido (N:1 con Contenidos)

---

### Diagrama de Relaciones

```
Generos (1) ←──── (N) Contenidos (N) ←──→ (M) Actores
  ↓
        (1:N)
 ↓
          Valoraciones

Relación N:M implementada mediante tabla ContenidoActores
```

---

## 4. ARQUITECTURA DE LA APLICACIÓN

### 4.1. Patrón MVC

La aplicación sigue el patrón **Modelo-Vista-Controlador (MVC)**, uno de los patrones arquitectónicos más populares para aplicaciones web.

#### Componentes del Patrón MVC

**Modelo (Model)**
- Representa los datos y la lógica de negocio
- Entidades: `Genero`, `Actor`, `Contenido`, `ContenidoActor`, `Valoracion`
- Ubicación: `/Models`

**Vista (View)**
- Presenta los datos al usuario (interfaz gráfica)
- Archivos Razor (.cshtml)
- Ubicación: `/Views`

**Controlador (Controller)**
- Gestiona las peticiones del usuario
- Coordina Modelo y Vista
- Ubicación: `/Controllers`

#### Flujo de una petición

```
Usuario → Controlador → Modelo (BD) → Vista → Usuario
```

1. El usuario hace una petición HTTP (ej: `/Contenidos/Details/1`)
2. El router envía la petición al controlador correspondiente
3. El controlador consulta el modelo (acceso a base de datos)
4. El controlador selecciona una vista y le pasa los datos
5. La vista renderiza HTML con los datos
6. Se devuelve la respuesta al usuario

---

### 4.2. Estructura del Proyecto

```
AE4_DWES_CarlosdeAldaGarcia/
│
├── Controllers/    # Controladores MVC
│   ├── HomeController.cs
│   ├── GenerosController.cs
│   ├── ActoresController.cs
│   ├── ContenidosController.cs
│   └── EstadisticasController.cs
│
├── Models/        # Modelos de datos
│   ├── Genero.cs
│   ├── Actor.cs
│   ├── Contenido.cs
│   ├── ContenidoActor.cs
│   ├── Valoracion.cs
│   └── ErrorViewModel.cs
│
├── Views/         # Vistas Razor
│   ├── Home/
│ │   └── Index.cshtml
│   ├── Generos/
│ │   ├── Index.cshtml
│   │   └── Details.cshtml
│   ├── Actores/
│   │   ├── Index.cshtml
│   │   └── Details.cshtml
│   ├── Contenidos/
│   │   ├── Index.cshtml
│   │   ├── Details.cshtml
│   │   └── Buscar.cshtml
│   ├── Estadisticas/
│   │   └── Index.cshtml
│   └── Shared/
│       ├── _Layout.cshtml
│     ├── Error.cshtml
│       └── _ValidationScriptsPartial.cshtml
│
├── Data/       # Contexto de Entity Framework
│   └── StreamingContext.cs
│
├── wwwroot/           # Archivos estáticos
│   ├── css/
│   │   └── site.css
│   ├── images/
│   │   ├── no-poster.svg
│   │   └── no-actor-photo.svg
│   └── js/
│
├── Database/             # Scripts SQL
│   └── StreamingDB_Backup.sql
│
├── Program.cs  # Punto de entrada de la aplicación
├── appsettings.json      # Configuración
└── AE4_DWES_CarlosdeAldaGarcia.csproj
```

---

## 5. MODELOS DE DATOS

Los modelos representan las entidades de la base de datos como clases C#.

### Genero.cs

```csharp
public class Genero
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    
    // Relación con Contenidos
    public ICollection<Contenido> Contenidos { get; set; } = new List<Contenido>();
}
```

---

### Actor.cs

```csharp
public class Actor
{
    public int Id { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Apellidos { get; set; } = string.Empty;
    public DateTime FechaNacimiento { get; set; }
    public string Nacionalidad { get; set; } = string.Empty;
    public string? Biografia { get; set; }
    public string? Foto { get; set; }
    
    // Propiedades calculadas
    public string NombreCompleto => $"{Nombre} {Apellidos}";
    public int Edad => DateTime.Now.Year - FechaNacimiento.Year;
 
    // Relación con Contenidos (muchos a muchos)
    public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();
}
```

---

### Contenido.cs

```csharp
public enum TipoContenido
{
    Pelicula,
    Serie
}

public class Contenido
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public int Anio { get; set; }
    public int Duracion { get; set; }
    public TipoContenido Tipo { get; set; }
    public string Director { get; set; } = string.Empty;
    public string? Poster { get; set; }
    public DateTime FechaEstreno { get; set; }
    public int? NumeroTemporadas { get; set; }
    
    // Foreign Key
    public int GeneroId { get; set; }
    
    // Propiedades de navegación
    public Genero Genero { get; set; } = null!;
    public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();
    public ICollection<Valoracion> Valoraciones { get; set; } = new List<Valoracion>();
    
    // Propiedades calculadas
    public double PuntuacionPromedio => 
        Valoraciones.Any() ? Valoraciones.Average(v => v.Puntuacion) : 0;
    
    public int NumeroValoraciones => Valoraciones.Count;
}
```

---

### ContenidoActor.cs (Tabla Intermedia)

```csharp
public class ContenidoActor
{
    public int ContenidoId { get; set; }
    public int ActorId { get; set; }
    public string Papel { get; set; } = string.Empty;
public bool EsProtagonista { get; set; }
    
    // Propiedades de navegación
    public Contenido Contenido { get; set; } = null!;
 public Actor Actor { get; set; } = null!;
}
```

---

### Valoracion.cs

```csharp
public class Valoracion
{
    public int Id { get; set; }
    public int ContenidoId { get; set; }
    public string NombreUsuario { get; set; } = string.Empty;
    public int Puntuacion { get; set; }
 public string? Comentario { get; set; }
    public DateTime FechaValoracion { get; set; }
    
    // Propiedad de navegación
    public Contenido Contenido { get; set; } = null!;
}
```

---

## 6. CONTROLADORES

Los controladores gestionan la lógica de la aplicación y la interacción con la base de datos.

### HomeController

Gestiona la página principal y errores.

```csharp
public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
    
    public IActionResult Error()
    {
        return View(new ErrorViewModel { 
            RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier 
    });
    }
}
```

---

### GenerosController

Gestiona la visualización de géneros y su contenido asociado.

**Funcionalidades**:
- Listar todos los géneros
- Ver detalles de un género con sus contenidos

```csharp
public class GenerosController : Controller
{
    private readonly StreamingContext _context;
    
    public async Task<IActionResult> Index()
    {
   var generos = await _context.Generos
  .Include(g => g.Contenidos)
       .OrderBy(g => g.Nombre)
            .ToListAsync();
        return View(generos);
    }
    
    public async Task<IActionResult> Details(int? id)
    {
        var genero = await _context.Generos
      .Include(g => g.Contenidos)
         .ThenInclude(c => c.Valoraciones)
            .FirstOrDefaultAsync(m => m.Id == id);
   
        return View(genero);
    }
}
```

---

### ActoresController

Gestiona la información de actores y su filmografía.

**Funcionalidades**:
- Listar todos los actores ordenados alfabéticamente
- Ver detalles de un actor con su filmografía completa

```csharp
public class ActoresController : Controller
{
    private readonly StreamingContext _context;
    
    public async Task<IActionResult> Index()
  {
        var actores = await _context.Actores
       .OrderBy(a => a.Apellidos)
      .ThenBy(a => a.Nombre)
            .ToListAsync();
        return View(actores);
    }
    
    public async Task<IActionResult> Details(int? id)
    {
        var actor = await _context.Actores
            .Include(a => a.ContenidoActores)
       .ThenInclude(ca => ca.Contenido)
  .ThenInclude(c => c.Genero)
          .Include(a => a.ContenidoActores)
         .ThenInclude(ca => ca.Contenido)
            .ThenInclude(c => c.Valoraciones)
        .FirstOrDefaultAsync(m => m.Id == id);
            
        return View(actor);
    }
}
```

---

### ContenidosController

Gestiona el catálogo de contenidos con búsqueda y filtrado avanzado.

**Funcionalidades**:
- Listar todos los contenidos con paginación
- Buscar contenidos por título, año, tipo y género
- Ver detalles completos de un contenido (reparto, valoraciones)

```csharp
public class ContenidosController : Controller
{
    private readonly StreamingContext _context;
    
    public async Task<IActionResult> Index()
 {
        var contenidos = await _context.Contenidos
            .Include(c => c.Genero)
            .Include(c => c.Valoraciones)
         .OrderByDescending(c => c.Anio)
            .ToListAsync();
        return View(contenidos);
    }
    
    public async Task<IActionResult> Buscar(string? titulo, int? anio, 
          string? tipo, int? generoId)
    {
        IQueryable<Contenido> query = _context.Contenidos
            .Include(c => c.Genero)
    .Include(c => c.Valoraciones);
        
        if (!string.IsNullOrEmpty(titulo))
            query = query.Where(c => c.Titulo.Contains(titulo));
        
        if (anio.HasValue)
            query = query.Where(c => c.Anio == anio);
            
        if (!string.IsNullOrEmpty(tipo))
            query = query.Where(c => c.Tipo.ToString() == tipo);
        
        if (generoId.HasValue)
 query = query.Where(c => c.GeneroId == generoId);
   
        var contenidos = await query.OrderBy(c => c.Titulo).ToListAsync();
      ViewBag.Generos = await _context.Generos.ToListAsync();
        
        return View(contenidos);
    }

    public async Task<IActionResult> Details(int? id)
    {
        var contenido = await _context.Contenidos
            .Include(c => c.Genero)
   .Include(c => c.ContenidoActores)
   .ThenInclude(ca => ca.Actor)
            .Include(c => c.Valoraciones)
 .FirstOrDefaultAsync(m => m.Id == id);

        return View(contenido);
    }
}
```

---

### EstadisticasController

Proporciona información estadística sobre el catálogo.

**Funcionalidades**:
- Total de contenidos, actores y géneros
- Contenidos mejor valorados
- Géneros más populares
- Distribución de contenidos por tipo

```csharp
public class EstadisticasController : Controller
{
    private readonly StreamingContext _context;
    
    public async Task<IActionResult> Index()
    {
        var stats = new
        {
            TotalContenidos = await _context.Contenidos.CountAsync(),
      TotalActores = await _context.Actores.CountAsync(),
            TotalGeneros = await _context.Generos.CountAsync(),
            TotalValoraciones = await _context.Valoraciones.CountAsync(),
   
    MejoresContenidos = await _context.Contenidos
    .Include(c => c.Valoraciones)
        .Include(c => c.Genero)
            .Where(c => c.Valoraciones.Any())
   .OrderByDescending(c => c.PuntuacionPromedio)
            .Take(10)
                .ToListAsync(),
      
 GenerosPopulares = await _context.Generos
            .Include(g => g.Contenidos)
          .OrderByDescending(g => g.Contenidos.Count)
                .ToListAsync()
        };
        
        return View(stats);
    }
}
```

---

## 7. VISTAS

Las vistas son archivos Razor (.cshtml) que combinan HTML con código C# para generar contenido dinámico.

### Layout Principal (_Layout.cshtml)

Contiene la estructura común de todas las páginas:
- Barra de navegación con enlaces a las secciones
- Estilos CSS
- Scripts JavaScript
- Footer

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@ViewData["Title"] - Streaming Platform</title>
    <link rel="stylesheet" href="~/css/site.css" />
</head>
<body>
    <header>
        <nav>
            <a asp-controller="Home" asp-action="Index">Inicio</a>
 <a asp-controller="Contenidos" asp-action="Index">Contenidos</a>
       <a asp-controller="Actores" asp-action="Index">Actores</a>
            <a asp-controller="Generos" asp-action="Index">Géneros</a>
            <a asp-controller="Estadisticas" asp-action="Index">Estadísticas</a>
    </nav>
    </header>
    
    <main>
@RenderBody()
    </main>
    
    <footer>
  <p>&copy; 2024 - Streaming Platform</p>
  </footer>
</body>
</html>
```

---

### Páginas Principales

#### Home/Index.cshtml
- Página de bienvenida
- Descripción de la plataforma
- Enlaces rápidos a las secciones principales

#### Contenidos/Index.cshtml
- Listado de todos los contenidos en formato de tarjetas
- Muestra póster, título, año, tipo y puntuación
- Enlace a detalles de cada contenido

#### Contenidos/Buscar.cshtml
- Formulario de búsqueda avanzada
- Filtros por título, año, tipo y género
- Resultados mostrados en tarjetas

#### Contenidos/Details.cshtml
- Información completa del contenido
- Póster grande
- Datos técnicos (director, año, duración)
- Listado del reparto con enlaces a actores
- Todas las valoraciones con comentarios

#### Actores/Index.cshtml
- Listado de actores en formato de tarjetas
- Foto, nombre y nacionalidad
- Ordenado alfabéticamente por apellidos

#### Actores/Details.cshtml
- Biografía completa del actor
- Foto grande
- Datos personales (edad, nacionalidad)
- Filmografía completa con roles interpretados

#### Generos/Index.cshtml
- Tarjetas con todos los géneros
- Descripción de cada género
- Número de contenidos disponibles

#### Generos/Details.cshtml
- Información del género
- Listado completo de contenidos de ese género

#### Estadisticas/Index.cshtml
- Resumen numérico del catálogo
- Top 10 contenidos mejor valorados
- Géneros con más contenidos
- Gráficas y visualizaciones

---

## 8. FUNCIONALIDADES IMPLEMENTADAS

### 8.1. Gestión de Contenidos

 **Listado completo de contenidos**
- Vista en formato de tarjetas responsive
- Información resumida: póster, título, año, tipo, género
- Puntuación media visible

 **Búsqueda avanzada**
- Filtro por título (búsqueda parcial)
- Filtro por año
- Filtro por tipo (Película/Serie)
- Filtro por género
- Combinación de múltiples filtros

 **Detalles de contenido**
- Información completa
- Reparto con enlaces a perfiles de actores
- Todas las valoraciones y comentarios
- Indicador de protagonistas

---

### 8.2. Gestión de Actores

 **Listado de actores**
- Ordenación alfabética por apellidos
- Formato de tarjetas con foto
- Información básica visible

 **Perfil de actor**
- Biografía completa
- Datos personales (edad calculada automáticamente)
- Filmografía completa
- Indicación de roles protagonistas

---

### 8.3. Gestión de Géneros

 **Listado de géneros**
- Descripción de cada género
- Contador de contenidos

 **Contenidos por género**
- Vista filtrada de todos los contenidos de un género
- Información de puntuaciones

---

### 8.4. Valoraciones

 **Sistema de reseñas**
- Puntuación de 1 a 5 estrellas
- Comentarios de usuarios
- Fecha de valoración
- Cálculo automático de media

---

### 8.5. Estadísticas

 **Dashboard estadístico**
- Totales: contenidos, actores, géneros, valoraciones
- Top 10 contenidos mejor valorados
- Géneros más populares
- Distribución por tipo de contenido

---

### 8.6. Funcionalidades Transversales

 **Navegación intuitiva**
- Menú de navegación persistente
- Breadcrumbs en páginas de detalle
- Enlaces contextuales entre entidades

 **Diseño responsive**
- Adaptación a diferentes tamaños de pantalla
- Grid flexible para tarjetas
- Navegación mobile-friendly

 **Manejo de imágenes**
- Imágenes placeholder para contenido sin póster
- Imágenes placeholder para actores sin foto
- Carga optimizada de imágenes externas

 **Gestión de errores**
- Página de error personalizada
- Validación de parámetros
- Manejo de registros no encontrados

---

## 9. TECNOLOGÍAS UTILIZADAS

### Backend

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **.NET** | 8.0 | Framework principal |
| **ASP.NET Core MVC** | 8.0 | Arquitectura web |
| **Entity Framework Core** | 9.0 | ORM para acceso a datos |
| **Pomelo.EntityFrameworkCore.MySql** | 9.0.0 | Provider de MySQL para EF Core |
| **C#** | 12.0 | Lenguaje de programación |

### Frontend

| Tecnología | Propósito |
|------------|-----------|
| **Razor Pages** | Motor de vistas |
| **HTML5** | Estructura |
| **CSS3** | Estilos y diseño |
| **JavaScript** | Interactividad |

### Base de Datos

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **MySQL** | 8.0+ | Sistema gestor de base de datos |
| **MySQL Workbench** | 8.0+ | Herramienta de administración |

### Herramientas de Desarrollo

| Herramienta | Propósito |
|-------------|-----------|
| **Visual Studio 2022** | IDE principal |
| **Git** | Control de versiones |
| **GitHub** | Repositorio remoto |
| **Postman** | Pruebas de API (opcional) |

---

### Referencias

- [Documentación oficial de ASP.NET Core](https://docs.microsoft.com/aspnet/core/)
- [Documentación de Entity Framework Core](https://docs.microsoft.com/ef/core/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [C# Programming Guide](https://docs.microsoft.com/dotnet/csharp/)
- [Razor syntax reference](https://docs.microsoft.com/aspnet/core/mvc/views/razor)
- [Bootstrap Documentation](https://getbootstrap.com/docs/)

---


**Autor**: Carlos de Alda García  
**Fecha**: 24 de octubre 2025  
**Repositorio**: https://github.com/Carlosdag2/AE4_DWES_CarlosdeAldaGarcia
