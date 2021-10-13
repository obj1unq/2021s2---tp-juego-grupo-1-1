import wollok.game.*
import inicio.*
import complementos.*

object charmander {
	var property position = game.origin()
	var property energia = 100
	var property defensa = 100 
	var direccion = izquierda
	
	method hablar() = "Char char"
	method perdi() = "Me quedé sin energia, perdí!"
	
	
	method image() {
		return  (if (self.dir(izquierda)) { "charmander-der.png" } else { "charmander-org.png" })
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
	
	method perder() {
		if (self.energia() <= 0) { 
			game.say(self, self.perdi())
			game.schedule(1500, {game.stop()})
		}
	}
	
	method mover(_direccion) {
		direccion = _direccion
		self.irA(_direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
}

object baya {
	var property position = game.center()
	const property energiaQueBrinda = 15

    method image() = "baya.png"
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	self.desaparecer()
    	pokemon.modificarEnergia(self)
    	game.say(pokemon, pokemon.hablar())
    }
}

object trampa {
	var property position = game.at(6,3)
	const property energiaQueBrinda = -15
	const property defensaQueBrinda = -15
	
    method image() = "trampa.jpg"
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	 
    	pokemon.modificarEnergia(self)    	
	    pokemon.modificarDefensa(self)
	    pokemon.perder()
    }  
}