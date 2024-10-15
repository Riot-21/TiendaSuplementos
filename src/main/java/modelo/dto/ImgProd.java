package modelo.dto;

public class ImgProd {
    
    private int id_img;
    private String imagen;
    private int id_producto;

    public ImgProd() {
    }

    public ImgProd(int id_img, String imagen, int id_producto) {
        this.id_img = id_img;
        this.imagen = imagen;
        this.id_producto = id_producto;
    }

    public int getId_producto() {
        return id_producto;
    }
    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getId_img() {
        return id_img;
    }
    public void setId_img(int id_img) {
        this.id_img = id_img;
    }

    public String getImagen() {
        return imagen;
    }
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
    
}
