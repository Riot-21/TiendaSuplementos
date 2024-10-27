package modelo.dto;

public class Administrador {
    
    private int idAdmin;
    private String nombres;
    private String apellidos;
    private String email;
    private String contraseña;
    private int dni;
    private int telefono;

    public Administrador() {
    }

    public Administrador(int idAdmin, String nombres, String apellidos, String email, String contraseña, int dni, int telefono) {
        this.idAdmin = idAdmin;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.email = email;
        this.contraseña = contraseña;
        this.dni = dni;
        this.telefono = telefono;
    }

    public int getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }
    
    


}
