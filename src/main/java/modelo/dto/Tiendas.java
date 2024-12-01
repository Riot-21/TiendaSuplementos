
package modelo.dto;

public class Tiendas {
    private int idTienda;
    private String distrito;
    private String direccion;
    private int telefono;
    private String horario;

    public Tiendas() {
    }

    public Tiendas(int idTienda, String distrito, String direccion, int telefono, String horario) {
        this.idTienda = idTienda;
        this.distrito = distrito;
        this.direccion = direccion;
        this.telefono = telefono;
        this.horario = horario;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public int getIdTienda() {
        return idTienda;
    }

    public void setIdTienda(int idTienda) {
        this.idTienda = idTienda;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }
    
    
}
