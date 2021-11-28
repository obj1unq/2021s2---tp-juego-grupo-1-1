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


