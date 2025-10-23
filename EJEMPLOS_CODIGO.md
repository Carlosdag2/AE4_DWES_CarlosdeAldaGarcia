# ?? Ejemplos de Código para la Exposición

## ?? Índice
1. [Modelos con Relaciones](#1-modelos-con-relaciones)
2. [DbContext y Configuración EF Core](#2-dbcontext-y-configuración-ef-core)
3. [Consultas LINQ en Controladores](#3-consultas-linq-en-controladores)
4. [Vistas Tipadas Razor](#4-vistas-tipadas-razor)
5. [Configuración en Program.cs](#5-configuración-en-programcs)

---

## 1. Modelos con Relaciones

### ?? Modelo: Contenido.cs
```csharp
public class Contenido
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public int Anio { get; set; }
    public TipoContenido Tipo { get; set; } // Enum: Pelicula o Serie
    
    // Relación MUCHOS A UNO con Genero
    public int GeneroId { get; set; }
    public Genero Genero { get; set; } = null!;

    // Relación MUCHOS A MUCHOS con Actores
    public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();

    // Relación UNO A MUCHOS con Valoraciones
    public ICollection<Valoracion> Valoraciones { get; set; } = new List<Valoracion>();
}
```

**Explicar:**
- Propiedades de navegación para relaciones
- `GeneroId` (FK) + `Genero` (navegación)
- `ICollection<>` para relaciones de muchos

---

### ?? Modelo: ContenidoActor.cs (Tabla Intermedia)
```csharp
public class ContenidoActor
{
    // Clave primaria compuesta
    public int ContenidoId { get; set; }
    public Contenido Contenido { get; set; } = null!;

    public int ActorId { get; set; }
    public Actor Actor { get; set; } = null!;

    // Campos adicionales de la relación
    public string Papel { get; set; } = string.Empty;
    public bool EsProtagonista { get; set; }
}
```

**Explicar:**
- Tabla intermedia personalizada con datos adicionales
- No solo relaciona, también guarda información de la relación
- `Papel`: nombre del personaje
- `EsProtagonista`: si es actor principal

---

## 2. DbContext y Configuración EF Core

### ??? StreamingContext.cs
```csharp
public class StreamingContext : DbContext
{
    public StreamingContext(DbContextOptions<StreamingContext> options) : base(options) { }

    // DbSets - Tablas de la base de datos
    public DbSet<Genero> Generos { get; set; }
    public DbSet<Actor> Actores { get; set; }
    public DbSet<Contenido> Contenidos { get; set; }
    public DbSet<ContenidoActor> ContenidoActores { get; set; }
    public DbSet<Valoracion> Valoraciones { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configurar clave primaria compuesta de ContenidoActor
        modelBuilder.Entity<ContenidoActor>()
            .HasKey(ca => new { ca.ContenidoId, ca.ActorId });

        // Configurar relación Contenido ? ContenidoActor
        modelBuilder.Entity<ContenidoActor>()
            .HasOne(ca => ca.Contenido)
            .WithMany(c => c.ContenidoActores)
            .HasForeignKey(ca => ca.ContenidoId);

        // Configurar relación Actor ? ContenidoActor
        modelBuilder.Entity<ContenidoActor>()
            .HasOne(ca => ca.Actor)
            .WithMany(a => a.ContenidoActores)
            .HasForeignKey(ca => ca.ActorId);
    }
}
```

**Explicar:**
- `DbSet<T>` representa cada tabla
- `OnModelCreating` para configuración avanzada
- Clave compuesta con `HasKey()`
- Fluent API para relaciones

---

## 3. Consultas LINQ en Controladores

### ?? EstadisticasController.cs - Top 5 Mejor Valorados
```csharp
// Obtener los 5 contenidos mejor valorados
var mejorValorados = await _context.Contenidos
    .Include(c => c.Genero)           // Eager loading del género
    .Include(c => c.Valoraciones)     // Eager loading de valoraciones
    .Where(c => c.Valoraciones.Any()) // Solo contenidos con valoraciones
    .OrderByDescending(c => c.Valoraciones.Average(v => v.Puntuacion))
    .Take(5)
    .ToListAsync();
```

**Conceptos LINQ:**
- ? `Include()` - Carga ansiosa de relaciones
- ? `Where()` - Filtrado
- ? `Any()` - Verifica si existe al menos uno
- ? `Average()` - Promedio de valoraciones
- ? `OrderByDescending()` - Ordenamiento descendente
- ? `Take()` - Limitar resultados
- ? `ToListAsync()` - Ejecución asíncrona

---

### ?? ContenidosController.cs - Filtros Dinámicos
```csharp
public async Task<IActionResult> Index(string? tipo, int? generoId)
{
    var contenidos = _context.Contenidos
        .Include(c => c.Genero)
        .Include(c => c.Valoraciones)
        .AsQueryable(); // Query diferida

    // Filtro por tipo (Pelicula/Serie)
    if (!string.IsNullOrEmpty(tipo))
    {
        if (tipo == "Pelicula")
            contenidos = contenidos.Where(c => c.Tipo == TipoContenido.Pelicula);
        else if (tipo == "Serie")
            contenidos = contenidos.Where(c => c.Tipo == TipoContenido.Serie);
    }

    // Filtro por género
    if (generoId.HasValue)
    {
        contenidos = contenidos.Where(c => c.GeneroId == generoId.Value);
    }

    return View(await contenidos.OrderByDescending(c => c.FechaEstreno).ToListAsync());
}
```

**Explicar:**
- Filtros opcionales con parámetros nullable
- Query building con `AsQueryable()`
- Múltiples filtros combinados
- Ejecución diferida (solo se ejecuta en `ToListAsync()`)

---

### ?? Búsqueda por Texto
```csharp
public async Task<IActionResult> Buscar(string termino)
{
    var contenidos = await _context.Contenidos
        .Include(c => c.Genero)
        .Include(c => c.Valoraciones)
        .Where(c => c.Titulo.Contains(termino) || 
                   c.Director.Contains(termino) ||
                   c.Descripcion.Contains(termino))
        .ToListAsync();

    return View(contenidos);
}
```

**Conceptos:**
- `Contains()` - Búsqueda parcial (LIKE en SQL)
- Operador `||` (OR) para buscar en múltiples campos

---

### ?? Distribución por Año (GroupBy)
```csharp
var distribucionPorAnio = await _context.Contenidos
    .GroupBy(c => c.Anio)                    // Agrupar por año
    .Select(g => new { 
        Anio = g.Key,                        // Año (clave del grupo)
        Cantidad = g.Count()                 // Contar elementos del grupo
    })
    .OrderByDescending(x => x.Anio)
    .Take(10)
    .ToDictionaryAsync(x => x.Anio, x => x.Cantidad);
```

**Conceptos:**
- `GroupBy()` - Agrupación (como GROUP BY en SQL)
- `Select()` - Proyección a objeto anónimo
- `Count()` - Conteo de elementos por grupo
- `ToDictionaryAsync()` - Convertir a diccionario

---

### ?? Actores con su Filmografía (Include anidado)
```csharp
var actor = await _context.Actores
    .Include(a => a.ContenidoActores)              // Incluir tabla intermedia
        .ThenInclude(ca => ca.Contenido)           // Incluir contenidos
            .ThenInclude(c => c.Genero)            // Incluir género del contenido
    .FirstOrDefaultAsync(m => m.Id == id);
```

**Conceptos:**
- `Include()` - Primer nivel de relación
- `ThenInclude()` - Niveles anidados de relaciones
- `FirstOrDefaultAsync()` - Obtener el primero o null

---

## 4. Vistas Tipadas Razor

### ?? Index.cshtml de Contenidos
```razor
@model IEnumerable<AE4_DWES_CarlosdeAldaGarcia.Models.Contenido>

@{
    ViewData["Title"] = "Catálogo de Contenidos";
}

<h1>Catálogo de Contenidos</h1>

@foreach (var item in Model)
{
    <div class="card">
        <h5>@item.Titulo</h5>
        <p>@item.Genero.Nombre - @item.Anio</p>
        
        @if (item.Valoraciones.Any())
        {
            var promedio = item.Valoraciones.Average(v => v.Puntuacion);
            <p>? @promedio.ToString("F1")</p>
        }
        
        <a asp-action="Details" asp-route-id="@item.Id">Ver Detalles</a>
    </div>
}
```

**Explicar:**
- `@model` - Tipo de modelo tipado
- `@item.Genero.Nombre` - Navegación por relaciones
- `@if` - Lógica condicional en Razor
- `asp-action`, `asp-route-id` - Tag helpers

---

### ?? Details.cshtml con Reparto
```razor
@model AE4_DWES_CarlosdeAldaGarcia.Models.Contenido

<h1>@Model.Titulo</h1>
<p>@Model.Descripcion</p>

<h3>Reparto</h3>
<ul>
    @foreach (var ca in Model.ContenidoActores.OrderByDescending(ca => ca.EsProtagonista))
    {
        <li>
            <strong>@ca.Actor.Nombre @ca.Actor.Apellidos</strong>
            como @ca.Papel
            @if (ca.EsProtagonista)
            {
                <span class="badge">Protagonista</span>
            }
        </li>
    }
</ul>
```

**Explicar:**
- Acceso a propiedades de navegación anidadas
- `@ca.Actor.Nombre` atraviesa la relación muchos a muchos
- Ordenamiento en la vista con `OrderByDescending()`

---

## 5. Configuración en Program.cs

### ?? Registro de Entity Framework
```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

// Configurar Entity Framework con MySQL
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<StreamingContext>(options =>
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

var app = builder.Build();

// Middleware pipeline
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
```

**Explicar:**
- Inyección de dependencias con `AddDbContext<>`
- `UseMySql()` del paquete Pomelo
- `ServerVersion.AutoDetect()` detecta versión de MySQL
- Patrón MVC: `{controller=Home}/{action=Index}/{id?}`

---

## ?? Puntos Clave para la Exposición

### Al mostrar Modelos:
1. Mostrar `Contenido.cs` - ejemplo de todas las relaciones
2. Mostrar `ContenidoActor.cs` - tabla intermedia personalizada
3. Explicar las anotaciones y tipos de datos

### Al mostrar DbContext:
1. Mostrar los `DbSet<>`
2. Explicar `OnModelCreating()` para relación N:M
3. Mencionar Fluent API vs Data Annotations

### Al mostrar Controladores:
1. Elegir `EstadisticasController` - tiene las consultas LINQ más complejas
2. Explicar una consulta paso por paso
3. Mostrar cómo `Include()` previene N+1 queries

### Al mostrar Vistas:
1. Mostrar `Details.cshtml` de Contenidos
2. Explicar `@model` y cómo accede a datos
3. Mostrar cómo se navega por relaciones

---

## ?? Consultas SQL Equivalentes (Para comparar)

### LINQ vs SQL

**LINQ:**
```csharp
var contenidos = await _context.Contenidos
    .Include(c => c.Genero)
    .Where(c => c.Anio == 2024)
    .OrderBy(c => c.Titulo)
    .ToListAsync();
```

**SQL Equivalente:**
```sql
SELECT c.*, g.*
FROM Contenidos c
INNER JOIN Generos g ON c.GeneroId = g.Id
WHERE c.Anio = 2024
ORDER BY c.Titulo;
```

---

## ?? Ventajas de Entity Framework Core

? **Tipo seguro** - Errores en tiempo de compilación  
? **IntelliSense** - Autocompletado en el IDE  
? **LINQ** - Consultas con sintaxis C#  
? **Tracking** - Detecta cambios automáticamente  
? **Migrations** - Versionado de base de datos  
? **Lazy/Eager Loading** - Control de carga de relaciones  

---

**¡Utiliza estos ejemplos durante tu exposición para mostrar tu dominio del tema! ??**
