import wollok.game.*
import personajes.*
import complementos.*


object objetosYPersonajes {
	
	method iniciar() {
		game.addVisual(charmander)
		objetosDelMapa.bayasYTrampas()
		enemigos.pokemones()
		mapaDeParedes.paredes()
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
	method paredes() {
		//////// PISO
		game.addVisual(new Pared(position = game.at(0,0)))
		game.addVisual(new Pared(position = game.at(1,0)))
		game.addVisual(new Pared(position = game.at(2,0)))
		game.addVisual(new Pared(position = game.at(3,0)))
		game.addVisual(new Pared(position = game.at(4,0)))
		game.addVisual(new Pared(position = game.at(5,0)))
		game.addVisual(new Pared(position = game.at(6,0)))
		game.addVisual(new Pared(position = game.at(7,0)))
		game.addVisual(new Pared(position = game.at(8,0)))
		game.addVisual(new Pared(position = game.at(9,0)))
		game.addVisual(new Pared(position = game.at(10,0)))
		game.addVisual(new Pared(position = game.at(11,0)))
		game.addVisual(new Pared(position = game.at(12,0)))
		game.addVisual(new Pared(position = game.at(13,0)))
		game.addVisual(new Pared(position = game.at(14,0)))
		//////// TECHO
		game.addVisual(new Pared(position = game.at(0,12)))
		game.addVisual(new Pared(position = game.at(1,12)))
		game.addVisual(new Pared(position = game.at(2,12)))
		game.addVisual(new Pared(position = game.at(3,12)))
		game.addVisual(new Pared(position = game.at(4,12)))
		game.addVisual(new Pared(position = game.at(5,12)))
		game.addVisual(new Pared(position = game.at(6,12)))
		game.addVisual(new Pared(position = game.at(7,12)))
		game.addVisual(new Pared(position = game.at(8,12)))
		game.addVisual(new Pared(position = game.at(9,12)))
		game.addVisual(new Pared(position = game.at(10,12)))
		game.addVisual(new Pared(position = game.at(11,12)))
		game.addVisual(new Pared(position = game.at(12,12)))
		game.addVisual(new Pared(position = game.at(13,12)))
		game.addVisual(new Pared(position = game.at(14,12)))
		//////// PARED DER
		game.addVisual(new Pared(position = game.at(0,1)))
		game.addVisual(new Pared(position = game.at(0,2)))
		game.addVisual(new Pared(position = game.at(0,3)))
		game.addVisual(new Pared(position = game.at(0,4)))
		game.addVisual(new Pared(position = game.at(0,5)))
		game.addVisual(new Pared(position = game.at(0,6)))
		game.addVisual(new Pared(position = game.at(0,7)))
		game.addVisual(new Pared(position = game.at(0,8)))
		game.addVisual(new Pared(position = game.at(0,9)))
		game.addVisual(new Pared(position = game.at(0,10)))
		game.addVisual(new Pared(position = game.at(0,11)))
		game.addVisual(new Pared(position = game.at(0,12)))
		game.addVisual(new Pared(position = game.at(0,13)))
		//////// PARED IZQ
		game.addVisual(new Pared(position = game.at(13,1)))
		game.addVisual(new Pared(position = game.at(13,2)))
		game.addVisual(new Pared(position = game.at(13,3)))
		game.addVisual(new Pared(position = game.at(13,4)))
		game.addVisual(new Pared(position = game.at(13,5)))
		game.addVisual(new Pared(position = game.at(13,6)))
		game.addVisual(new Pared(position = game.at(13,7)))
		game.addVisual(new Pared(position = game.at(13,8)))
		game.addVisual(new Pared(position = game.at(13,9)))
		game.addVisual(new Pared(position = game.at(13,10)))
		game.addVisual(new Pared(position = game.at(13,11)))
		game.addVisual(new Pared(position = game.at(13,12)))
		game.addVisual(new Pared(position = game.at(13,13)))
		//////// PAREDES INTERNAS
		game.addVisual(new Pared(position = game.at(1,2)))
		game.addVisual(new Pared(position = game.at(1,8)))
		game.addVisual(new Pared(position = game.at(2,2)))
		game.addVisual(new Pared(position = game.at(3,2)))
		game.addVisual(new Pared(position = game.at(2,3)))
		game.addVisual(new Pared(position = game.at(2,4)))
		game.addVisual(new Pared(position = game.at(2,5)))
		game.addVisual(new Pared(position = game.at(2,7)))
		game.addVisual(new Pared(position = game.at(2,8)))
		game.addVisual(new Pared(position = game.at(2,10)))
		game.addVisual(new Pared(position = game.at(3,10)))
		game.addVisual(new Pared(position = game.at(4,4)))
		game.addVisual(new Pared(position = game.at(4,6)))
		game.addVisual(new Pared(position = game.at(4,7)))
		game.addVisual(new Pared(position = game.at(4,8)))
		game.addVisual(new Pared(position = game.at(4,9)))
		game.addVisual(new Pared(position = game.at(4,10)))
		game.addVisual(new Pared(position = game.at(5,1)))
		game.addVisual(new Pared(position = game.at(5,2)))
		game.addVisual(new Pared(position = game.at(5,3)))
		game.addVisual(new Pared(position = game.at(5,4)))
		game.addVisual(new Pared(position = game.at(5,10)))
		game.addVisual(new Pared(position = game.at(5,11)))
		game.addVisual(new Pared(position = game.at(6,3)))
		game.addVisual(new Pared(position = game.at(6,6)))
		game.addVisual(new Pared(position = game.at(6,7)))
		game.addVisual(new Pared(position = game.at(7,1)))
		game.addVisual(new Pared(position = game.at(7,3)))
		game.addVisual(new Pared(position = game.at(7,5)))
		game.addVisual(new Pared(position = game.at(7,8)))
		game.addVisual(new Pared(position = game.at(7,10)))
		game.addVisual(new Pared(position = game.at(7,11)))
		game.addVisual(new Pared(position = game.at(8,3)))
		game.addVisual(new Pared(position = game.at(8,5)))
		game.addVisual(new Pared(position = game.at(8,6)))
		game.addVisual(new Pared(position = game.at(8,8)))
		game.addVisual(new Pared(position = game.at(9,1)))
		game.addVisual(new Pared(position = game.at(9,6)))
		game.addVisual(new Pared(position = game.at(9,8)))
		game.addVisual(new Pared(position = game.at(9,10)))
		game.addVisual(new Pared(position = game.at(10,1)))
		game.addVisual(new Pared(position = game.at(10,2)))
		game.addVisual(new Pared(position = game.at(10,6)))
		game.addVisual(new Pared(position = game.at(10,8)))
		game.addVisual(new Pared(position = game.at(10,10)))
		game.addVisual(new Pared(position = game.at(11,3)))
		game.addVisual(new Pared(position = game.at(11,4)))
		game.addVisual(new Pared(position = game.at(11,2)))
		game.addVisual(new Pared(position = game.at(11,6)))
		game.addVisual(new Pared(position = game.at(11,10)))
		game.addVisual(new Pared(position = game.at(12,8)))
		game.addVisual(new Pared(position = game.at(12,10)))
		}
}