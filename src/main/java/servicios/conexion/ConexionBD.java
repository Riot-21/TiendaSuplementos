/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicios.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConexionBD {

//    private static final String URL = "jdbc:mysql://localhost:3306/bd_nutripoint?useTimeZone=true&serverTimezone=UTC&autoReconnect=true";
    private static final String URL = "jdbc:mysql://localhost:3306/bd_nutripoint?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Contraseña que puede varias
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public Connection getConexion() throws SQLException {
        Connection cnx = null;

        try {
            // Registrar el controlador JDBC
            Class.forName(DRIVER);

            // Intentar establecer la conexión
            System.out.println("Intentando conectar a la base de datos...");
            cnx = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión exitosa a la base de datos.");

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, "Error al cargar el controlador JDBC", ex);
            throw new SQLException("Error al cargar el controlador JDBC: " + ex.getMessage());
        } catch (SQLException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, "Error al conectar a la base de datos", ex);
            throw ex; // Re-lanza la excepción para que el llamador pueda manejarla
        }
        // Verifica si la conexión fue establecida antes de devolverla
        if (cnx != null) {
            return cnx;
        } else {
            throw new SQLException("No se pudo establecer la conexión a la base de datos.");
        }
    }
}
