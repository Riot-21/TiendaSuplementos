package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.dto.Categoria;
import modelo.dto.Producto;
import servicios.conexion.ConexionBD;

public class ProductoDao {
    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;
    
    public void agregarProducto(Producto prod)throws SQLException{
        String query ="insert into productos(nombre, descripcion, stock, marca, preciounit, mod_empleo, advert) values(?,?,?,?,?,?,?)";
        try{
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            
        }catch(SQLException ex){
            System.out.println("Error: "+ex.getMessage());
        }
    }
    
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
