import wollok.game.*

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method sufijo() {
		return "izq"
	}
}

object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}
	
	method sufijo() {
		return "der"
	}
		
}

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method sufijo() {
		return "izq" 
	}		
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}
	method sufijo() {
		return "izq" 
	}				
}
