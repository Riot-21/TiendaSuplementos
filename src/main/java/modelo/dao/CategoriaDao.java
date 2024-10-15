package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import servicios.conexion.ConexionBD;
import modelo.dto.Categoria;

public class CategoriaDao {
    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;
    
    public void agregarCategoria(Categoria cat)throws SQLException{
        String query = "insert into categorias (categoria, objetivo) values (?,?)";
        try{
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, cat.getCategoria());
            ps.setString(2, cat.getObjetivo());
            ps.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error: "+ex.getMessage());
        }
    }
}
