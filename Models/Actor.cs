namespace AE4_DWES_CarlosdeAldaGarcia.Models
{
    public class Actor
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Apellidos { get; set; } = string.Empty;
        public DateTime FechaNacimiento { get; set; }
        public string Nacionalidad { get; set; } = string.Empty;
        public string? Biografia { get; set; }

        // Relaci�n muchos a muchos con Contenidos
        public ICollection<ContenidoActor> ContenidoActores { get; set; } = new List<ContenidoActor>();
    }
}
