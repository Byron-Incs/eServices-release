/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.eServices.dao;

import java.awt.Image;
import java.io.Serializable;

/**
 *
 * @author delar
 */
public class Servicio implements Serializable{

    public int getId_servicio() {
        return id_servicio;
    }

    public void setId_servicio(int id_servicio) {
        this.id_servicio = id_servicio;
    }

    public String getNombreS() {
        return nombreS;
    }

    public void setNombreS(String nombreS) {
        this.nombreS = nombreS;
    }

    public String getDescripcionS() {
        return descripcionS;
    }

    public void setDescripcionS(String descripcionS) {
        this.descripcionS = descripcionS;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public Image getFotoS() {
        return fotoS;
    }

    public void setFotoS(Image fotoS) {
        this.fotoS = fotoS;
    }
    private int id_servicio; 
    private String nombreS;
    private String descripcionS;
    private String precio;
    private String categoria;
    private Image fotoS;

  
    
    
    
    
}
