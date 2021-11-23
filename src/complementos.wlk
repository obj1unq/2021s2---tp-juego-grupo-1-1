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


class Pared {
	const property position
	
	method image() = "pared.jpg"

	method quemar(elemento) {  }   ///////
	method desaparecer() {  }   ///////
}

class ParedIntermitente inherits Pared {
	
}

//object izquierda {
//	method siguiente(posicion) {
//		const posLeft = posicion.left(1)
//		return game.at(posLeft.x().max(1), posLeft.y())
//	}
//	
//	method sufijo() {
//		return "izq"
//	}  
//}
//
//object derecha {
//	method siguiente(posicion) {
//		const posRight = posicion.right(1)
//		return game.at(posRight.x().min(12), posRight.y())
//	}
//	
//	method sufijo() {
//		return "der"
//	}
//		
//}
//
//object arriba {
//	method siguiente(posicion) {
//		const posUp = posicion.up(1)
//		return game.at(posUp.x(), posUp.y().min(11))
//	}
//	
//	method sufijo() {
//		return "izq" 
//	}		
//}
//
//object abajo {
//	method siguiente(posicion) {
//		const posDown = posicion.down(1)
//		return game.at(posDown.x(), posDown.y().max(1))
//	}
//	method sufijo() {
//		return "izq" 
//	}				
//}

