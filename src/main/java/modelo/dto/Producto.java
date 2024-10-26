package modelo.dto;

import java.util.List;

public class Producto {
    
    private int idProducto;
    private String nombre;
    private String descripcion;
    private int stock;
    private String marca;
    private double preciounit;
    private String mod_empleo;
    private String advert;
    
    private List<Categoria> categorias;
    private List<ImgProd> imagenes;

    public Producto() {
    }

    public Producto(int idProducto, String nombre, String descripcion, int stock, String marca, double preciounit, String mod_empleo, String advert, List<Categoria> categorias, List<ImgProd> imagenes) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.stock = stock;
        this.marca = marca;
        this.preciounit = preciounit;
        this.mod_empleo = mod_empleo;
        this.advert = advert;
        this.categorias = categorias;
        this.imagenes = imagenes;
    }

    public List<ImgProd> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<ImgProd> imagenes) {
        this.imagenes = imagenes;
    }

    public List<Categoria> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categoria> categorias) {
        this.categorias = categorias;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public double getPreciounit() {
        return preciounit;
    }

    public void setPreciounit(double preciounit) {
        this.preciounit = preciounit;
    }

    public String getMod_empleo() {
        return mod_empleo;
    }

    public void setMod_empleo(String mod_empleo) {
        this.mod_empleo = mod_empleo;
    }

    public String getAdvert() {
        return advert;
    }

    public void setAdvert(String advert) {
        this.advert = advert;
    }
    
    

}
