using System.ComponentModel.DataAnnotations;

namespace AE4_DWES_CarlosdeAldaGarcia.Models
{
    // Tabla intermedia para la relación muchos a muchos entre Contenido y Actor
    public class ContenidoActor
    {
        [Key]
        public int ContenidoId { get; set; }
        public Contenido Contenido { get; set; } = null!;

        public int ActorId { get; set; }
        public Actor Actor { get; set; } = null!;

        public string Papel { get; set; } = string.Empty; // Nombre del personaje
        public bool EsProtagonista { get; set; }
    }
}
