/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.model;

/**
 *
 * @author ME-PC
 */
public class taux {
    private String idtaux; 
    private int montant1;
    private int montant2;
    
    public String getIdtaux(){
        return idtaux;
    }
    
    public void setIdtaux(String idtaux){
        this.idtaux = idtaux;
    }
    
    public int getMontant1(){
        return montant1;
    }
    
    public void setMontant1(int montant1){
        this.montant1 = montant1;
    }
    
    public int getMontant2(){
        return montant2;
    }
    
    public void setMontant2(int montant2){
        this.montant2 = montant2;
    }
}
