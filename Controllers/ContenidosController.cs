using AE4_DWES_CarlosdeAldaGarcia.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Controllers
{
    public class ContenidosController : Controller
    {
        private readonly StreamingContext _context;

        public ContenidosController(StreamingContext context)
        {
            _context = context;
        }

        // GET: Contenidos
        public async Task<IActionResult> Index(string? tipo, int? generoId)
        {
            var contenidos = _context.Contenidos
                .Include(c => c.Genero)
                .Include(c => c.Valoraciones)
                .AsQueryable();

            // Filtro por tipo
            if (!string.IsNullOrEmpty(tipo))
            {
                if (tipo == "Pelicula")
                    contenidos = contenidos.Where(c => c.Tipo == Models.TipoContenido.Pelicula);
                else if (tipo == "Serie")
                    contenidos = contenidos.Where(c => c.Tipo == Models.TipoContenido.Serie);
            }

            // Filtro por género
            if (generoId.HasValue)
            {
                contenidos = contenidos.Where(c => c.GeneroId == generoId.Value);
            }

            ViewBag.Generos = await _context.Generos.ToListAsync();
            ViewBag.TipoSeleccionado = tipo;
            ViewBag.GeneroSeleccionado = generoId;

            return View(await contenidos.OrderByDescending(c => c.FechaEstreno).ToListAsync());
        }

        // GET: Contenidos/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var contenido = await _context.Contenidos
                .Include(c => c.Genero)
                .Include(c => c.ContenidoActores)
                    .ThenInclude(ca => ca.Actor)
                .Include(c => c.Valoraciones)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (contenido == null)
            {
                return NotFound();
            }

            return View(contenido);
        }

        // GET: Contenidos/Buscar
        public async Task<IActionResult> Buscar(string termino)
        {
            if (string.IsNullOrEmpty(termino))
            {
                return RedirectToAction(nameof(Index));
            }

            var contenidos = await _context.Contenidos
                .Include(c => c.Genero)
                .Include(c => c.Valoraciones)
                .Where(c => c.Titulo.Contains(termino) || 
                           c.Director.Contains(termino) ||
                           c.Descripcion.Contains(termino))
                .ToListAsync();

            ViewBag.Termino = termino;
            return View(contenidos);
        }
    }
}
