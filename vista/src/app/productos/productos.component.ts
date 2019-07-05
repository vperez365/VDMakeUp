import { Component, OnInit } from '@angular/core';
//Importamos modelo de datos
import {Productos} from '../modelos/productos';
//importamos servicio
import {CatalogoService} from '../servicios/catalogo.service';
  
import {Router} from '@angular/router';

@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.css']
})
export class ProductosComponent implements OnInit {
	public items: Productos[];

  constructor(
  	private serhttp: CatalogoService,//servicio
  	private router:Router//enrrutamiento

  	) { }

  ngOnInit() {
  	this.serhttp.getProductos()
  	.subscribe(objitem=>{
  		this.items=objitem	
      console.log(this.items)
  		})
  }

}
