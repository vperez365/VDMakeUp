import { Injectable } from '@angular/core';
import {Productos} from '../modelos/productos';
import {HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class CatalogoService {

  constructor(private http:HttpClient) { }
  Url='http://localhost:8085/edertienda/productos'

  //Funcion para atraer los productos
  getProductos(){
  	return this.http.get<Productos[]>(this.Url);
  }
}
