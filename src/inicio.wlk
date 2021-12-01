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

object pantallaFinal {
	
	method image() {
		return "pantallaFinal.jpg"
	}
	
	method position(){
		return game.origin()
	}
	
	method iniciar() {
		game.clear()
		game.addVisual(self)
		medallasObtenidas.exponer()
	}
}

object medallasObtenidas {
	var inicioExposicion = game.at(10,1)
	
	method exponer(){
		charmander.medallasRecogidas().forEach({medalla =>
											  game.addVisualIn(medalla, inicioExposicion)
											  inicioExposicion = derecha.siguiente(inicioExposicion)
		})
	}
}

class Nivel {
	const property laberintoActual
	
	method iniciar() {
		charmander.reiniciarPosicion()
		game.clear()
  	    mapaDeParedes.levantarBordes()
  		laberintoActual.levantarLaberinto()
  	    game.addVisual(charmander)
  		config.configurarTeclas()
  		config.confEventos() 
  		config.confColisiones()
	}
}

object config { 

	const property labCero = new Nivel(laberintoActual  = laberintoCero)
	const property labUno = new Nivel(laberintoActual  = laberintoUno)
	const property labDos = new Nivel(laberintoActual  = laberintoDos)
	const property labTres = new Nivel(laberintoActual  = laberintoTres)
	const property labCuatro = new Nivel(laberintoActual  = laberintoCuatro)
	
	
	method configurarTeclas() {
		keyboard.left().onPressDo( { charmander.mover(izquierda)  })
		keyboard.right().onPressDo({ charmander.mover(derecha) })
		keyboard.up().onPressDo({ charmander.mover(arriba) })
		keyboard.down().onPressDo({ charmander.mover(abajo) })
	    keyboard.f().onPressDo({ charmander.dispararFuego() })
		keyboard.g().onPressDo({ charmander.atacarConGarra() })
		keyboard.space().onPressDo({game.say(charmander, charmander.decirEstado())})
	} 
	
