# ?? Guía Rápida de Inicio - StreamFlix

## ? Pasos Rápidos para Ejecutar el Proyecto

### Paso 1: Preparar MySQL
1. Abre **XAMPP** y arranca **Apache** y **MySQL**
2. Abre tu navegador y ve a `http://localhost/phpmyadmin`

### Paso 2: Crear la Base de Datos
1. En phpMyAdmin, haz clic en **"SQL"** (arriba)
2. Abre el archivo `Database/StreamingDB.sql` en un editor de texto
3. **Copia TODO el contenido** del archivo SQL
4. **Pega** en el cuadro de texto de phpMyAdmin
5. Haz clic en **"Continuar"** o **"Ejecutar"**

? **Resultado:** Verás que se creó la base de datos `StreamingDB` con 5 tablas y datos

### Paso 3: Verificar la Conexión
1. Abre el archivo `appsettings.json` del proyecto
2. Verifica que la cadena de conexión sea correcta:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=StreamingDB;User=root;Password=;"
   }
   ```
3. **Si tu MySQL tiene contraseña**, cámbiala en `Password=tucontraseña`

### Paso 4: Ejecutar la Aplicación
1. Abre el proyecto en **Visual Studio 2022**
2. Presiona **F5** o haz clic en el botón ?? **"IIS Express"**
3. Espera a que se abra el navegador automáticamente

? **¡Listo!** La aplicación debería estar funcionando

---

## ?? Verificaciones Rápidas

### ¿MySQL está corriendo?
- Abre XAMPP ? Apache y MySQL deben estar en **verde**

### ¿La base de datos existe?
- Ve a phpMyAdmin ? Deberías ver `StreamingDB` en la lista de la izquierda

### ¿Hay datos en las tablas?
- Haz clic en `StreamingDB` ? Deberías ver 5 tablas:
  - Generos
  - Actores
  - Contenidos
  - ContenidoActores
  - Valoraciones

---

## ?? Solución de Problemas Comunes

### Error: "Unable to connect to any of the specified MySQL hosts"
**Solución:** MySQL no está corriendo
- Abre XAMPP
- Inicia el servicio MySQL
- Reinicia la aplicación

### Error: "Unknown database 'StreamingDB'"
**Solución:** La base de datos no se creó
- Ve al **Paso 2** y ejecuta el script SQL completo

### Error: "Access denied for user 'root'@'localhost'"
**Solución:** La contraseña de MySQL es incorrecta
- En `appsettings.json`, ajusta `Password=` con tu contraseña de MySQL

### Los datos no aparecen
**Solución:** El script SQL se ejecutó parcialmente
- En phpMyAdmin, elimina la base de datos `StreamingDB`
- Ejecuta el script SQL completo nuevamente

---

## ?? Datos Incluidos en la Base de Datos

Después de ejecutar el script SQL, tendrás:
- ? **10 géneros** (Acción, Drama, Comedia, Ciencia Ficción, etc.)
- ? **15 actores** famosos (Leonardo DiCaprio, Scarlett Johansson, etc.)
- ? **25 contenidos** (películas y series icónicas)
- ? **15+ relaciones** entre actores y contenidos
- ? **30+ valoraciones** de usuarios

---

## ?? Funcionalidades a Probar

### En la Página Principal
- Verás los 6 contenidos más recientes
- Cada tarjeta muestra tipo, género, año y valoraciones

### En Contenidos
- **Filtrar** por tipo (Película/Serie) y género
- **Buscar** por texto en título, director o descripción
- **Ver detalles** con reparto completo y valoraciones

### En Actores
- **Buscar** actores por nombre o nacionalidad
- Ver la **filmografía completa** de cada actor

### En Géneros
- Ver todos los géneros disponibles
- Listar contenidos por género

### En Estadísticas
- **Contadores** de toda la plataforma
- **Top 5** de mejor valorados
- **Gráficos** de distribución por año
- **Promedio general** de valoraciones

---

## ?? Consejos para la Exposición

1. **Muestra phpMyAdmin** primero para explicar las 5 tablas
2. **Navega por la aplicación** mostrando cada funcionalidad
3. **Abre el código** de un modelo para mostrar las relaciones
4. **Muestra una consulta LINQ** en EstadisticasController
5. **Explica la tabla intermedia** ContenidoActores

---

## ?? Notas Importantes

- ?? El archivo `StreamingDB.sql` puede mostrar "errores" en Visual Studio porque usa sintaxis de **MySQL**, no SQL Server. Esto es **normal** y **no afecta** la aplicación.
- ? El archivo SQL debe ejecutarse en **MySQL** (phpMyAdmin), no en Visual Studio.
- ? Todos los archivos `.cs` (C#) compilan correctamente sin errores.

---

## ?? Estructura de Archivos Importantes

```
?? AE4_DWES_CarlosdeAldaGarcia/
??? ?? Controllers/          ? Lógica de negocio
?   ??? HomeController.cs
?   ??? ContenidosController.cs
?   ??? ActoresController.cs
?   ??? GenerosController.cs
?   ??? EstadisticasController.cs
?
??? ?? Models/               ? Clases de datos
?   ??? Genero.cs
?   ??? Actor.cs
?   ??? Contenido.cs
?   ??? ContenidoActor.cs
?   ??? Valoracion.cs
?
??? ?? Data/
?   ??? StreamingContext.cs  ? Configuración EF Core
?
??? ?? Views/                ? Vistas Razor
?   ??? ?? Home/
?   ??? ?? Contenidos/
?   ??? ?? Actores/
?   ??? ?? Generos/
?   ??? ?? Estadisticas/
?
??? ?? Database/
?   ??? StreamingDB.sql      ? Script de base de datos
?
??? appsettings.json         ? Configuración (cadena de conexión)
??? Program.cs               ? Configuración de la aplicación
```

---

## ? Características Destacadas para Mencionar

1. **5 tablas relacionadas** (cumple requisito de mínimo 4)
2. **Relación muchos a muchos** con tabla intermedia personalizada
3. **Vistas tipadas** (@model) en todas las páginas
4. **Consultas LINQ** avanzadas (Where, Include, GroupBy, Average, etc.)
5. **Página de estadísticas** con datos agregados
6. **Diseño responsive** con Bootstrap 5
7. **Búsquedas y filtros** dinámicos
8. **Datos generosos** (25 contenidos, 15 actores, 30+ valoraciones)

---

## ?? Cumplimiento de Requisitos

| Requisito | Estado | Detalles |
|-----------|--------|----------|
| ASP.NET Core MVC | ? | .NET 8.0 |
| Mínimo 4 tablas | ? | 5 tablas relacionadas |
| Entity Framework Core | ? | Con Pomelo.MySql |
| Carga generosa de datos | ? | 25 contenidos, 15 actores, 30+ valoraciones |
| Modelos, Controladores, Vistas | ? | Estructura MVC completa |
| Solo consulta | ? | No hay CRUD (Create, Update, Delete) |
| Asociaciones entre tablas | ? | 1:N y N:M |
| Variedad de consultas | ? | Con filtros y búsquedas |
| BD original | ? | Sistema de Streaming |
| Diseño ordenado | ? | Bootstrap 5 + Icons |
| Compila sin errores | ? | Código C# funcional |
| Página de estadísticas | ? | Con datos agregados LINQ |

---

**¡Éxito con tu exposición! ??**
