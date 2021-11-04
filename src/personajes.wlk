import wollok.game.*
import inicio.*
import complementos.*

object charmander {
	var property position = game.at(1,1)
	var property energia = 100
	var property defensa = 100 
	var direccion = izquierda
	
	method hablar() = "Char char"
	method perdi() = "Me quedé sin energia, perdí!"
	
	
	method image() {
		return "charmander-" + self.sufijo() + ".png"
	}
	
	method sufijo() {
		return if (self.dir(izquierda)) { "der" } else { "izq" }
	}
	
	method dir(dir) {
		return direccion == dir
	}
	
	method modificarEnergia(elemento) {
		energia = energia + elemento.energiaQueBrinda()
	}
	
	method modificarDefensa(elemento) {
		defensa = defensa + elemento.defensaQueBrinda()
	}
	
	method meEncontro(elemento) {
		return elemento.meEncontro(self)	
	}
	
	method perder() {
		if (self.energia() <= 0) { 
			game.say(self, self.perdi())
			game.schedule(1500, {game.stop()})
		}
	}
	
	method mover(dir) {
		direccion = dir
		if (not mapaDeParedes.estanEnElCaminoDe(dir.siguiente(position))) {
			self.irA(dir.siguiente(position))
		}
		
	}
	
	method irA(nuevaPosicion) {

		position = nuevaPosicion
	}
	
//	method siguiente(posicion) {}
	
	method dispararFuego() {
		game.addVisual(fuego)
		game.onCollideDo(fuego, { objeto => fuego.meEncontro(objeto) })  ///////
		fuego.desaparecer()
	}
}

class Pokemon {
	var property position = game.at(9,7)
	const property image 
	
	method image() = image
	method quemar(elemento) {  }   ///////
	method desaparecer() {  }   ///////
}

object fuego {
	var position 
	
	method position() {
		return self.siguiente(charmander.position())
	}
	
	method siguiente(posicion) {
		return if (charmander.dir(izquierda)) { 
			posicion.left(1)
		} else { 
		   posicion.right(1) 
		}
	}
	
	method image() { 
		return "disparoDeFuego-" + charmander.sufijo() + ".png"
	}
	
	method meEncontro(elemento) {
		elemento.desaparecer()
	}
	
	method desaparecer() {
		game.schedule(500, { => game.removeVisual(self) })
	}
	method quemar(elemento) {  ///////
   		elemento.estaEnLaMismaPosicion(self)
   		elemento.desaparecer()
   }
   
   method estaEnLaMismaPosicion(algo) {  ///////
		return position == algo.position()
	}
}

////////////////////////////////////////////////////////////////////////////////////
class Baya {
	var property position = game.center()
	const property energiaQueBrinda = 15
	const property image = ""
	
	method image() = image
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	self.desaparecer()
    	game.sound("Charmander-happy.mp3").play()
    	pokemon.modificarEnergia(self)
    	game.say(pokemon, pokemon.hablar())
    }
    
}
///////////////////////////////////////////////
class Trampa {
	var property position
	const property energiaQueBrinda 
	const property defensaQueBrinda 
	const property image 
	
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	pokemon.modificarEnergia(self)    	
	    pokemon.modificarDefensa(self)
	    pokemon.perder()
   }
}
