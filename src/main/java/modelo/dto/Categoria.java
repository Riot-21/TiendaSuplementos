package modelo.dto;

public class Categoria {
    
    private int idCategoria;
    private String categoria;
    private String objetivo;

    public Categoria() {}

    public Categoria(int idCategoria, String categoria, String objetivo) {
        this.idCategoria = idCategoria;
        this.categoria = categoria;
        this.objetivo = objetivo;
    }

    public String getObjetivo() {
        return objetivo;}
    public void setObjetivo(String objetivo) {
        this.objetivo = objetivo;}

    public int getIdCategoria() {
        return idCategoria;}
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;}

    public String getCategoria() {
        return categoria;}
    public void setCategoria(String categoria) {
        this.categoria = categoria;}
    
    
}
