# ?? Gu�a R�pida de Inicio - StreamFlix

## ? Pasos R�pidos para Ejecutar el Proyecto

### Paso 1: Preparar MySQL
1. Abre **XAMPP** y arranca **Apache** y **MySQL**
2. Abre tu navegador y ve a `http://localhost/phpmyadmin`

### Paso 2: Crear la Base de Datos
1. En phpMyAdmin, haz clic en **"SQL"** (arriba)
2. Abre el archivo `Database/StreamingDB.sql` en un editor de texto
3. **Copia TODO el contenido** del archivo SQL
4. **Pega** en el cuadro de texto de phpMyAdmin
5. Haz clic en **"Continuar"** o **"Ejecutar"**

? **Resultado:** Ver�s que se cre� la base de datos `StreamingDB` con 5 tablas y datos

### Paso 3: Verificar la Conexi�n
1. Abre el archivo `appsettings.json` del proyecto
2. Verifica que la cadena de conexi�n sea correcta:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost;Database=StreamingDB;User=root;Password=;"
   }
   ```
3. **Si tu MySQL tiene contrase�a**, c�mbiala en `Password=tucontrase�a`

### Paso 4: Ejecutar la Aplicaci�n
1. Abre el proyecto en **Visual Studio 2022**
2. Presiona **F5** o haz clic en el bot�n ?? **"IIS Express"**
3. Espera a que se abra el navegador autom�ticamente

? **�Listo!** La aplicaci�n deber�a estar funcionando

---

## ?? Verificaciones R�pidas

### �MySQL est� corriendo?
- Abre XAMPP ? Apache y MySQL deben estar en **verde**

### �La base de datos existe?
- Ve a phpMyAdmin ? Deber�as ver `StreamingDB` en la lista de la izquierda

### �Hay datos en las tablas?
- Haz clic en `StreamingDB` ? Deber�as ver 5 tablas:
  - Generos
  - Actores
  - Contenidos
  - ContenidoActores
  - Valoraciones

---

## ?? Soluci�n de Problemas Comunes

### Error: "Unable to connect to any of the specified MySQL hosts"
**Soluci�n:** MySQL no est� corriendo
- Abre XAMPP
- Inicia el servicio MySQL
- Reinicia la aplicaci�n

### Error: "Unknown database 'StreamingDB'"
**Soluci�n:** La base de datos no se cre�
- Ve al **Paso 2** y ejecuta el script SQL completo

### Error: "Access denied for user 'root'@'localhost'"
**Soluci�n:** La contrase�a de MySQL es incorrecta
- En `appsettings.json`, ajusta `Password=` con tu contrase�a de MySQL

### Los datos no aparecen
**Soluci�n:** El script SQL se ejecut� parcialmente
- En phpMyAdmin, elimina la base de datos `StreamingDB`
- Ejecuta el script SQL completo nuevamente

---

## ?? Datos Incluidos en la Base de Datos

Despu�s de ejecutar el script SQL, tendr�s:
- ? **10 g�neros** (Acci�n, Drama, Comedia, Ciencia Ficci�n, etc.)
- ? **15 actores** famosos (Leonardo DiCaprio, Scarlett Johansson, etc.)
- ? **25 contenidos** (pel�culas y series ic�nicas)
- ? **15+ relaciones** entre actores y contenidos
- ? **30+ valoraciones** de usuarios

---

## ?? Funcionalidades a Probar

### En la P�gina Principal
- Ver�s los 6 contenidos m�s recientes
- Cada tarjeta muestra tipo, g�nero, a�o y valoraciones

### En Contenidos
- **Filtrar** por tipo (Pel�cula/Serie) y g�nero
- **Buscar** por texto en t�tulo, director o descripci�n
- **Ver detalles** con reparto completo y valoraciones

### En Actores
- **Buscar** actores por nombre o nacionalidad
- Ver la **filmograf�a completa** de cada actor

### En G�neros
- Ver todos los g�neros disponibles
- Listar contenidos por g�nero

### En Estad�sticas
- **Contadores** de toda la plataforma
- **Top 5** de mejor valorados
- **Gr�ficos** de distribuci�n por a�o
- **Promedio general** de valoraciones

---

## ?? Consejos para la Exposici�n

1. **Muestra phpMyAdmin** primero para explicar las 5 tablas
2. **Navega por la aplicaci�n** mostrando cada funcionalidad
3. **Abre el c�digo** de un modelo para mostrar las relaciones
4. **Muestra una consulta LINQ** en EstadisticasController
5. **Explica la tabla intermedia** ContenidoActores

---

## ?? Notas Importantes

- ?? El archivo `StreamingDB.sql` puede mostrar "errores" en Visual Studio porque usa sintaxis de **MySQL**, no SQL Server. Esto es **normal** y **no afecta** la aplicaci�n.
- ? El archivo SQL debe ejecutarse en **MySQL** (phpMyAdmin), no en Visual Studio.
- ? Todos los archivos `.cs` (C#) compilan correctamente sin errores.

---

## ?? Estructura de Archivos Importantes

```
?? AE4_DWES_CarlosdeAldaGarcia/
??? ?? Controllers/          ? L�gica de negocio
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
?   ??? StreamingContext.cs  ? Configuraci�n EF Core
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
??? appsettings.json         ? Configuraci�n (cadena de conexi�n)
??? Program.cs               ? Configuraci�n de la aplicaci�n
```

---

## ? Caracter�sticas Destacadas para Mencionar

1. **5 tablas relacionadas** (cumple requisito de m�nimo 4)
2. **Relaci�n muchos a muchos** con tabla intermedia personalizada
3. **Vistas tipadas** (@model) en todas las p�ginas
4. **Consultas LINQ** avanzadas (Where, Include, GroupBy, Average, etc.)
5. **P�gina de estad�sticas** con datos agregados
6. **Dise�o responsive** con Bootstrap 5
7. **B�squedas y filtros** din�micos
8. **Datos generosos** (25 contenidos, 15 actores, 30+ valoraciones)

---

## ?? Cumplimiento de Requisitos

| Requisito | Estado | Detalles |
|-----------|--------|----------|
| ASP.NET Core MVC | ? | .NET 8.0 |
| M�nimo 4 tablas | ? | 5 tablas relacionadas |
| Entity Framework Core | ? | Con Pomelo.MySql |
| Carga generosa de datos | ? | 25 contenidos, 15 actores, 30+ valoraciones |
| Modelos, Controladores, Vistas | ? | Estructura MVC completa |
| Solo consulta | ? | No hay CRUD (Create, Update, Delete) |
| Asociaciones entre tablas | ? | 1:N y N:M |
| Variedad de consultas | ? | Con filtros y b�squedas |
| BD original | ? | Sistema de Streaming |
| Dise�o ordenado | ? | Bootstrap 5 + Icons |
| Compila sin errores | ? | C�digo C# funcional |
| P�gina de estad�sticas | ? | Con datos agregados LINQ |

---

**��xito con tu exposici�n! ??**
