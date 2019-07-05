package com.example.veronica.stored;

import javax.persistence.*;
@Entity
@Table(name="productos")

public class productos {
	@Id
	@Column
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idProductos;
	@Column
	private int idTipoProd;
	@Column
	private String NombProd;
	@Column
	private double ValorComp;
	@Column
	private double ValorVent;
	@Column
	private int CantProd;
	@Column
	private String EstaProd;
	public int getIdProductos() {
		return idProductos;
	}
	public void setIdProductos(int idProductos) {
		this.idProductos = idProductos;
	}
	public int getIdTipoProd() {
		return idTipoProd;
	}
	public void setIdTipoProd(int idTipoProd) {
		this.idTipoProd = idTipoProd;
	}
	public String getNombProd() {
		return NombProd;
	}
	public void setNombProd(String nombProd) {
		NombProd = nombProd;
	}
	public double getValorComp() {
		return ValorComp;
	}
	public void setValorComp(double valorComp) {
		ValorComp = valorComp;
	}
	public double getValorVent() {
		return ValorVent;
	}
	public void setValorVent(double valorVent) {
		ValorVent = valorVent;
	}
	public int getCantProd() {
		return CantProd;
	}
	public void setCantProd(int cantProd) {
		CantProd = cantProd;
	}
	public String getEstaProd() {
		return EstaProd;
	}
	public void setEstaProd(String estaProd) {
		EstaProd = estaProd;
	}
	
	
}
