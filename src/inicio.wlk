import wollok.game.*
import personajes.*
import complementos.*


/*object objetosYPersonajes {
	
	method iniciar() {
		game.addVisual(charmander)
		game.addVisual(pokeball)
		objetosDelMapa.bayasYTrampas()
		enemigos.pokemones()
		mapaDeParedes.agregarVisualParedes()
    	config.confColisiones()
  	    game.showAttributes(charmander)
  		config.configurarTeclas()
  		config.confEventos()  		
  		game.start()
	}
}*/

object menu {
	method iniciar() {
		game.addVisual(self)
		config.pasarPantalla()
		game.start()
	}
	
	method image() {
		return "portada.jpg"
	}
	
	method position(){
		return game.origin()
	}
}

object instrucciones {
	
	method iniciar() {
		game.clear()
		game.addVisual(self)
		config.comenzarJuego()
	}
	
	method image() {
		return "instrucciones.jpg"
	}
	
	method position(){
		return game.origin()
	}
}

object juego {
	
	method iniciar() {
		game.clear()
		game.addVisual(charmander)
		game.addVisual(pokeball)
		objetosDelMapa.bayasYTrampas()
		mapaDeParedes.levantarBordes()
		laberintos.labCero()
		enemigos.pokemones()
    	config.confColisiones()
  	    game.showAttributes(charmander)
  		config.configurarTeclas()
  		config.confEventos()  			
	}
	
}

object objetosDelMapa {
	method bayasYTrampas() {
		//game.addVisual(new Baya(position = game.at(6,1), image = "frambu.png", energiaQueBrinda = 20))
		//game.addVisual(new Baya(position = game.at(8,4), image = "frambu.png", energiaQueBrinda = 20))
		//game.addVisual(new Baya(position = game.at(5,6), image = "pinia.png", energiaQueBrinda = 10))
		//game.addVisual(new Baya(position = game.at(11,5), image = "latano.png", energiaQueBrinda = 5))
		game.addVisual(new BayaLatano(position = game.at(11,5)))
		game.addVisual(new BayaFrambu(position = game.at(7,7)))
		game.addVisual(new BayaPinia(position = game.at(1,10)))
		
		game.addVisual(new Trampa(position = game.at(10,5), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(1,9), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(8,7), energiaQueBrinda = -15, defensaQueBrinda = -15))
	}
}

object enemigos {
	method pokemones() {
		game.addVisual(new Pokemon(image = "gengarD.png", position = game.at(9,5), energia = 100))
		game.addVisual(new Pokemon(image = "Machamp.png", position = game.at(7,2), energia = 300))
	}
}

object config { 
	
	method configurarTeclas() {
		keyboard.left().onPressDo( { charmander.mover(izquierda)  })
		keyboard.right().onPressDo({ charmander.mover(derecha) })
		keyboard.up().onPressDo({ charmander.mover(arriba) })
		keyboard.down().onPressDo({ charmander.mover(abajo) })
	    keyboard.f().onPressDo({ charmander.dispararFuego() })
		keyboard.g().onPressDo({ charmander.atacarConGarra() })
	}
	
	method confColisiones() {
		game.onCollideDo(charmander, { objeto => charmander.meEncontro(objeto) })
	}
	
	method confEventos(){
		game.onTick(1000, "DANIOENEMIGO", { charmander.recibirDanio() })
	}
	
	method pasarPantalla() { 
		keyboard.enter().onPressDo({instrucciones.iniciar()})
	}
	
	method comenzarJuego() { 
		keyboard.enter().onPressDo({juego.iniciar()})
	}
}

object mapaDeParedes {
	const property mapParedes = #{}
	
	// en vez de crearPared nombre antes era agregarPared
	method crearPared(posicion) {
		const parednueva = new Pared(position = posicion)
		game.addVisual(parednueva)
	}
	
	method agregarVisualParedes() {
		mapParedes.forEach({ pared => game.addVisual(pared) })
	}
	
	method levantarParedDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.crearPared(posicionInicial)
		(longitud - 1).times{indice =>
					   		 posicionActual = direccion.siguiente(posicionActual)
					   		 self.crearPared(posicionActual)
					   		 }
	}
	
	method levantarBordes() {
		self.levantarParedDe(13, game.at(0,0), arriba)
		self.levantarParedDe(13, game.at(19,0), arriba)
		self.levantarParedDe(19, game.at(1,12), derecha)
		self.levantarParedDe(19, game.at(1,0), derecha)
	}
	
