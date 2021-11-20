import wollok.game.*
import personajes.*
import complementos.*



object objetosYPersonajes {
	
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
}


object mapaDeParedes {
	const property mapParedes = #{}
	
	method agregarPared(posicion) {
		mapParedes.add(new Pared(position = posicion))
	}
	
	method agregarVisualParedes() {
		mapParedes.forEach({ pared => game.addVisual(pared) })
	}
	
	method estanEnElCaminoDe(posicionObjetoMovil) {
		return mapParedes.any({pared => pared.position() == posicionObjetoMovil})
	}
	
	method levantarParedDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.agregarPared(posicionInicial)
		(longitud - 1).times{indice =>
					   		 posicionActual = direccion.siguiente(posicionActual)
					   		 self.agregarPared(posicionActual)
		}
	}
	
	method initialize() {
		//////// PAREDES INTERNAS
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
	}

}
