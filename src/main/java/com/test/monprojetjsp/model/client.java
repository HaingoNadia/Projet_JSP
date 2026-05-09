/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.model;

/**
 *
 * @author ME-PC
 */
public class client {
    private String numtel; 
    private String nom; 
    private String sexe;
    private String pays;
    private String mail;
    private int solde;    

    public String getNumtel(){
        return numtel;
    }
    
    public void setNumtel(String numtel){
        this.numtel = numtel;
    }
    
    public String getNom(){
        return nom;
    }
    
    public void setNom(String nom){
        this.nom = nom;
    }
    
        public String getSexe(){
        return sexe;
    }
    
    public void setSexe(String sexe){
        this.sexe = sexe;
    }
    
        public String getPays(){
        return pays;
    }
    
    public void setPays(String pays){
        this.pays = pays;
    }
    
        public int getSolde(){
        return solde;
    }
    
    public void setSolde(int solde){
        this.solde = solde;
    }
    
        public String getMail(){
        return mail;
    }
    
    public void setMail(String mail){
        this.mail = mail;
    }
}
