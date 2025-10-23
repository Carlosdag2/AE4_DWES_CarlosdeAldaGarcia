using AE4_DWES_CarlosdeAldaGarcia.Data;
using AE4_DWES_CarlosdeAldaGarcia.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Controllers
{
    public class EstadisticasController : Controller
    {
        private readonly StreamingContext _context;

        public EstadisticasController(StreamingContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var viewModel = new EstadisticasViewModel
            {
                TotalContenidos = await _context.Contenidos.CountAsync(),
                TotalPeliculas = await _context.Contenidos.CountAsync(c => c.Tipo == TipoContenido.Pelicula),
                TotalSeries = await _context.Contenidos.CountAsync(c => c.Tipo == TipoContenido.Serie),
                TotalActores = await _context.Actores.CountAsync(),
                TotalGeneros = await _context.Generos.CountAsync(),
                TotalValoraciones = await _context.Valoraciones.CountAsync(),

                PromedioValoracionGeneral = await _context.Valoraciones.AnyAsync() 
                    ? await _context.Valoraciones.AverageAsync(v => v.Puntuacion) 
                    : 0,

                ContenidosMejorValorados = await _context.Contenidos
                    .Include(c => c.Genero)
                    .Include(c => c.Valoraciones)
                    .Where(c => c.Valoraciones.Any())
                    .OrderByDescending(c => c.Valoraciones.Average(v => v.Puntuacion))
                    .Take(5)
                    .ToListAsync(),

                GenerosPopulares = await _context.Generos
                    .Include(g => g.Contenidos)
                    .OrderByDescending(g => g.Contenidos.Count)
                    .Take(5)
                    .ToListAsync(),

                ActoresDestacados = await _context.Actores
                    .Include(a => a.ContenidoActores)
                    .OrderByDescending(a => a.ContenidoActores.Count)
                    .Take(5)
                    .ToListAsync(),

                ContenidosRecientes = await _context.Contenidos
                    .Include(c => c.Genero)
                    .OrderByDescending(c => c.FechaEstreno)
                    .Take(5)
                    .ToListAsync(),

                DistribucionPorAnio = await _context.Contenidos
                    .GroupBy(c => c.Anio)
                    .Select(g => new { Anio = g.Key, Cantidad = g.Count() })
                    .OrderByDescending(x => x.Anio)
                    .Take(10)
                    .ToDictionaryAsync(x => x.Anio, x => x.Cantidad)
            };

            return View(viewModel);
        }
    }

    public class EstadisticasViewModel
    {
        public int TotalContenidos { get; set; }
        public int TotalPeliculas { get; set; }
        public int TotalSeries { get; set; }
        public int TotalActores { get; set; }
        public int TotalGeneros { get; set; }
        public int TotalValoraciones { get; set; }
        public double PromedioValoracionGeneral { get; set; }
        public List<Contenido> ContenidosMejorValorados { get; set; } = new();
        public List<Genero> GenerosPopulares { get; set; } = new();
        public List<Actor> ActoresDestacados { get; set; } = new();
        public List<Contenido> ContenidosRecientes { get; set; } = new();
        public Dictionary<int, int> DistribucionPorAnio { get; set; } = new();
    }
}
