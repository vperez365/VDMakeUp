package com.example.veronica.stored;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service

public class productosServiceImp  implements ProductosService{
	@Autowired
	private productoRepositorio repositorio;

	@Override
	public List<productos> Listar() {
		return repositorio.findAll();
	}

	@Override
	public productos listarId(int idProductos) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public productos add(productos p) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public productos edit(productos p) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public productos delete(int idProductos) {
		// TODO Auto-generated method stub
		return null;
	}

}
