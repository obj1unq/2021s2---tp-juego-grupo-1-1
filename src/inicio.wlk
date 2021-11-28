import wollok.game.*
import personajes.*
import complementos.*


object menu {
	method iniciar() {
		game.addVisual(self)
		config.pasarPantalla(instrucciones)
	}
	
	method image() {
		return "portada.jpg"
	}
	
	method position(){
		return game.origin()
	}
}

object instrucciones {
	
	method iniciar() {
		game.clear()
		game.addVisual(self)
		config.pasarPantalla(config.labCero())
	}
	
	method image() {
		return "instrucciones.jpg"
	}
	
	method position(){
		return game.origin()
	}
}

class Laberinto {
	const property nivelActual
	
	method iniciar() {
		charmander.reiniciarPosicion()
		game.clear()
		game.addVisual(charmander)
  	    game.showAttributes(charmander)
  	    mapaDeParedes.levantarBordes()
  		config.configurarTeclas()
  		config.confEventos() 
  		config.confColisiones()
  		nivelActual.levantarLaberinto()
	}
}

object config { 

	const property labCero = new Laberinto(nivelActual  = laberintoCero)
	const property labUno = new Laberinto(nivelActual  = laberintoUno)
	const property labDos = new Laberinto(nivelActual  = laberintoDos)
	const property labTres = new Laberinto(nivelActual  = laberintoTres)
	const property labCuatro = new Laberinto(nivelActual  = laberintoCuatro)
	
	
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
	
	method pasarPantalla(nivel) { 
		keyboard.enter().onPressDo({nivel.iniciar()})
	}
	
}
	
object mapaDeParedes {
	const property mapParedes = #{}
	
	// en vez de crearPared nombre antes era agregarPared
	method crearPared(posicion) {
		const parednueva = new Pared(position = posicion)
		game.addVisual(parednueva)
	}
	
	method agregarVisualParedes() {
		mapParedes.forEach({ pared => game.addVisual(pared) })
	}
	
	method levantarParedDe(longitud, posicionInicial, direccion) {
		var posicionActual = posicionInicial
		self.crearPared(posicionInicial)
		(longitud - 1).times{indice =>
					   		 posicionActual = direccion.siguiente(posicionActual)
					   		 self.crearPared(posicionActual)
					   		 }
	}
	
	method levantarBordes() {
		self.levantarParedDe(13, game.at(0,0), arriba)
		self.levantarParedDe(13, game.at(19,0), arriba)
		self.levantarParedDe(19, game.at(1,12), derecha)
		self.levantarParedDe(19, game.at(1,0), derecha)
	}
}

object laberintoCero {
	method pasarDeLaberinto() {
		config.labUno().iniciar()		
	}
		
	method levantarLaberinto() {
		
		game.addVisual(new Pokeball(position = game.at(12,3), nivelActual = self))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(12,1)))
		game.addVisual(new BayaFrambu(position = game.at(18,1)))
		game.addVisual(new BayaFrambu(position = game.at(6,11)))
		
		game.addVisual(new BayaLatano(position = game.at(18,9)))
		game.addVisual(new BayaLatano(position = game.at(18,10)))
		game.addVisual(new BayaLatano(position = game.at(18,11)))
		
		game.addVisual(new BayaPinia(position = game.at(8,3)))
		game.addVisual(new BayaPinia(position = game.at(1,7)))
		
		game.addVisual(new Trampa(position = game.at(5,1), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(3,3), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(18,3), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(10,4), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(15,7), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(7,8), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(2,9), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(5,1), energiaQueBrinda = -15, defensaQueBrinda = -15))
		
		//////// ENEMIGOS
		
		game.addVisual(new Gengar(position = game.at(14,3), energia = 100))
		game.addVisual(new Gengar(position = game.at(17,10), energia = 100))
		game.addVisual(new Machamp(position = game.at(12,5), energia = 300))
		game.addVisual(new Machamp(position = game.at(7,10), energia = 300))
		
		//////// PAREDES INTERNAS
		mapaDeParedes.crearPared(game.at(13,1))	
		
		mapaDeParedes.levantarParedDe(5, game.at(1,2), derecha)
		
		mapaDeParedes.crearPared(game.at(13,1))
		mapaDeParedes.levantarParedDe(7, game.at(7,2), derecha)//
		mapaDeParedes.levantarParedDe(4, game.at(8,7), derecha)
		mapaDeParedes.levantarParedDe(4, game.at(12,4), derecha)//
		mapaDeParedes.levantarParedDe(2, game.at(11,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(11,3), arriba)//
		mapaDeParedes.levantarParedDe(3, game.at(9,4), arriba)//
		mapaDeParedes.levantarParedDe(5, game.at(7,3), arriba)
		
		
		mapaDeParedes.levantarParedDe(3, game.at(2,4), derecha)
		mapaDeParedes.levantarParedDe(5, game.at(1,6), derecha)////
		mapaDeParedes.levantarParedDe(3, game.at(6,9), derecha)
		mapaDeParedes.levantarParedDe(6, game.at(3,5), arriba)/////
		mapaDeParedes.levantarParedDe(4, game.at(5,7), arriba)
		mapaDeParedes.crearPared(game.at(2,10))
		mapaDeParedes.crearPared(game.at(1,8))
		
		mapaDeParedes.levantarParedDe(5, game.at(7,11), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(10,9), derecha)
		
		mapaDeParedes.levantarParedDe(3, game.at(14,6), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(13,8), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(15,2), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(17,4), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,6), derecha)
		
		mapaDeParedes.levantarParedDe(3, game.at(16,8), derecha)
		mapaDeParedes.crearPared(game.at(17,9))
		
		mapaDeParedes.levantarParedDe(2, game.at(15,10), arriba)
		
		mapaDeParedes.crearPared(game.at(17,11))
	}
	
}

