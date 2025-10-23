namespace AE4_DWES_CarlosdeAldaGarcia.Models
{
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
        public int Duracion { get; set; } // En minutos para películas, promedio por episodio para series
        public TipoContenido Tipo { get; set; }
        public string Director { get; set; } = string.Empty;
        public string? Poster { get; set; }
        public DateTime FechaEstreno { get; set; }
        public int? NumeroTemporadas { get; set; } // Solo para series

        // Relación con Genero
        public int GeneroId { get; set; }
        public Genero Genero { get; set; } = null!;

        // Relación muchos a muchos con Actores
        public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();

        // Relación uno a muchos con Valoraciones
        public ICollection<Valoracion> Valoraciones { get; set; } = new List<Valoracion>();
    }
}
