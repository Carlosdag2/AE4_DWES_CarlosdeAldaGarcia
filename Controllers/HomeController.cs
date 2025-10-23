using System.Diagnostics;
using AE4_DWES_CarlosdeAldaGarcia.Data;
using AE4_DWES_CarlosdeAldaGarcia.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly StreamingContext _context;

        public HomeController(ILogger<HomeController> logger, StreamingContext context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            // Obtener contenido destacado para la página principal
            var contenidosDestacados = await _context.Contenidos
                .Include(c => c.Genero)
                .Include(c => c.Valoraciones)
                .OrderByDescending(c => c.FechaEstreno)
                .Take(6)
                .ToListAsync();

            return View(contenidosDestacados);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
