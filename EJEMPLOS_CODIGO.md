# ?? Ejemplos de C�digo para la Exposici�n

## ?? �ndice
1. [Modelos con Relaciones](#1-modelos-con-relaciones)
2. [DbContext y Configuraci�n EF Core](#2-dbcontext-y-configuraci�n-ef-core)
3. [Consultas LINQ en Controladores](#3-consultas-linq-en-controladores)
4. [Vistas Tipadas Razor](#4-vistas-tipadas-razor)
5. [Configuraci�n en Program.cs](#5-configuraci�n-en-programcs)

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
    
    // Relaci�n MUCHOS A UNO con Genero
    public int GeneroId { get; set; }
    public Genero Genero { get; set; } = null!;

    // Relaci�n MUCHOS A MUCHOS con Actores
    public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();

    // Relaci�n UNO A MUCHOS con Valoraciones
    public ICollection<Valoracion> Valoraciones { get; set; } = new List<Valoracion>();
}
```

**Explicar:**
- Propiedades de navegaci�n para relaciones
- `GeneroId` (FK) + `Genero` (navegaci�n)
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

    // Campos adicionales de la relaci�n
    public string Papel { get; set; } = string.Empty;
    public bool EsProtagonista { get; set; }
}
```

**Explicar:**
- Tabla intermedia personalizada con datos adicionales
- No solo relaciona, tambi�n guarda informaci�n de la relaci�n
- `Papel`: nombre del personaje
- `EsProtagonista`: si es actor principal

---

## 2. DbContext y Configuraci�n EF Core

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

        // Configurar relaci�n Contenido ? ContenidoActor
        modelBuilder.Entity<ContenidoActor>()
            .HasOne(ca => ca.Contenido)
            .WithMany(c => c.ContenidoActores)
            .HasForeignKey(ca => ca.ContenidoId);

        // Configurar relaci�n Actor ? ContenidoActor
        modelBuilder.Entity<ContenidoActor>()
            .HasOne(ca => ca.Actor)
            .WithMany(a => a.ContenidoActores)
            .HasForeignKey(ca => ca.ActorId);
    }
}
```

**Explicar:**
- `DbSet<T>` representa cada tabla
- `OnModelCreating` para configuraci�n avanzada
- Clave compuesta con `HasKey()`
- Fluent API para relaciones

---

## 3. Consultas LINQ en Controladores

### ?? EstadisticasController.cs - Top 5 Mejor Valorados
```csharp
// Obtener los 5 contenidos mejor valorados
var mejorValorados = await _context.Contenidos
    .Include(c => c.Genero)           // Eager loading del g�nero
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
- ? `ToListAsync()` - Ejecuci�n as�ncrona

---

### ?? ContenidosController.cs - Filtros Din�micos
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

    // Filtro por g�nero
    if (generoId.HasValue)
    {
        contenidos = contenidos.Where(c => c.GeneroId == generoId.Value);
    }

    return View(await contenidos.OrderByDescending(c => c.FechaEstreno).ToListAsync());
}
```

**Explicar:**
- Filtros opcionales con par�metros nullable
- Query building con `AsQueryable()`
- M�ltiples filtros combinados
- Ejecuci�n diferida (solo se ejecuta en `ToListAsync()`)

---

### ?? B�squeda por Texto
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
- `Contains()` - B�squeda parcial (LIKE en SQL)
- Operador `||` (OR) para buscar en m�ltiples campos

---

### ?? Distribuci�n por A�o (GroupBy)
```csharp
var distribucionPorAnio = await _context.Contenidos
    .GroupBy(c => c.Anio)                    // Agrupar por a�o
    .Select(g => new { 
        Anio = g.Key,                        // A�o (clave del grupo)
        Cantidad = g.Count()                 // Contar elementos del grupo
    })
    .OrderByDescending(x => x.Anio)
    .Take(10)
    .ToDictionaryAsync(x => x.Anio, x => x.Cantidad);
```

**Conceptos:**
- `GroupBy()` - Agrupaci�n (como GROUP BY en SQL)
- `Select()` - Proyecci�n a objeto an�nimo
- `Count()` - Conteo de elementos por grupo
- `ToDictionaryAsync()` - Convertir a diccionario

---

### ?? Actores con su Filmograf�a (Include anidado)
```csharp
var actor = await _context.Actores
    .Include(a => a.ContenidoActores)              // Incluir tabla intermedia
        .ThenInclude(ca => ca.Contenido)           // Incluir contenidos
            .ThenInclude(c => c.Genero)            // Incluir g�nero del contenido
    .FirstOrDefaultAsync(m => m.Id == id);
```

**Conceptos:**
- `Include()` - Primer nivel de relaci�n
- `ThenInclude()` - Niveles anidados de relaciones
- `FirstOrDefaultAsync()` - Obtener el primero o null

---

## 4. Vistas Tipadas Razor

### ?? Index.cshtml de Contenidos
```razor
@model IEnumerable<AE4_DWES_CarlosdeAldaGarcia.Models.Contenido>

@{
    ViewData["Title"] = "Cat�logo de Contenidos";
}

<h1>Cat�logo de Contenidos</h1>

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
- `@item.Genero.Nombre` - Navegaci�n por relaciones
- `@if` - L�gica condicional en Razor
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
- Acceso a propiedades de navegaci�n anidadas
- `@ca.Actor.Nombre` atraviesa la relaci�n muchos a muchos
- Ordenamiento en la vista con `OrderByDescending()`

---

## 5. Configuraci�n en Program.cs

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
- Inyecci�n de dependencias con `AddDbContext<>`
- `UseMySql()` del paquete Pomelo
- `ServerVersion.AutoDetect()` detecta versi�n de MySQL
- Patr�n MVC: `{controller=Home}/{action=Index}/{id?}`

---

## ?? Puntos Clave para la Exposici�n

### Al mostrar Modelos:
1. Mostrar `Contenido.cs` - ejemplo de todas las relaciones
2. Mostrar `ContenidoActor.cs` - tabla intermedia personalizada
3. Explicar las anotaciones y tipos de datos

### Al mostrar DbContext:
1. Mostrar los `DbSet<>`
2. Explicar `OnModelCreating()` para relaci�n N:M
3. Mencionar Fluent API vs Data Annotations

### Al mostrar Controladores:
1. Elegir `EstadisticasController` - tiene las consultas LINQ m�s complejas
2. Explicar una consulta paso por paso
3. Mostrar c�mo `Include()` previene N+1 queries

### Al mostrar Vistas:
1. Mostrar `Details.cshtml` de Contenidos
2. Explicar `@model` y c�mo accede a datos
3. Mostrar c�mo se navega por relaciones

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

? **Tipo seguro** - Errores en tiempo de compilaci�n  
? **IntelliSense** - Autocompletado en el IDE  
? **LINQ** - Consultas con sintaxis C#  
? **Tracking** - Detecta cambios autom�ticamente  
? **Migrations** - Versionado de base de datos  
? **Lazy/Eager Loading** - Control de carga de relaciones  

---

**�Utiliza estos ejemplos durante tu exposici�n para mostrar tu dominio del tema! ??**
