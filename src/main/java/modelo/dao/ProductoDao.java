package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import modelo.dto.Categoria;
import modelo.dto.ImgProd;
import modelo.dto.Producto;
import servicios.conexion.ConexionBD;

public class ProductoDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public void agregarProducto(Producto prod) throws SQLException {
        String query = "insert into productos(nombre, descripcion, stock, marca, preciounit, mod_empleo, advert) values(?,?,?,?,?,?,?)";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, prod.getNombre());
            ps.setString(2, prod.getDescripcion());
            ps.setInt(3, prod.getStock());
            ps.setString(4, prod.getMarca());
            ps.setDouble(5, prod.getPreciounit());
            ps.setString(6, prod.getMod_empleo());
            ps.setString(7, prod.getAdvert());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int idprod = rs.getInt(1);
                //Insertar relacion con categorias
                String queryProdCat = "insert into prodCategoria (id_producto, id_categoria) values (?,?)";
                ps = cnx.prepareStatement(queryProdCat);

                for (Categoria cat : prod.getCategorias()) {
                    ps.setInt(1, idprod);
                    ps.setInt(2, cat.getIdCategoria());
                    ps.addBatch();
                }
                ps.executeBatch();

                String queryImgProd = "insert into imgProd (imagen, id_producto) values (?, ?)";
                ps = cnx.prepareStatement(queryImgProd);
                for (ImgProd img : prod.getImagenes()) {
                    ps.setString(1, img.getImagen());
                    ps.setInt(2, idprod);
                    ps.addBatch();  // Batch para múltiples inserciones de imágenes
                }
                ps.executeBatch();

            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }
    }

}
