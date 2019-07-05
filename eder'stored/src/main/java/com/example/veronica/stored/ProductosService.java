package com.example.veronica.stored;
import java.util.List;

public interface ProductosService {
	List<productos>Listar();
	productos listarId(int idProductos);
	productos add(productos p);
	//CRUD:
	productos edit(productos p);
	//no es recomendable
	productos delete(int idProductos);
}