//	method initialize() {
//		//////// BORDES
//		self.levantarParedDe(13, game.at(0,0), arriba)
//		self.levantarParedDe(13, game.at(19,0), arriba)
//		self.levantarParedDe(19, game.at(1,12), derecha)
//		self.levantarParedDe(19, game.at(1,0), derecha)
//		/////// LABERINTO
//		laberintos.labCero()
//   }
}


//COPIA POR SI ACASO
//object mapaDeParedes {
//	const property mapParedes = #{}
//	
//	method agregarPared(posicion) {
//		mapParedes.add(new Pared(position = posicion))
//	}
//	
//	method agregarVisualParedes() {
//		mapParedes.forEach({ pared => game.addVisual(pared) })
//	}
//	
//	method estanEnElCaminoDe(posicionObjetoMovil) {
//		return mapParedes.any({pared => pared.position() == posicionObjetoMovil})
//	}
//	
//	method levantarParedDe(longitud, posicionInicial, direccion) {
//		var posicionActual = posicionInicial
//		self.agregarPared(posicionInicial)
//		(longitud - 1).times{indice =>
//					   		 posicionActual = direccion.siguiente(posicionActual)
//					   		 self.agregarPared(posicionActual)
//					   		 }
//	}
//	
//	method initialize() {
//		//////// BORDES
//		self.levantarParedDe(13, game.at(0,0), arriba)
//		self.levantarParedDe(13, game.at(19,0), arriba)
//		self.levantarParedDe(19, game.at(1,12), derecha)
//		self.levantarParedDe(19, game.at(1,0), derecha)
//		/////// LABERINTO
//		laberintos.labCero()
//   	}
//}

object laberintos {
	
	method labCero() {
		//////// PAREDES INTERNAS

		mapaDeParedes.crearPared(game.at(13,1))	
		
		mapaDeParedes.levantarParedDe(5, game.at(1,2), derecha)
		
		mapaDeParedes.crearPared(game.at(13,1))
		mapaDeParedes.levantarParedDe(7, game.at(7,2), derecha)//
		mapaDeParedes.levantarParedDe(4, game.at(8,7), derecha)
		mapaDeParedes.levantarParedDe(4, game.at(12,4), derecha)//
		mapaDeParedes.levantarParedDe(2, game.at(11,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(11,3), arriba)//
		mapaDeParedes.levantarParedDe(3, game.at(9,4), arriba)//
		mapaDeParedes.levantarParedDe(5, game.at(7,3), arriba)
		
		
		mapaDeParedes.levantarParedDe(3, game.at(2,4), derecha)
		mapaDeParedes.levantarParedDe(5, game.at(1,6), derecha)////
		mapaDeParedes.levantarParedDe(3, game.at(6,9), derecha)
		mapaDeParedes.levantarParedDe(6, game.at(3,5), arriba)/////
		mapaDeParedes.levantarParedDe(4, game.at(5,7), arriba)
		mapaDeParedes.crearPared(game.at(2,10))
		mapaDeParedes.crearPared(game.at(1,8))
		
		mapaDeParedes.levantarParedDe(5, game.at(7,11), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(10,9), derecha)
		
		mapaDeParedes.levantarParedDe(3, game.at(14,6), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(13,8), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(15,2), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(17,4), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,6), derecha)
		
		mapaDeParedes.levantarParedDe(3, game.at(16,8), derecha)
		mapaDeParedes.crearPared(game.at(17,9))
		
		mapaDeParedes.levantarParedDe(2, game.at(15,10), arriba)
		
		mapaDeParedes.crearPared(game.at(17,11))
	}
	
	method labUno() {
		mapaDeParedes.levantarParedDe(3, game.at(2,1), arriba)
		mapaDeParedes.levantarParedDe(6, game.at(2,5), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(4,2), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(4,7), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(6,1), arriba)
		mapaDeParedes.levantarParedDe(4, game.at(6,4), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,9), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(8,1), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(8,5), arriba)
		
