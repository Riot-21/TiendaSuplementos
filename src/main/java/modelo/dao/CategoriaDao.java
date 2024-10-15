package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import servicios.conexion.ConexionBD;
import modelo.dto.Categoria;

public class CategoriaDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public List<Categoria> getAllCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        String query = "SELECT * FROM categorias"; // Asegúrate de que el nombre de la tabla sea correcto

        try{
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs= ps.executeQuery();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria")); // Asegúrate de que el nombre de la columna sea correcto
                categoria.setCategoria(rs.getString("categoria"));
                categoria.setObjetivo(rs.getString("objetivo"));// Asegúrate de que el nombre de la columna sea correcto
                // Si tienes más atributos, añádelos aquí
                categorias.add(categoria);
                
                System.out.println("Categorías recuperadas: " + categorias.size());
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores, considera un mejor manejo de excepciones
        }
        return categorias;
    }

    public void agregarCategoria(Categoria cat) throws SQLException {
        String query = "insert into categorias (categoria, objetivo) values (?,?)";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, cat.getCategoria());
            ps.setString(2, cat.getObjetivo());
            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }
    }

    // Método para obtener una categoría por su nombre
    public Categoria obtenerCategoriaPorNombre(String nombre) throws SQLException {
        String query = "SELECT * FROM categorias WHERE categoria = ?";
        Categoria categoria = null; // Inicializar la categoría a null
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, nombre);
            rs = ps.executeQuery();

            if (rs.next()) { // Verificar si se encontró algún resultado
                categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("id_categoria")); // Asegúrate de tener este campo en tu tabla
                categoria.setCategoria(rs.getString("categoria"));
                categoria.setObjetivo(rs.getString("objetivo"));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return categoria; // Retorna la categoría encontrada o null si no se encontró
    }
}
