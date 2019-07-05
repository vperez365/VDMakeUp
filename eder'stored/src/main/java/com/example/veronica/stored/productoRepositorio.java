package com.example.veronica.stored;

import org.springframework.data.repository.Repository;
import java.util.List;

public interface productoRepositorio extends Repository<productos, Integer> {
	//Atraer todos los productos
	List<productos>findAll();
	productos findOne(int idProductos);
	productos save(productos p);
	void delete(productos p);
}

