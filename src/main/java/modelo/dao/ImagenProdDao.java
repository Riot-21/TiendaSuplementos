package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.dto.ImgProd;
import servicios.conexion.ConexionBD;

public class ImagenProdDao {
    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;
    
    public void agregarImagenes(ImgProd img)throws SQLException{
        String query = "insert into imgProd (imagen, id_producto) values (?,?)";
        try{
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setString(1, img.getImagen());
            ps.setInt(2, img.getId_producto());
            ps.executeUpdate();
            
        }catch(SQLException ex){
            System.out.println("Error: "+ex.getMessage());
        }
    }
}
