package modelo.dao;

import servicios.conexion.ConexionBD;
import java.sql.ResultSet;
import modelo.dto.Usuario;

public class UsuarioDao {
    
    int rspta = 0;
    String sql = "";
    ResultSet rs = null;
    ConexionBD cn = new ConexionBD();
    public int validarLogin(Usuario user) throws Exception {
        sql = "SELECT COUNT(id) AS cantidad FROM usuario WHERE nombreUsuario='"+user.getNombreUsuario()+"' AND contraseña='"+user.getContraseña()+"'";
        rs = cn.ejecutarConsulta(sql);
        while(rs.next()) {
            rspta = rs.getInt("cantidad");
        }
        return rspta;
    }
    
}