	method confColisiones() {
		game.onCollideDo(charmander, { objeto => charmander.meEncontre(objeto) })
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
		game.addVisual(new Medalla(position = game.at(1,7), image= "medalla 1.png"))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(6,11)))
		game.addVisual(new BayaFrambu(position = game.at(8,5)))
		game.addVisual(new BayaFrambu(position = game.at(12,1)))
		game.addVisual(new BayaFrambu(position = game.at(13,11)))
		game.addVisual(new BayaFrambu(position = game.at(18,1)))
		
		game.addVisual(new BayaLatano(position = game.at(1,5)))
		game.addVisual(new BayaLatano(position = game.at(8,4)))
		game.addVisual(new BayaLatano(position = game.at(18,9)))
		game.addVisual(new BayaLatano(position = game.at(18,10)))
		game.addVisual(new BayaLatano(position = game.at(18,11)))
		
		game.addVisual(new BayaPinia(position = game.at(1,3)))
		game.addVisual(new BayaPinia(position = game.at(2,7)))
		game.addVisual(new BayaPinia(position = game.at(8,3)))
		game.addVisual(new BayaPinia(position = game.at(8,6)))
		
		game.addVisual(new Trampa(position = game.at(5,1), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(3,3), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(18,3), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(10,4), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(15,7), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(7,8), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(2,9), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(5,1), energiaQueBrinda = -15, defensaQueBrinda = -15))
		
		//////// ENEMIGOS
		
		game.addVisual(new PokemonGuardia(position = game.at(14,3), energia = 100, image = "gengar-"))
		game.addVisual(new PokemonGuardia(position = game.at(17,10), energia = 150, image = "gengar-"))
		game.addVisual(new PokemonGuardia(position = game.at(12,5), energia = 300, image = "machamp-"))
		game.addVisual(new PokemonGuardia(position = game.at(7,10), energia = 250, image = "machamp-")) 
		
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
		
		game.addVisual(new Medalla(position = game.at(15,4), image= "medalla 2.png"))
		game.addVisual(new Medalla(position = game.at(17,11), image= "medalla 3.png"))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(7,6)))
		game.addVisual(new BayaFrambu(position = game.at(13,11)))
		game.addVisual(new BayaFrambu(position = game.at(18,9)))
		game.addVisual(new BayaFrambu(position = game.at(5,9)))
		game.addVisual(new BayaFrambu(position = game.at(7,9)))
		
		game.addVisual(new BayaLatano(position = game.at(5,5)))
		game.addVisual(new BayaLatano(position = game.at(7,1)))
		game.addVisual(new BayaLatano(position = game.at(7,5)))
		game.addVisual(new BayaLatano(position = game.at(10,11)))
		game.addVisual(new BayaLatano(position = game.at(18,10)))
		game.addVisual(new BayaLatano(position = game.at(7,13)))
		
		game.addVisual(new BayaPinia(position = game.at(2,11)))
		game.addVisual(new BayaPinia(position = game.at(13,1)))
		game.addVisual(new BayaPinia(position = game.at(17,1)))
		game.addVisual(new BayaPinia(position = game.at(18,11)))
		game.addVisual(new BayaPinia(position = game.at(18,1)))
		
		game.addVisual(new Trampa(position = game.at(3,4), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(7,8), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(17,6), energiaQueBrinda = -10, defensaQueBrinda = -25))
		
		//////// ENEMIGOS
		
		game.addVisual(new PokemonGuardia(position = game.at(3,1), energia = 100, image = "bulbasaur-"))
		game.addVisual(new PokemonGuardia(position = game.at(14,3), energia = 120, image = "bulbasaur-"))
		game.addVisual(new PokemonGuardia(position = game.at(13,9), energia = 120, image = "bulbasaur-"))
		game.addVisual(new PokemonGuardia(position = game.at(4,6), energia = 300, image = "magmar-"))
		game.addVisual(new PokemonGuardia(position = game.at(8,4), energia = 250, image = "magmar-"))
		game.addVisual(new PokemonGuardia(position = game.at(11,1), energia = 250, image = "magmar-"))
		game.addVisual(new PokemonGuardia(position = game.at(10,7), energia = 300, image = "magmar-"))
		
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
		
		game.addVisual(new Medalla(position = game.at(3,7), image= "medalla 4.png"))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(1,4)))
		game.addVisual(new BayaFrambu(position = game.at(3,4)))
		game.addVisual(new BayaFrambu(position = game.at(16,6)))
		game.addVisual(new BayaFrambu(position = game.at(1,6)))
		game.addVisual(new BayaFrambu(position = game.at(1,7)))
		game.addVisual(new BayaFrambu(position = game.at(18,9)))
		
		game.addVisual(new BayaLatano(position = game.at(5,5)))
		game.addVisual(new BayaLatano(position = game.at(16,7)))
		game.addVisual(new BayaLatano(position = game.at(18,9)))
		game.addVisual(new BayaLatano(position = game.at(18,8)))
		game.addVisual(new BayaLatano(position = game.at(18,7)))
		game.addVisual(new BayaLatano(position = game.at(18,6)))
		
		game.addVisual(new BayaPinia(position = game.at(5,6)))
		game.addVisual(new BayaPinia(position = game.at(6,9)))
		game.addVisual(new BayaPinia(position = game.at(18,1)))
		game.addVisual(new BayaPinia(position = game.at(10,1)))
		game.addVisual(new BayaPinia(position = game.at(16,7)))
		game.addVisual(new BayaPinia(position = game.at(16,6)))
		game.addVisual(new BayaPinia(position = game.at(16,5)))
		
		game.addVisual(new Trampa(position = game.at(5,4), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(8,5), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(8,11), energiaQueBrinda = -10, defensaQueBrinda = -20))
		game.addVisual(new Trampa(position = game.at(15,3), energiaQueBrinda = -5, defensaQueBrinda = -5))
		game.addVisual(new Trampa(position = game.at(16,1), energiaQueBrinda = -10, defensaQueBrinda = -25))
		
		//////// ENEMIGOS
		
		game.addVisual(new PokemonGuardia(position = game.at(11,1), energia = 200, image = "kadabra-"))
		game.addVisual(new PokemonGuardia(position = game.at(2,11), energia = 150, image = "kadabra-"))
		game.addVisual(new PokemonGuardia(position = game.at(7,7), energia = 250, image = "kadabra-"))
		game.addVisual(new PokemonGuardia(position = game.at(5,9), energia = 100, image = "kadabra-"))
		game.addVisual(new PokemonGuardia(position = game.at(10,5), energia = 350, image = "kadabra-"))
		game.addVisual(new PokemonGuardia(position = game.at(14,3), energia = 300, image = "kadabra-"))
		game.addVisual(new Pokemon(position = game.at(13,1), energia = 150, image = "lapras-izq.png")) 
		game.addVisual(new Pokemon(position = game.at(12,1), energia = 175, image = "kadabra-izq.png"))
		game.addVisual(new Pokemon(position = game.at(14,11), energia = 150, image = "lapras-izq.png"))
		
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
		
		game.addVisual(new Pokeball(position = game.at(11,7), nivelActual = self))
		
		game.addVisual(new Medalla(position = game.at(13,3), image= "medalla 5.png"))
		game.addVisual(new Medalla(position = game.at(7,9), image= "medalla 6.png"))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(2,1)))
		game.addVisual(new BayaFrambu(position = game.at(1,10)))
		game.addVisual(new BayaFrambu(position = game.at(9,2)))
		game.addVisual(new BayaFrambu(position = game.at(11,11)))
		game.addVisual(new BayaFrambu(position = game.at(13,1)))
		
		game.addVisual(new BayaLatano(position = game.at(1,11)))
		game.addVisual(new BayaLatano(position = game.at(7,3)))
		game.addVisual(new BayaLatano(position = game.at(7,7)))
		game.addVisual(new BayaLatano(position = game.at(17,7)))
		game.addVisual(new BayaLatano(position = game.at(17,11)))
		
		game.addVisual(new BayaPinia(position = game.at(11,6)))
		game.addVisual(new BayaPinia(position = game.at(11,9)))
		game.addVisual(new BayaPinia(position = game.at(15,3)))
		game.addVisual(new BayaPinia(position = game.at(16,11)))
		game.addVisual(new BayaPinia(position = game.at(18,7)))
		game.addVisual(new BayaPinia(position = game.at(13,5)))
		
		game.addVisual(new Trampa(position = game.at(4,1), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(5,5), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(11,5), energiaQueBrinda = -10, defensaQueBrinda = -25))
		game.addVisual(new Trampa(position = game.at(11,8), energiaQueBrinda = -10, defensaQueBrinda = -20))
		game.addVisual(new Trampa(position = game.at(18,1), energiaQueBrinda = -15, defensaQueBrinda = -5))
		
		//////// ENEMIGOS
		
		game.addVisual(new PokemonGuardia(position = game.at(8,1), energia = 300, image = "magnemite-"))
		game.addVisual(new PokemonGuardia(position = game.at(16,3), energia = 350, image = "scyther-"))
		game.addVisual(new PokemonGuardia(position = game.at(12,7), energia = 300, image = "magnemite-"))
		game.addVisual(new PokemonGuardia(position = game.at(2,7), energia = 350, image = "scyther-"))
		game.addVisual(new PokemonGuardia(position = game.at(16,9), energia = 350, image = "magnemite-"))
		game.addVisual(new PokemonGuardia(position = game.at(6,11), energia = 300, image = "scyther-"))
		game.addVisual(new Pokemon(position = game.at(11,3), energia = 100, image = "scyther-izq.png"))
		game.addVisual(new Pokemon(position = game.at(4,5), energia = 200, image = "magnemite-izq.png"))
		game.addVisual(new Pokemon(position = game.at(15,5), energia = 200, image = "scyther-izq.png"))
		game.addVisual(new Pokemon(position = game.at(14,11), energia = 100, image = "magnemite-izq.png"))
		
		
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
	method terminarJuego() { 
		entrenador.meEncontre(charmander)
	}
	
	method levantarLaberinto() {
		game.addVisual(entrenador)
		
		game.addVisual(new Medalla(position = game.at(17,2), image= "medalla 7.png"))
		game.addVisual(new Medalla(position = game.at(11,11), image= "medalla 8.png"))
		
		//////// BAYAS Y TRAMPAS
		game.addVisual(new BayaFrambu(position = game.at(1,4)))
		game.addVisual(new BayaFrambu(position = game.at(3,2)))
		game.addVisual(new BayaFrambu(position = game.at(6,1)))
		game.addVisual(new BayaFrambu(position = game.at(9,5)))
		game.addVisual(new BayaFrambu(position = game.at(13,5)))
		
		game.addVisual(new BayaLatano(position = game.at(1,10)))
		game.addVisual(new BayaLatano(position = game.at(3,9)))
		game.addVisual(new BayaLatano(position = game.at(15,11)))
		
		game.addVisual(new BayaPinia(position = game.at(3,7)))
		game.addVisual(new BayaPinia(position = game.at(11,2)))
		game.addVisual(new BayaPinia(position = game.at(18,2)))
		game.addVisual(new BayaPinia(position = game.at(18,6)))
		
		game.addVisual(new Trampa(position = game.at(5,1), energiaQueBrinda = -25, defensaQueBrinda = -10))
		game.addVisual(new Trampa(position = game.at(7,11), energiaQueBrinda = -15, defensaQueBrinda = -15))
		game.addVisual(new Trampa(position = game.at(10,1), energiaQueBrinda = -10, defensaQueBrinda = -25))
		game.addVisual(new Trampa(position = game.at(13,9), energiaQueBrinda = -10, defensaQueBrinda = -20))
		game.addVisual(new Trampa(position = game.at(17,1), energiaQueBrinda = -5, defensaQueBrinda = -10))
		
		//////// ENEMIGOS
		
		game.addVisual(new PokemonGuardia(position = game.at(4,11), energia = 350, image = "onix-"))
		game.addVisual(new PokemonGuardia(position = game.at(11,9), energia = 400, image = "jigglypuff-"))
		game.addVisual(new PokemonGuardia(position = game.at(14,5), energia = 400, image = "onix-"))
		game.addVisual(new Pokemon(position = game.at(6,5), energia = 250, image = "onix-izq.png"))
		game.addVisual(new Pokemon(position = game.at(7,7), energia = 200, image = "jigglypuff-izq.png"))
		game.addVisual(new Pokemon(position = game.at(7,9), energia = 100, image = "onix-izq.png"))
		game.addVisual(new Pokemon(position = game.at(9,11), energia = 200, image = "jigglypuff-izq.png"))
		game.addVisual(new Pokemon(position = game.at(12,3), energia = 250, image = "onix-izq.png"))
		game.addVisual(new Pokemon(position = game.at(14,9), energia = 200, image = "jigglypuff-izq.png"))
		game.addVisual(new Pokemon(position = game.at(17,11), energia = 250, image = "onix-izq.png"))
		game.addVisual(new Pokemon(position = game.at(18,4), energia = 100, image = "jigglypuff-izq.png"))
		
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