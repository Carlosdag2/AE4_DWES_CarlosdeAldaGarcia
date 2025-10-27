using System.ComponentModel.DataAnnotations;

namespace AE4_DWES_CarlosdeAldaGarcia.Models
{
    public class Valoracion
    {
        [Key]
        public int Id { get; set; }
        public int ContenidoId { get; set; }
        public Contenido Contenido { get; set; } = null!;

        public string NombreUsuario { get; set; } = string.Empty;
        public int Puntuacion { get; set; } // De 1 a 5 estrellas
        public string? Comentario { get; set; }
        public DateTime FechaValoracion { get; set; }
    }
}
