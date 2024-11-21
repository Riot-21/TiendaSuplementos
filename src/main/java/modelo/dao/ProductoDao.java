package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
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

    public Producto obtenerProductoPorId(int id) throws SQLException {
        Producto producto = null;
        String query = "SELECT p.id_producto, p.nombre, p.descripcion, p.stock, p.marca, p.preciounit, "
                + "p.mod_empleo, p.advert, i.imagen "
                + "FROM productos p "
                + "LEFT JOIN imgProd i ON p.id_producto = i.id_producto "
                + "WHERE p.id_producto = ?";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setInt(1, id); // Usamos el ID para la búsqueda
            rs = ps.executeQuery();

            if (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setStock(rs.getInt("stock"));
                producto.setMarca(rs.getString("marca"));
                producto.setPreciounit(rs.getDouble("preciounit"));
                producto.setMod_empleo(rs.getString("mod_empleo"));
                producto.setAdvert(rs.getString("advert"));

                // Crear lista de imágenes
                List<ImgProd> imagenes = new ArrayList<>();
                do {
                    ImgProd img = new ImgProd();
                    img.setImagen(rs.getString("imagen"));
                    imagenes.add(img);
                } while (rs.next()); // Continúa agregando imágenes si las hay

                producto.setImagenes(imagenes); // Establecer la lista de imágenes
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
            throw ex;
        }
        cnx.close();
        return producto;
    }

    public List<Producto> obtenerTodosLosProductos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT * FROM productos";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto")); // Asegúrate de tener el método setId en Producto
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setStock(rs.getInt("stock"));
                producto.setMarca(rs.getString("marca"));
                producto.setPreciounit(rs.getDouble("preciounit"));
                producto.setMod_empleo(rs.getString("mod_empleo"));
                producto.setAdvert(rs.getString("advert"));

                productos.add(producto);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return productos;
    }

    public List<Producto> ProductosTienda() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.id_producto, p.nombre, p.preciounit, p.stock , MIN(i.imagen) AS imagen\n"
                + "FROM productos p\n"
                + "INNER JOIN imgProd i ON p.id_producto = i.id_producto\n"
                + "GROUP BY p.id_producto, p.nombre, p.preciounit, p.stock;";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPreciounit(rs.getDouble("preciounit"));
                producto.setStock(rs.getInt("stock"));

                ImgProd img = new ImgProd();
                img.setImagen(rs.getString("imagen"));
                producto.setImagenes(Collections.singletonList(img));

                productos.add(producto);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return productos;
    }

}
