
package modelo.dto;

public class Empresa {
    private int idEmpresa;
    private String nombre;
    private String ruc;
    private String razonSocial;

    public Empresa() {
    }

    public Empresa(int idEmpresa, String nombre, String ruc, String razonSocial) {
        this.idEmpresa = idEmpresa;
        this.nombre = nombre;
        this.ruc = ruc;
        this.razonSocial = razonSocial;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public int getIdEmpresa() {
        return idEmpresa;
    }

    public void setIdEmpresa(int idEmpresa) {
        this.idEmpresa = idEmpresa;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    
}
