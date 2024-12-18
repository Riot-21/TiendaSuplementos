package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Tiendas;
import servicios.conexion.ConexionBD;

public class TiendasDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public void eliminarTienda(int idTienda) throws SQLException {
        String query = "DELETE FROM tiendas WHERE id_tienda = ?";
        try {
            // Establecer la conexión
            cnx = new ConexionBD().getConexion();
            // Preparar la consulta SQL
            ps = cnx.prepareStatement(query);
            // Establecer el parámetro
            ps.setInt(1, idTienda);
            // Ejecutar la consulta para eliminar la tienda
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        } finally {
            // Asegurarse de cerrar la conexión si es necesario
            if (cnx != null) {
                try {
                    cnx.close();
                } catch (SQLException e) {
                    System.out.println("Error al cerrar la conexión: " + e.getMessage());
                }
            }
        }
    }

    public void actualizarTienda(Tiendas tienda) throws SQLException {
        String query = "UPDATE tiendas SET distrito = ?, direccion = ?, telefono = ?, horario = ? WHERE id_tienda = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);

            // Establecer los valores de los parámetros
            ps.setString(1, tienda.getDistrito());
            ps.setString(2, tienda.getDireccion());
            ps.setInt(3, tienda.getTelefono());
            ps.setString(4, tienda.getHorario());
            ps.setInt(5, tienda.getIdTienda());

            // Ejecutar la actualización
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }
    }

    public List<Tiendas> listarTiendas() throws SQLException {
        List<Tiendas> listaTiendas = new ArrayList<>();
        String query = "select * from tiendas";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Tiendas t = new Tiendas();
                t.setIdTienda(rs.getInt("id_tienda"));
                t.setDistrito(rs.getString("distrito"));
                t.setDireccion(rs.getString("direccion"));
                t.setTelefono(rs.getInt("telefono"));
                t.setHorario(rs.getString("horario"));
                t.setFoto(rs.getString("foto"));

                listaTiendas.add(t);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Error: " + ex.getMessage());
        }
        return listaTiendas;
    }

    public void agregarTienda(Tiendas tienda) throws SQLException {
        String query = "insert into tiendas (distrito, direccion, telefono, horario,foto) values (?,?,?,?,?)";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, tienda.getDistrito());
            ps.setString(2, tienda.getDireccion());
            ps.setInt(3, tienda.getTelefono());
            ps.setString(4, tienda.getHorario());
            ps.setString(5, tienda.getFoto());
            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }
    }

    public Tiendas GetTiendaById(int id) throws SQLException {
        String query = "select * from tiendas where id_tienda=?";
        Tiendas t = null;
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Tiendas();
                t.setIdTienda(rs.getInt("id_tienda"));
                t.setDistrito(rs.getString("distrito"));
                t.setDireccion(rs.getString("direccion"));
                t.setTelefono(rs.getInt("telefono"));
                t.setHorario(rs.getString("horario"));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }

        return t;
    }
}