object laberintoUno {
	
	method pasarDeLaberinto() {
		config.labDos().iniciar()	
	}
	
	method levantarLaberinto() {
		game.addVisual(new Pokeball(position = game.at(18,3), nivelActual = self))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(7,6)))
		game.addVisual(new BayaFrambu(position = game.at(13,11)))
		game.addVisual(new BayaFrambu(position = game.at(17,11)))
		
		game.addVisual(new BayaLatano(position = game.at(5,5)))
		game.addVisual(new BayaLatano(position = game.at(18,10)))
		
		game.addVisual(new BayaPinia(position = game.at(18,11)))
		game.addVisual(new BayaPinia(position = game.at(18,1)))
		game.addVisual(new BayaPinia(position = game.at(17,1)))
		game.addVisual(new BayaPinia(position = game.at(13,1)))
		
		game.addVisual(new Trampa(position = game.at(3,4), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(7,8), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(17,6), energiaQueBrinda = -10, defensaQueBrinda = -25))
		
		//////// ENEMIGOS
		
		game.addVisual(new Gengar(position = game.at(3,1), energia = 100))
		game.addVisual(new Gengar(position = game.at(6,8), energia = 100))
		game.addVisual(new Gengar(position = game.at(14,3), energia = 100))
		game.addVisual(new Gengar(position = game.at(13,9), energia = 100))
		game.addVisual(new Machamp(position = game.at(4,6), energia = 300))
		game.addVisual(new Machamp(position = game.at(8,4), energia = 300))
		game.addVisual(new Machamp(position = game.at(11,1), energia = 300))
		game.addVisual(new Machamp(position = game.at(10,7), energia = 300))
		
		mapaDeParedes.levantarParedDe(3, game.at(2,1), arriba)
		mapaDeParedes.levantarParedDe(6, game.at(2,5), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(4,2), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(4,7), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(6,1), arriba)
		mapaDeParedes.levantarParedDe(4, game.at(6,4), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,9), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(8,1), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(8,5), arriba)
		
		mapaDeParedes.levantarParedDe(5, game.at(10,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(10,8), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,6), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(14,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(14,4), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(14,9), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(16,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(16,10), arriba)
		
		mapaDeParedes.levantarParedDe(4, game.at(18,4), arriba)
		
		mapaDeParedes.levantarParedDe(8, game.at(11,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(17,2), derecha)
		
		mapaDeParedes.crearPared(game.at(5,4))
		mapaDeParedes.crearPared(game.at(3,5))
		mapaDeParedes.crearPared(game.at(7,7))
		mapaDeParedes.crearPared(game.at(8,11))
		mapaDeParedes.crearPared(game.at(9,5))
		mapaDeParedes.crearPared(game.at(11,3))
		mapaDeParedes.crearPared(game.at(13,4))
		mapaDeParedes.crearPared(game.at(16,7))
		mapaDeParedes.crearPared(game.at(15,5))
		mapaDeParedes.crearPared(game.at(17,10))
	}
}
	
object laberintoDos {
	method pasarDeLaberinto() {
		config.labTres().iniciar()		
	}
	
	method levantarLaberinto() {
		game.addVisual(new Pokeball(position = game.at(7,5), nivelActual = self))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(1,4)))
		game.addVisual(new BayaFrambu(position = game.at(3,4)))
		game.addVisual(new BayaFrambu(position = game.at(16,6)))
		
		game.addVisual(new BayaLatano(position = game.at(5,5)))
		game.addVisual(new BayaLatano(position = game.at(16,7)))
		game.addVisual(new BayaLatano(position = game.at(18,9)))
		
		game.addVisual(new BayaPinia(position = game.at(5,6)))
		game.addVisual(new BayaPinia(position = game.at(6,9)))
		game.addVisual(new BayaPinia(position = game.at(18,1)))
		game.addVisual(new BayaPinia(position = game.at(10,1)))
		
		game.addVisual(new Trampa(position = game.at(5,4), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(8,5), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(8,8), energiaQueBrinda = -10, defensaQueBrinda = -25))
		game.addVisual(new Trampa(position = game.at(8,11), energiaQueBrinda = -10, defensaQueBrinda = -20))
		game.addVisual(new Trampa(position = game.at(15,3), energiaQueBrinda = -5, defensaQueBrinda = -5))
		game.addVisual(new Trampa(position = game.at(16,1), energiaQueBrinda = -10, defensaQueBrinda = -25))
		
		//////// ENEMIGOS
		
		game.addVisual(new Gengar(position = game.at(11,1), energia = 100))
		game.addVisual(new Gengar(position = game.at(12,1), energia = 100))
		game.addVisual(new Gengar(position = game.at(2,11), energia = 100))
		game.addVisual(new Gengar(position = game.at(7,7), energia = 100))
		game.addVisual(new Gengar(position = game.at(17,1), energia = 100))
		game.addVisual(new Gengar(position = game.at(5,9), energia = 100))
		game.addVisual(new Machamp(position = game.at(10,5), energia = 300))
		game.addVisual(new Machamp(position = game.at(11,5), energia = 300))
		game.addVisual(new Machamp(position = game.at(14,3), energia = 300))
		game.addVisual(new Machamp(position = game.at(14,11), energia = 300))
		
		mapaDeParedes.levantarParedDe(10, game.at(2,1), arriba)
		mapaDeParedes.levantarParedDe(7, game.at(4,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,4), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(15,4), arriba)
		mapaDeParedes.levantarParedDe(9, game.at(17,2), arriba)
		
		mapaDeParedes.levantarParedDe(12, game.at(5,2), derecha)
		mapaDeParedes.levantarParedDe(8, game.at(7,4), derecha)
		mapaDeParedes.levantarParedDe(7, game.at(7,6), derecha)
		mapaDeParedes.levantarParedDe(10, game.at(5,8), derecha)
		mapaDeParedes.levantarParedDe(14, game.at(3,10), derecha)
	}
}

