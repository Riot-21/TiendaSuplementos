package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.dto.Empresa;
import servicios.conexion.ConexionBD;

public class EmpresaDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public Empresa datosEmpresa() throws SQLException {
        Empresa emp = new Empresa();
        String query = "select * from empresa";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                emp.setIdEmpresa(rs.getInt("id_empresa"));
                emp.setNombre(rs.getString("nombre"));
                emp.setRuc(rs.getString("ruc_empresa"));
                emp.setRazonSocial(rs.getString("razonSocial"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return emp;
    }

    public boolean actualizarDatosEmpresa(Empresa emp) throws SQLException {
        boolean actualizado = false;
        String query = "UPDATE empresa SET nombre = ?, ruc_empresa = ?, razonSocial = ? WHERE id_empresa = ?";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);

            // Establecer los valores de los parámetros
            ps.setString(1, emp.getNombre());
            ps.setString(2, emp.getRuc());
            ps.setString(3, emp.getRazonSocial());
            ps.setInt(4, emp.getIdEmpresa());

            // Ejecutar la actualización
            int filasAfectadas = ps.executeUpdate();
            actualizado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return actualizado;
    }

}
