import { NgModule, ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
/*Importar los componentes:*/
import {InicioComponent} from './inicio/inicio.component';
import {ProductosComponent} from './productos/productos.component';

const routes: Routes = [
	{path: '', component: InicioComponent },
	{path: 'inicio', component: InicioComponent},
	{path: 'productos',component: ProductosComponent}
	];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
