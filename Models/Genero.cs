using System.ComponentModel.DataAnnotations;

namespace AE4_DWES_CarlosdeAldaGarcia.Models
{
    public class Genero
    {
        [Key]
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;

        // Relación uno a muchos con Contenidos
        public ICollection<Contenido> Contenidos { get; set; } = new List<Contenido>();
    }
}
