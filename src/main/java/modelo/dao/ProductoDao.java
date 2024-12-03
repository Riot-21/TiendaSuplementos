package modelo.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
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

    public boolean actualizarProducto(Producto prod) throws SQLException {
        boolean actualizado = false;
        String query = "UPDATE productos SET nombre = ?, descripcion = ?, stock = ?, marca = ?, preciounit = ?, mod_empleo = ?, advert = ? WHERE id_producto = ?";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);

            // Establecer los valores de los parámetros
            ps.setString(1, prod.getNombre());
            ps.setString(2, prod.getDescripcion());
            ps.setInt(3, prod.getStock());
            ps.setString(4, prod.getMarca());
            ps.setDouble(5, prod.getPreciounit());
            ps.setString(6, prod.getMod_empleo());
            ps.setString(7, prod.getAdvert());
            ps.setInt(8, prod.getIdProducto());

            // Ejecutar la actualización
            int filasAfectadas = ps.executeUpdate();
            actualizado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            System.out.println("Error al actualizar el producto: " + ex.getMessage());
            throw ex;
        }
        return actualizado;
    }

    public void agregarProducto(Producto prod) throws SQLException {
        String query = "insert into productos(nombre, descripcion, stock, marca, preciounit, mod_empleo, advert, fechav) values(?,?,?,?,?,?,?,?)";
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
            ps.setDate(8, java.sql.Date.valueOf(prod.getFechav()));
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
//metodo para el administrador

    public List<Producto> obtenerTodosLosProductos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT * FROM productos";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            rs = ps.executeQuery();

            LocalDate hoy = LocalDate.now();
            LocalDate limite = hoy.plusWeeks(2);

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
                Date fechaV = rs.getDate("fechav");
                if (fechaV != null) {
                    LocalDate fechav = fechaV.toLocalDate();
                    producto.setFechav(fechav);

                    // Verifica si está próximo a vencer
                    if (!fechav.isBefore(hoy) && !fechav.isAfter(limite)) {
                        producto.setMensajeProximoAVencer("¡Producto próximo a vencer!");
                    } else {
                        producto.setMensajeProximoAVencer(""); // Sin mensaje si no aplica
                    }
                } else {
                    producto.setMensajeProximoAVencer("Fecha de vencimiento no registrada.");
                }

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

    public List<Producto> obtenerProductosPorFiltros(List<Integer> categorias, String precio, String orden) throws SQLException {
        List<Producto> productos = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT p.id_producto, p.nombre, p.preciounit, p.stock, MIN(i.imagen) AS imagen "
                + "FROM productos p "
                + "INNER JOIN imgProd i ON p.id_producto = i.id_producto ");

        // Agregar filtros de categorías
        if (categorias != null && !categorias.isEmpty()) {
            query.append("INNER JOIN prodCategoria pc ON p.id_producto = pc.id_producto WHERE pc.id_categoria IN (");
            for (int i = 0; i < categorias.size(); i++) {
                query.append(categorias.get(i));
                if (i < categorias.size() - 1) {
                    query.append(", ");
                }
            }
            query.append(") ");
        }

        // Agregar filtros de precio
        if (precio != null) {
            if (precio.equals("lessThan50")) {
                query.append("AND p.preciounit < 50 ");
            } else if (precio.equals("50to100")) {
                query.append("AND p.preciounit BETWEEN 50 AND 100 ");
            } else if (precio.equals("moreThan100")) {
                query.append("AND p.preciounit > 100 ");
            }
        }

        // Añadir agrupación
        query.append("GROUP BY p.id_producto, p.nombre, p.preciounit, p.stock ");

        // Agregar ordenación basada en el parámetro
        if (orden != null) {
            switch (orden) {
                case "price-asc":
                    query.append("ORDER BY p.preciounit ASC ");
                    break;
                case "price-desc":
                    query.append("ORDER BY p.preciounit DESC ");
                    break;
                case "name-asc":
                    query.append("ORDER BY p.nombre ASC ");
                    break;
                case "name-desc":
                    query.append("ORDER BY p.nombre DESC ");
                    break;
                default:
                    break; // No ordenar si no se especifica
            }
        }

        // Ejecutar la consulta
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query.toString());
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

    //METODOS NUEVOS:
    public List<Producto> obtenerProductosMasVendidos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.id_producto, \n"
                + "       p.nombre, \n"
                + "       p.preciounit, \n"
                + "       p.stock, \n"
                + "       (SELECT i.imagen \n"
                + "        FROM imgProd i \n"
                + "        WHERE i.id_producto = p.id_producto \n"
                + "        LIMIT 1) AS imagen,\n"
                + "       SUM(dc.cantidad) AS ventas   -- Agregamos la suma de las cantidades como ventas\n"
                + "FROM productos p\n"
                + "INNER JOIN detalleCompra dc ON p.id_producto = dc.id_producto\n"
                + "WHERE p.stock > 0\n"
                + "GROUP BY p.id_producto, p.nombre, p.preciounit, p.stock\n"
                + "ORDER BY ventas DESC";

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
                producto.setVentas(rs.getInt("ventas"));
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

    public List<Producto> obtenerProductosConMenorPrecio() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.id_producto, p.nombre, p.preciounit, p.stock, "
                + "(SELECT i.imagen FROM imgProd i WHERE i.id_producto = p.id_producto LIMIT 1) AS imagen "
                + "FROM productos p "
                + "WHERE p.stock > 0 "
                + "ORDER BY p.preciounit ASC ";

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

    public List<Producto> obtenerProductosAleatorios() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.id_producto, p.nombre, p.preciounit, p.stock, "
                + "(SELECT i.imagen FROM imgProd i WHERE i.id_producto = p.id_producto LIMIT 1) AS imagen "
                + "FROM productos p "
                + "WHERE p.stock > 0 "
                + "ORDER BY RAND() ";

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

    public List<Producto> buscarProductosPorNombre(String nombre) throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String query = "SELECT p.id_producto, p.nombre, p.preciounit, p.stock, "
                + "(SELECT i.imagen FROM imgProd i WHERE i.id_producto = p.id_producto LIMIT 1) AS imagen "
                + "FROM productos p "
                + "WHERE p.nombre LIKE ?";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);

            // Usamos % para indicar que la búsqueda puede ser parcial
            ps.setString(1, "%" + nombre + "%");
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
