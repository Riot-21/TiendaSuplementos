package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import servicios.conexion.ConexionBD;

public class CompraDao {
    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;
    
        public int generarCompra(Compra compra, List<Carrito> carritoItems) throws SQLException{
            String query = "insert into compra (fecha, total,tipo_pago, direccion, distrito, id_usuario) values(?,?,?,?,?,?)";
            int idCompra=0;
            try{
                cnx = new ConexionBD().getConexion();
                ps = cnx.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
                ps.setDate(1, java.sql.Date.valueOf(compra.getFecha()));
                ps.setDouble(2, compra.getTotal());
                ps.setString(3, compra.getTipopago());
                ps.setString(4, compra.getDireccion());
                ps.setString(5, compra.getDistrito());
                ps.setInt(6, compra.getIdUsuario());
                ps.executeUpdate();
                
                rs = ps.getGeneratedKeys();
                if(rs.next()){
                     idCompra = rs.getInt(1);
                    
                    String queryDetalle="insert into detalleCompra (item, cantidad, preciouni, subtotal, id_producto, id_compra) values(?,?,?,?,?,?)";
                    ps = cnx.prepareStatement(queryDetalle);
                    
                    for(Carrito item : carritoItems){
                        ps.setInt(1, item.getItem());
                        ps.setInt(2, item.getCantidad());
                        ps.setDouble(3, item.getPrecio());
                        ps.setDouble(4, item.getSubtotal());
                        ps.setInt(5, item.getIdProducto());
                        ps.setInt(6, idCompra);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }catch(SQLException ex){
                System.out.println("error: "+ex);
                throw ex;
            }
            return idCompra;
        }
        
        public void actualizarStock(int idProducto, int cantidadComprada) throws SQLException{
            String sql ="update productos set stock = stock - ? where id_producto = ?";
            try{
                cnx = new ConexionBD().getConexion();
                ps=cnx.prepareStatement(sql);
                ps.setInt(1, cantidadComprada);
                ps.setInt(2, idProducto);
                ps.executeUpdate();
            }catch(SQLException ex){
                throw ex;
            }
        }
    
    
}
