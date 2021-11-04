import wollok.game.*
import personajes.*
import complementos.*

  
object objetosYPersonajes {
	
	method iniciar() {
		game.addVisual(charmander)
		objetosDelMapa.bayasYTrampas()
		enemigos.pokemones()
		mapaDeParedes.agregarVisualParedes()
    	config.confColisiones()
  		game.showAttributes(charmander)
  		config.configurarTeclas()
  		game.start()
	}
}

object objetosDelMapa {
	method bayasYTrampas() {
		game.addVisual(new Baya(position = game.at(6,1), image = "frambu.png", energiaQueBrinda = 20))
		game.addVisual(new Baya(position = game.at(8,4), image = "frambu.png", energiaQueBrinda = 20))
		game.addVisual(new Baya(position = game.at(5,6), image = "pinia.png", energiaQueBrinda = 10))
		game.addVisual(new Baya(position = game.at(11,5), image = "latano.png", energiaQueBrinda = 5))
		game.addVisual(new Trampa(position = game.at(10,5), image = "trampa.png", energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(1,9), image = "trampa.png", energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(7,6), image = "trampa.png", energiaQueBrinda = -15, defensaQueBrinda = -15))
	}
}

object enemigos {
	method pokemones() {
		game.addVisual(new Pokemon(image = "gengar.png"))
	}
}

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo( { charmander.mover(izquierda)  })
		keyboard.right().onPressDo({ charmander.mover(derecha) })
		keyboard.up().onPressDo({ charmander.mover(arriba) })
		keyboard.down().onPressDo({ charmander.mover(abajo) })
	    keyboard.f().onPressDo({ charmander.dispararFuego() })
		
	}
	
	method confColisiones() {
		game.onCollideDo(charmander, { objeto => charmander.meEncontro(objeto) })
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
	
	method initialize() {
		//////// PAREDES INTERNAS
		self.agregarPared(game.at(1,2))
		self.agregarPared(game.at(1,8))
		self.agregarPared(game.at(2,2))
		self.agregarPared(game.at(3,2))
		self.agregarPared(game.at(2,3))
		self.agregarPared(game.at(2,4))
		self.agregarPared(game.at(2,5))
		self.agregarPared(game.at(2,7))
		self.agregarPared(game.at(2,8))
		self.agregarPared(game.at(2,10))
		self.agregarPared(game.at(3,10))
		self.agregarPared(game.at(4,4))
		self.agregarPared(game.at(4,6))
		self.agregarPared(game.at(4,7))
		self.agregarPared(game.at(4,8))
		self.agregarPared(game.at(4,9))
		self.agregarPared(game.at(4,10))
		self.agregarPared(game.at(5,1))
		self.agregarPared(game.at(5,2))
		self.agregarPared(game.at(5,3))
		self.agregarPared(game.at(5,4))
		self.agregarPared(game.at(5,10))
		self.agregarPared(game.at(5,11))
		self.agregarPared(game.at(6,3))
		self.agregarPared(game.at(6,6))
		self.agregarPared(game.at(6,7))
		self.agregarPared(game.at(7,1))
		self.agregarPared(game.at(7,3))
		self.agregarPared(game.at(7,5))
		self.agregarPared(game.at(7,8))
		self.agregarPared(game.at(7,10))
		self.agregarPared(game.at(7,11))
		self.agregarPared(game.at(8,3))
		self.agregarPared(game.at(8,5))
		self.agregarPared(game.at(8,6))
		self.agregarPared(game.at(8,8))
		self.agregarPared(game.at(9,1))
		self.agregarPared(game.at(9,6))
		self.agregarPared(game.at(9,8))
		self.agregarPared(game.at(9,10))
		self.agregarPared(game.at(10,1))
		self.agregarPared(game.at(10,2))
		self.agregarPared(game.at(10,6))
		self.agregarPared(game.at(10,8))
		self.agregarPared(game.at(10,10))
		self.agregarPared(game.at(11,3))
		self.agregarPared(game.at(11,4))
		self.agregarPared(game.at(11,2))
		self.agregarPared(game.at(11,6))
		self.agregarPared(game.at(11,10))
		self.agregarPared(game.at(12,8))
		self.agregarPared(game.at(12,10))	
	}
}