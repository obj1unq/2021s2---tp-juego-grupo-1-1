import wollok.game.*
import personajes.*
import complementos.*

object objetosYPersonajes {
	
	method iniciar() {
		game.addVisual(charmander)
		game.addVisual(baya)
		game.addVisual(trampa)
    	config.confColisiones()
  		game.showAttributes(charmander)
  		config.configurarTeclas()
  		 
  		game.start()
  		
	}
}


object config {

	method configurarTeclas() {
		keyboard.left().onPressDo( { charmander.mover(izquierda)  })
		keyboard.right().onPressDo({ charmander.mover(derecha) })
		keyboard.up().onPressDo({ charmander.mover(arriba) })
		keyboard.down().onPressDo({ charmander.mover(abajo) })
	}
	
	method confColisiones() {
		game.whenCollideDo(baya, { pokemon => baya.meEncontro(pokemon) })
    	game.onCollideDo(trampa, { pokemon => trampa.meEncontro(pokemon) })
	}

}