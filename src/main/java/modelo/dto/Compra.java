package modelo.dto;

import java.time.LocalDate;

public class Compra {
    private int idCompra;
    private LocalDate fecha; 
    private double total;
    private String tipopago;
    private String direccion;
    private String distrito;
    private int idUsuario;

    public Compra() {
    }

    public Compra(int idCompra, LocalDate fecha, double total, String tipopago, String direccion, String distrito, int idUsuario) {
        this.idCompra = idCompra;
        this.fecha = fecha;
        this.total = total;
        this.tipopago = tipopago;
        this.direccion = direccion;
        this.distrito = distrito;
        this.idUsuario = idUsuario;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getTipopago() {
        return tipopago;
    }

    public void setTipopago(String tipopago) {
        this.tipopago = tipopago;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }


    
    
}
