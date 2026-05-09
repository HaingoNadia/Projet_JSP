/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.model;

/**
 *
 * @author ME-PC
 */
import java.time.*;

public class envoyer {
    private String idEnv;
    private String numEnvoyeur;
    private String numRecepteur;
    private int montant;
    private LocalDateTime date;
    private String raison;
    
    public String getIdEnv(){
        return idEnv;
    }
    
    public void setIdEnv(String idEnv){
        this.idEnv = idEnv;
    }
    
    public String getNumEnvoyeur(){
        return numEnvoyeur;
    }
    
    public void setNumEnvoyeur(String numEnvoyeur){
        this.numEnvoyeur = numEnvoyeur;
    }
    
    public String getNumRecepteur(){
        return numRecepteur;
    }
    
    public void setNumRecepteur(String numRecepteur){
        this.numRecepteur = numRecepteur;
    }
    
    public int getMontant(){
        return montant;
    }
    
    public void setMontant(int montant){
        this.montant = montant;
    }
    
    public LocalDateTime getDate(){
        return date;
    }
    
    public void setDate(LocalDateTime date){
        this.date = date;
    }
    
    public String getRaison(){
        return raison;
    }
    
    public void setRaison(String raison){
        this.raison = raison;
    }
}
