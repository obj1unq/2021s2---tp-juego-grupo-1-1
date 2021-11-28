import wollok.game.*

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method sufijo() {
		return "izq"
	} 
	
	method opuesta(){
		return derecha
	}	
} 

object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}
	
	method sufijo() {
		return "der"
	}
	
	method opuesta(){
		return izquierda
	}		
}

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method sufijo() {
		return "izq" 
	}
	method opuesta(){
		return abajo
	}		
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}
	method sufijo() {
		return "izq" 
	}
	method opuesta(){
		return arriba
	}		
}


class Pared {
	const property position
	
	method image() = "pared.jpg"

	method quemar(elemento) { }   ///////
	method desaparecer() { }   ///////
	
	method obstruyeElCamino() = true
	
	method meEncontro(pokemon) { }
}

////////////////////////////////////////////////////////////////////////////////////

class Baya {
	var property position
	
	method image() 
	
	method obstruyeElCamino() {
		return false
	} 
	
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	self.estaFeliz(pokemon)
    	self.desaparecer()
    }
    
	method estaFeliz(pokemon) {
		game.sound("Charmander-happy.mp3").play()
    	game.say(pokemon, pokemon.hablar())
	}
    
}

class BayaLatano inherits Baya {
	
	override method image() = "latano.png"
	 
	method defensaQueBrinda() = 25
	
	override method meEncontro(pokemon){
		super(pokemon)
		pokemon.modificarDefensa(self)
	}
	
}

class BayaFrambu inherits Baya {
	
	override method image() = "baya.png"
	
	method energiaQueBrinda() = 50
	
	override method meEncontro(pokemon){
		super(pokemon)
		pokemon.modificarEnergia(self)	
	}
}

class BayaPinia inherits Baya {
	
	override method image() = "pinia.png"
	
	method ataqueQueBrinda() = 30
	
	override method meEncontro(pokemon){
		super(pokemon)
		pokemon.modificarAtaque(self)
	}
}

///////////////////////////////////////////////

class Trampa {
	var property position 
	const property energiaQueBrinda 
	const property defensaQueBrinda 
	
    method image() {
    	return"trampa.png"
    }
    
    method obstruyeElCamino() = false
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	pokemon.modificarEnergia(self)    	
	    pokemon.modificarDefensa(self)
	    pokemon.perder()
   }
}
 