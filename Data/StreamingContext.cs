using AE4_DWES_CarlosdeAldaGarcia.Models;
using Microsoft.EntityFrameworkCore;

namespace AE4_DWES_CarlosdeAldaGarcia.Data
{
    public class StreamingContext : DbContext
    {
        public StreamingContext(DbContextOptions<StreamingContext> options) : base(options)
        {
        }

        public DbSet<Genero> Generos { get; set; }
        public DbSet<Actor> Actores { get; set; }
        public DbSet<Contenido> Contenidos { get; set; }
        public DbSet<ContenidoActor> ContenidoActores { get; set; }
        public DbSet<Valoracion> Valoraciones { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuración de la tabla intermedia ContenidoActor
            modelBuilder.Entity<ContenidoActor>()
                .HasKey(ca => new { ca.ContenidoId, ca.ActorId });

            modelBuilder.Entity<ContenidoActor>()
                .HasOne(ca => ca.Contenido)
                .WithMany(c => c.ContenidoActores)
                .HasForeignKey(ca => ca.ContenidoId);

            modelBuilder.Entity<ContenidoActor>()
                .HasOne(ca => ca.Actor)
                .WithMany(a => a.ContenidoActores)
                .HasForeignKey(ca => ca.ActorId);

            // Configuración de Contenido
            modelBuilder.Entity<Contenido>()
                .HasOne(c => c.Genero)
                .WithMany(g => g.Contenidos)
                .HasForeignKey(c => c.GeneroId);

            modelBuilder.Entity<Contenido>()
                .Property(c => c.Tipo)
                .HasConversion<string>();

            // Configuración de Valoracion
            modelBuilder.Entity<Valoracion>()
                .HasOne(v => v.Contenido)
                .WithMany(c => c.Valoraciones)
                .HasForeignKey(v => v.ContenidoId);
        }
    }
}
