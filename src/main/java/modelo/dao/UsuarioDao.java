package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Usuario;
import servicios.conexion.ConexionBD;

public class UsuarioDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public List<Usuario> listarUsuarios() throws SQLException {
        List<Usuario> listaUsuarios = new ArrayList<>();
        String query = "select * from usuarios";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Usuario user = new Usuario();
                user.setIdUsuario(rs.getInt("id_usuario"));
                user.setNombres(rs.getString("nombres"));
                user.setApellidos(rs.getString("apellidos"));
                user.setEmail(rs.getString("email"));
                user.setContraseña(rs.getString("contraseña"));
                user.setDni(rs.getInt("dni"));
                user.setTelefono(rs.getInt("telefono"));

                listaUsuarios.add(user);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Error: " + ex.getMessage());
        }
        return listaUsuarios;
    }

    public boolean registroUsuario(Usuario user) throws SQLException {
        String query = "INSERT INTO usuarios (nombres, apellidos, email, contraseña, dni, telefono) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, user.getNombres());
            ps.setString(2, user.getApellidos());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getContraseña());
            ps.setInt(5, user.getDni());
            ps.setInt(6, user.getTelefono());

            System.out.println("DEPUES DEL EXECUTE UPDATE: " + user.getApellidos());

            ps.executeUpdate();

            return true;

        } catch (SQLException e) {
            System.out.println("Error en la base de datos: " + e.getMessage());
            return false;
        }

    }

    public Usuario validarUsuario(String email, String contraseña) throws SQLException {
        Usuario user = null;
        String query = "select * from usuarios where email = ? and contraseña = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new Usuario();
                user.setIdUsuario(rs.getInt("id_usuario"));
                user.setNombres(rs.getString("nombres"));
                user.setApellidos(rs.getString("apellidos"));
                user.setEmail(rs.getString("email"));
                user.setContraseña(rs.getString("contraseña"));
                user.setDni(rs.getInt("dni"));
                user.setTelefono(rs.getInt("telefono"));

            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return user;

    }

    public boolean eliminarUsuario(int idUsuario) throws SQLException {
        String query = "DELETE FROM usuarios WHERE id_usuario = ?";
        boolean eliminado = false;

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setInt(1, idUsuario); // Establecer el ID del usuario a eliminar

            // Ejecutar la sentencia y verificar si eliminó alguna fila
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                eliminado = true; // Usuario eliminado correctamente
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Error al eliminar usuario: " + ex.getMessage());
        } 

        return eliminado;
    }

}
