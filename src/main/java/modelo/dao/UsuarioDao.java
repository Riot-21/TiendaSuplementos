package modelo.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Usuario;
import servicios.conexion.ConexionBD;

public class UsuarioDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public boolean actualizarContraseña(int idUsuario, String nuevaContraseña) throws SQLException {
        String query = "UPDATE usuarios SET contraseña = ? WHERE id_usuario = ?";

        try {
            // Conexión a la base de datos
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);

            // Hashear la nueva contraseña
            String hashedPassword = hashPassword(nuevaContraseña);

            // Establecer los parámetros para la consulta
            ps.setString(1, hashedPassword);  // Nueva contraseña hasheada
            ps.setInt(2, idUsuario);           // ID del usuario

            // Ejecutar la actualización
            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Contraseña actualizada exitosamente.");
                return true;  // Se actualizó correctamente
            } else {
                System.out.println("No se encontró el usuario para actualizar la contraseña.");
                return false;  // No se encontró el usuario o no se actualizó
            }

        } catch (SQLException e) {
            System.out.println("Error al actualizar la contraseña: " + e.getMessage());
            return false;  // Error al ejecutar la consulta
        }
    }

    // Método para hashear contraseñas con SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar la contraseña", e);
        }
    }

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

            //Hash de la contraseña
            String hasehdPassword = hashPassword(user.getContraseña());
            ps.setString(4, hasehdPassword);
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

    public Usuario validarUsuarioEmail(String email) throws SQLException {
        Usuario user = null;
        String query = "select * from usuarios where email = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, email);
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

    public Usuario validarUsuario(String email, String contraseña) throws SQLException {
        Usuario user = null;
        String query = "select * from usuarios where email = ? and contraseña = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, email);

            //Hashear la contraseña proporcionada por el usuario
            String hashedPass = hashPassword(contraseña);
            ps.setString(2, hashedPass);
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
    // Método para verificar si ya existe un email o DNI en la base de datos

    public boolean existeUsuario(String email, int dni) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM usuarios WHERE email = ? OR dni = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, email);
            ps.setInt(2, dni);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("count") > 0; // Si el count > 0, existe un usuario con ese email o DNI
            }
        } catch (SQLException ex) {
            System.out.println("Error al verificar existencia de usuario: " + ex.getMessage());
        }
        return false;
    }
    // Método para guardar el código temporal con su fecha de expiración

    public void guardarCodigoTemporal(int idUsuario, String codigo) throws SQLException {
        String sql = "INSERT INTO codigo_verificacion (id_usuario, codigo, fecha_creacion, fecha_expiracion) "
                + "VALUES (?, ?, CURRENT_TIMESTAMP, ?)";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            // Establecer los valores de la consulta
            ps.setInt(1, idUsuario);      // id_usuario
            ps.setString(2, codigo);      // código
            ps.setObject(3, LocalDateTime.now().plus(30, ChronoUnit.MINUTES)); // fecha_expiracion

            // Ejecutar la consulta
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al guardar el código temporal: " + e.getMessage());
            throw e;  // Propagar la excepción
        }
    }

    // Obtener el código de verificación del usuario
    public String obtenerCodigoVerificacion(int idUsuario) throws SQLException {
        String sql = "SELECT codigo FROM codigo_verificacion WHERE id_usuario = ? ORDER BY fecha_creacion DESC LIMIT 1";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("codigo");
            }
            return null;
        } catch (SQLException e) {
            System.err.println("Error al guardar el código temporal: " + e.getMessage());
            throw e;  // Propagar la excepción
        }
    }

// Verificar si el código ha expirado
    public boolean verificarExpiracionCodigo(int idUsuario) throws SQLException {
        String sql = "SELECT fecha_expiracion FROM codigo_verificacion WHERE id_usuario = ? ORDER BY fecha_creacion DESC LIMIT 1";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp fechaExpiracion = rs.getTimestamp("fecha_expiracion");
                LocalDateTime now = LocalDateTime.now();

                // Considerar una pequeña diferencia en la comparación
                long diferenciaMinutos = ChronoUnit.MINUTES.between(fechaExpiracion.toLocalDateTime(), now);

                // Si la diferencia es mayor que 0 minutos, el código ha expirado
                return diferenciaMinutos < 0;
            }
            return true; // Si no se encuentra el código, se considera expirado
        } catch (SQLException e) {
            System.err.println("Error al verificar la expiración del código: " + e.getMessage());
            throw e;  // Propagar la excepción
        }
    }
}
