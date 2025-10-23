using AE4_DWES_CarlosdeAldaGarcia.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Controllers
{
    public class GenerosController : Controller
    {
        private readonly StreamingContext _context;

        public GenerosController(StreamingContext context)
        {
            _context = context;
        }

        // GET: Generos
        public async Task<IActionResult> Index()
        {
            var generos = await _context.Generos
                .Include(g => g.Contenidos)
                .ToListAsync();

            return View(generos);
        }

        // GET: Generos/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var genero = await _context.Generos
                .Include(g => g.Contenidos)
                    .ThenInclude(c => c.Valoraciones)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (genero == null)
            {
                return NotFound();
            }

            return View(genero);
        }
    }
}
