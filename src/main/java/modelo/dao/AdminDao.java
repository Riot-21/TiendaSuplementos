package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.dto.Usuario;
import modelo.dto.Administrador;
import servicios.conexion.ConexionBD;

public class AdminDao {
    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;
    
        public boolean registroAdmin(Administrador admin) throws SQLException {
        String query = "INSERT INTO administrador (nombres, apellidos, email, contraseña, dni, telefono) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, admin.getNombres());
            ps.setString(2, admin.getApellidos());
            ps.setString(3, admin.getEmail());
            ps.setString(4, admin.getContraseña());
            ps.setInt(5, admin.getDni());
            ps.setInt(6, admin.getTelefono());

            ps.executeUpdate();

            return true;

        } catch (SQLException e) {
            System.out.println("Error en la base de datos: " + e.getMessage());
            return false;
        }

    }

    public Administrador validarAdmin(String email, String contraseña) throws SQLException {
        Administrador admin = null;
        String query = "select * from administrador where email = ? and contraseña = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, contraseña);
            rs = ps.executeQuery();

            if (rs.next()) {
                admin = new Administrador();
                admin.setIdAdmin(rs.getInt("id_admin"));
                admin.setNombres(rs.getString("nombres"));
                admin.setApellidos(rs.getString("apellidos"));
                admin.setEmail(rs.getString("email"));
                admin.setContraseña(rs.getString("contraseña"));
                admin.setDni(rs.getInt("dni"));
                admin.setTelefono(rs.getInt("telefono"));

            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return admin;

    }
}
