/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.eServices.dao;

import java.io.Serializable;

/**
 *
 * @author delar
 */
public class Tarjeta implements Serializable{
    private String num_tarjeta;
    private String ano;
    private String mes;
    private String cvv;
    private String nombre_tar;

    public String getNum_tarjeta() {
        return num_tarjeta;
    }

    public void setNum_tarjeta(String num_tarjeta) {
        this.num_tarjeta = num_tarjeta;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getNombre_tar() {
        return nombre_tar;
    }

    public void setNombre_tar(String nombre_tar) {
        this.nombre_tar = nombre_tar;
    }

    
}
