package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import servicios.conexion.ConexionBD;

public class CompraDao {

    Connection cnx;
    PreparedStatement ps;
    ResultSet rs;

    public int generarCompra(Compra compra, List<Carrito> carritoItems) throws SQLException {
        String query = "insert into compra (fecha, total,tipo_pago, direccion, distrito, estado ,id_usuario) values(?,?,?,?,?,?,?)";
        int idCompra = 0;
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, java.sql.Date.valueOf(compra.getFecha()));
            ps.setDouble(2, compra.getTotal());
            ps.setString(3, compra.getTipopago());
            ps.setString(4, compra.getDireccion());
            ps.setString(5, compra.getDistrito());
            ps.setString(6, "Pendiente");
            ps.setInt(7, compra.getIdUsuario());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idCompra = rs.getInt(1);

                String queryDetalle = "insert into detalleCompra (item, cantidad, preciouni, subtotal, id_producto, id_compra) values(?,?,?,?,?,?)";
                ps = cnx.prepareStatement(queryDetalle);

                for (Carrito item : carritoItems) {
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
        } catch (SQLException ex) {
            System.out.println("error: " + ex);
            throw ex;
        }
        return idCompra;
    }

    public void actualizarStock(int idProducto, int cantidadComprada) throws SQLException {
        String sql = "update productos set stock = stock - ? where id_producto = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, cantidadComprada);
            ps.setInt(2, idProducto);
            ps.executeUpdate();
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public Compra obtenerCompraId(int idCompra) throws SQLException {
        Compra c = new Compra();
        String query = "select * from compra where id_compra=?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(query);
            ps.setInt(1, idCompra);
            rs = ps.executeQuery();
            if (rs.next()) {
                c.setIdCompra(rs.getInt("id_compra"));
                c.setFecha(rs.getDate("fecha").toLocalDate());
                c.setTotal(rs.getDouble("total"));
                c.setTipopago(rs.getString("tipo_pago"));
                c.setDireccion(rs.getString("direccion"));
                c.setDistrito(rs.getString("distrito"));
                c.setEstado(rs.getString("estado"));
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return c;
    }

    public List<Compra> obtenerComprasPorUsuario(int idUsuario) throws SQLException {
        List<Compra> listaCompras = new ArrayList<>();
        String sql = "SELECT id_compra, fecha, total, tipo_pago, direccion, distrito, estado FROM compra WHERE id_usuario = ? ORDER BY fecha DESC";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            while (rs.next()) {
                Compra compra = new Compra();
                compra.setIdCompra(rs.getInt("id_compra"));
                compra.setFecha(rs.getDate("fecha").toLocalDate());
                compra.setTotal(rs.getDouble("total"));
                compra.setTipopago(rs.getString("tipo_pago"));
                compra.setDireccion(rs.getString("direccion"));
                compra.setDistrito(rs.getString("distrito"));
                compra.setEstado(rs.getString("estado"));
                listaCompras.add(compra);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return listaCompras;
    }

    public List<Compra> listarCompras() throws SQLException {
        List<Compra> listac = new ArrayList<>();
        String sql = "select * from compra";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Compra c = new Compra();
                c.setIdCompra(rs.getInt("id_compra"));
                c.setFecha(rs.getDate("fecha").toLocalDate());
                c.setTotal(rs.getDouble("total"));
                c.setTipopago(rs.getString("tipo_pago"));
                c.setDireccion(rs.getString("direccion"));
                c.setDistrito(rs.getString("distrito"));
                c.setEstado(rs.getString("estado"));
                c.setIdUsuario(rs.getInt("id_usuario"));
                listac.add(c);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return listac;
    }

    public List<Carrito> obtenerDetalleCompra(int idCompra) throws SQLException {
        List<Carrito> detalles = new ArrayList<>();
        String sql = "SELECT dc.item, dc.cantidad, dc.preciouni, dc.subtotal, dc.id_producto, p.nombre AS producto "
                + "FROM detalleCompra dc "
                + "INNER JOIN productos p ON dc.id_producto = p.id_producto "
                + "WHERE dc.id_compra = ?";
        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idCompra);
            rs = ps.executeQuery();
            while (rs.next()) {
                Carrito detalle = new Carrito();
                detalle.setItem(rs.getInt("item"));
                detalle.setIdProducto(rs.getInt("id_producto"));
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.setPrecio(rs.getDouble("preciouni"));
                detalle.setSubtotal(rs.getDouble("subtotal"));
                detalle.setNombres(rs.getString("producto"));
                detalles.add(detalle);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return detalles;
    }

    public boolean actualizarEstadoPedido(int idCompra,String estado) throws SQLException {
        boolean actualizado = false;
        String sql = "UPDATE compra SET estado = ? WHERE id_compra = ?";

        try {
            cnx = new ConexionBD().getConexion();
            ps = cnx.prepareStatement(sql);
            ps.setString(1, estado);
            ps.setInt(2, idCompra);

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                actualizado = true;
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return actualizado;
    }
    
    

}
