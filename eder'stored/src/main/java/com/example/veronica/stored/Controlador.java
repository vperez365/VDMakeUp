package com.example.veronica.stored;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;


@CrossOrigin(origins="http://localhost:4200",maxAge=3600)
@RestController
@RequestMapping({"/productos"})

public class Controlador {
	@Autowired
	ProductosService service;
	
	@GetMapping
	public List<productos>listar(){
		return service.Listar();
	}
}