object laberintoTres {
	method pasarDeLaberinto() {
		config.labCuatro().iniciar()		
	}
	
	method levantarLaberinto() {
		mapaDeParedes.levantarParedDe(3, game.at(2,2), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(4,3), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(2,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(2,4), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(2,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(4,9), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,4), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(2,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(6,1), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(8,2), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(6,10), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(6,7), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,2), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(8,8), arriba)
		
		mapaDeParedes.levantarParedDe(9, game.at(10,2), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(14,3), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(12,8), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(12,4), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,4), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(14,9), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,6), derecha)
		mapaDeParedes.levantarParedDe(2, game.at(12,10), arriba)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,10), derecha)
		
		mapaDeParedes.levantarParedDe(2, game.at(16,7), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(16,1), arriba)	
	}
}

object laberintoCuatro {
	method pasarDeLaberinto() {	}
	
	method levantarLaberinto() {
		mapaDeParedes.levantarParedDe(9, game.at(2,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(4,1), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(4,4), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(6,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(8,3), arriba)
		mapaDeParedes.levantarParedDe(5, game.at(10,2), arriba)
		mapaDeParedes.levantarParedDe(2, game.at(12,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(12,4), arriba)
		mapaDeParedes.levantarParedDe(4, game.at(14,1), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(16,2), arriba)
		mapaDeParedes.levantarParedDe(3, game.at(17,8), arriba)
		
		mapaDeParedes.levantarParedDe(3, game.at(3,6), derecha)
		mapaDeParedes.levantarParedDe(3, game.at(7,6), derecha)
		mapaDeParedes.levantarParedDe(6, game.at(12,6), derecha)
		mapaDeParedes.levantarParedDe(12, game.at(5,8), derecha)
		mapaDeParedes.levantarParedDe(14, game.at(3,10), derecha)
		
		mapaDeParedes.crearPared(game.at(8,1))
		mapaDeParedes.crearPared(game.at(17,3))
		mapaDeParedes.crearPared(game.at(3,8))
		mapaDeParedes.crearPared(game.at(18,1))
	}
}

//	method initialize() {  //metodos de mapaDeParedes, me molestaban por eso los guardé acá abajo xd
//		//////// BORDES
//		self.levantarParedDe(13, game.at(0,0), arriba)
//		self.levantarParedDe(13, game.at(19,0), arriba)
//		self.levantarParedDe(19, game.at(1,12), derecha)
//		self.levantarParedDe(19, game.at(1,0), derecha)
//		/////// LABERINTO
//		laberintos.labCero()
//   }

