using AE4_DWES_CarlosdeAldaGarcia.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Controllers
{
    public class ActoresController : Controller
    {
        private readonly StreamingContext _context;

        public ActoresController(StreamingContext context)
        {
            _context = context;
        }

        // GET: Actores
        public async Task<IActionResult> Index(string? buscar)
        {
            var actores = _context.Actores
                .Include(a => a.ContenidoActores)
                    .ThenInclude(ca => ca.Contenido)
                .AsQueryable();

            if (!string.IsNullOrEmpty(buscar))
            {
                actores = actores.Where(a => a.Nombre.Contains(buscar) || 
                                            a.Apellidos.Contains(buscar) ||
                                            a.Nacionalidad.Contains(buscar));
            }

            ViewBag.Buscar = buscar;
            return View(await actores.OrderBy(a => a.Apellidos).ToListAsync());
        }

        // GET: Actores/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var actor = await _context.Actores
                .Include(a => a.ContenidoActores)
                    .ThenInclude(ca => ca.Contenido)
                        .ThenInclude(c => c.Genero)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (actor == null)
            {
                return NotFound();
            }

            return View(actor);
        }
    }
}