		mapaDeParedes.levantarParedDe(5, game.at(10,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(10,8), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,6), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(14,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(14,4), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(14,9), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(16,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(16,10), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(18,4), arriba)
		
		mapaDeParedes.levantarParedDe(8, game.at(11,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(17,2), derecha)
		
		mapaDeParedes.crearPared(game.at(5,4))
		mapaDeParedes.crearPared(game.at(3,5))
		mapaDeParedes.crearPared(game.at(7,7))
		mapaDeParedes.crearPared(game.at(8,11))
		mapaDeParedes.crearPared(game.at(9,5))
		mapaDeParedes.crearPared(game.at(11,3))
		mapaDeParedes.crearPared(game.at(13,4))
		mapaDeParedes.crearPared(game.at(16,7))
		mapaDeParedes.crearPared(game.at(15,5))
		mapaDeParedes.crearPared(game.at(17,10))
	}
	
	method labDos() {
		mapaDeParedes.levantarParedDe(10, game.at(2,1), arriba)
		mapaDeParedes.levantarParedDe(7, game.at(4,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,4), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(15,4), arriba)
		mapaDeParedes.levantarParedDe(9, game.at(17,2), arriba)
		
		mapaDeParedes.levantarParedDe(12, game.at(5,2), derecha)
		mapaDeParedes.levantarParedDe(8, game.at(7,4), derecha)
		mapaDeParedes.levantarParedDe(7, game.at(7,6), derecha)
		mapaDeParedes.levantarParedDe(10, game.at(5,8), derecha)
		mapaDeParedes.levantarParedDe(14, game.at(3,10), derecha)
	}
	
	method labTres() {
		mapaDeParedes.levantarParedDe(3, game.at(2,2), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(4,3), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(2,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(2,4), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(2,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(4,9), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,4), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(2,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(6,1), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(8,2), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,10), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(6,7), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,2), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(8,8), arriba)
		
		mapaDeParedes.levantarParedDe(9, game.at(10,2), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(14,3), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(12,4), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,4), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(14,9), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(12,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,10), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,7), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(16,1), arriba)		
	}
	
	method labCuatro() {
		mapaDeParedes.levantarParedDe(9, game.at(2,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(4,1), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(4,4), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(8,3), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(10,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(12,4), arriba)
		mapaDeParedes.levantarParedDe(4, game.at(14,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(16,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(17,8), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(3,6), derecha)
		mapaDeParedes.levantarParedDe(3, game.at(7,6), derecha)
		mapaDeParedes.levantarParedDe(6, game.at(12,6), derecha)
		mapaDeParedes.levantarParedDe(12, game.at(5,8), derecha)
		mapaDeParedes.levantarParedDe(14, game.at(3,10), derecha)
		
		mapaDeParedes.crearPared(game.at(8,1))
		mapaDeParedes.crearPared(game.at(17,3))
		mapaDeParedes.crearPared(game.at(3,8))
		mapaDeParedes.crearPared(game.at(18,1))
	}
}


/*
		self.levantarParedDe(3, game.at(1,2), derecha)
		self.levantarParedDe(3, game.at(2,3), arriba)
		self.levantarParedDe(2, game.at(2,7), arriba)
		self.agregarPared(game.at(1,8))
		
		self.levantarParedDe(2, game.at(4,4), derecha)
		self.levantarParedDe(3, game.at(5,3), abajo)
		self.levantarParedDe(3, game.at(6,3), derecha)
		self.agregarPared(game.at(7,1))
		
		self.levantarParedDe(2, game.at(9,1), derecha)
		self.levantarParedDe(2, game.at(10,2), derecha)
		self.levantarParedDe(2, game.at(11,3), arriba)
		
		self.levantarParedDe(3, game.at(2,10), derecha)
		self.levantarParedDe(2, game.at(5,11), abajo)
		self.levantarParedDe(4, game.at(4,9), abajo)
		self.levantarParedDe(2, game.at(7,11), abajo)
		self.levantarParedDe(4, game.at(12,10), izquierda)
		
		self.levantarParedDe(4, game.at(7,8), derecha)
		self.levantarParedDe(2, game.at(6,7), abajo)
		self.levantarParedDe(2, game.at(7,5), derecha)
		self.levantarParedDe(4, game.at(8,6), derecha)
		self.agregarPared(game.at(12,8))	
		
		self.levantarParedDe(13, game.at(0,0), arriba)
		self.levantarParedDe(13, game.at(13,0), arriba)
		self.levantarParedDe(12, game.at(1,12), derecha)
		self.levantarParedDe(12, game.at(1,0), derecha)
		*/
