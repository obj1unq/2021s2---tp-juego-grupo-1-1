import wollok.game.*
import inicio.*
import complementos.*


object charmander {
	
	var property position = game.at(1,1)
	var property energia = 100
	var property ataque = 40
	var property defensa = 100 
	var property direccion = izquierda
	var property estoyEnCombate = false
	var property puedoPegar = true
	
	method hablar() = "Char char"
	method perdi() = "Me quedé sin energia, perdí!"
	
	
	method image() {
		return "charmander-" + self.sufijo() + ".png"
	}
	
	method sufijo() {
		return if (self.miraHacia(izquierda)) { "izq" } else { "der" }
	}
	
	method miraHacia(dir) {
		return direccion == dir
	}
	
	method modificarEnergia(elemento) {
		energia = (energia + elemento.energiaQueBrinda()).max(0)
	}
	
	method modificarDefensa(elemento) {
		defensa = (defensa + elemento.defensaQueBrinda()).max(1)
	}
	
	method modificarAtaque(elemento){
		ataque = ataque + elemento.ataqueQueBrinda()
	}
	
	method meEncontro(elemento) {
		return elemento.meEncontro(self)	
	}
	
	method estoyVivo(){
		return self.energia() > 0
	}
	
	method ganar(){
		puedoPegar = false
		game.removeVisual(self)
		game.schedule(4000, {game.stop()})
	}
	
	method perder() {
		if (not self.estoyVivo()) { 
			puedoPegar = false
			game.say(self, self.perdi())
			game.schedule(1500, {game.stop()})
			self.validarFinDeNivel()
		}
	}
	
	method validarFinDeNivel() {
		if (not self.estoyVivo()) {
			self.error("Fin")
		}
	}
	
	method mover(dir) {
		self.validarFinDeNivel()
		direccion = dir
		if (self.puedoMover(dir)) {
			self.irA(dir.siguiente(position))
		}
		
	}
	
	method puedoMover(dir){
		return self.estoyVivo() && not self.hayUnObstaculoAl(dir)  
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method hayUnObstaculoAl(dir){
		return self.hayObstaculoAlFrente(dir) || ( estoyEnCombate || not puedoPegar)
	}
	
	method hayObstaculoAlFrente(dir) {
		var obstaculos = game.getObjectsIn(dir.siguiente(position))
		obstaculos = obstaculos.filter({obstaculo => obstaculo.obstruyeElCamino()})
		return not obstaculos.isEmpty()
	}
	
	method dispararFuego() {
		if(puedoPegar) {
			const fuego = new Fuego()
			fuego.animacionDeFuego()
			game.onCollideDo(fuego, {objeto => fuego.meEncontro(objeto)})
		}
	}
	
	method atacarConGarra() {
		if(puedoPegar) {
			const ataqueGarra = new GarraMetal()
			ataqueGarra.animacionDeGarra()
			game.onCollideDo(ataqueGarra, {objeto => ataqueGarra.meEncontro(objeto)})
		}
	}
	
	method danioARecibir(){
		return (500..1000).anyOne() / self.defensa()
	}
	
	method recibirDanio() {	
		if(estoyEnCombate){
			const calculoDanio = self.danioARecibir().roundUp(0)
			energia = (energia-calculoDanio).max(0)
			self.perder()
		}	
	}
	
	method reiniciarPosicion() {
		self.position(game.at(1,1))	
	}	 
}

class Pokemon {
	var property position 
	var property energia 
	const property image
	
	method image() 
	
	method obstruyeElCamino() = false
	
//	method quemar(elemento) { }   ///////
	
	method desaparecer() { 
		game.say(self,"Entre en combate!")
		charmander.estoyEnCombate(true)
		energia = (energia - charmander.ataque()).max(0)
		self.perder()
	}
	method meEncontro(unPoke){
		game.say(self,"Te atrapé")
		unPoke.energia(0)
		unPoke.perder()
		
	}	
	method perder(){
		if (not self.estoyVivo()){
			game.removeVisual(self)
			charmander.estoyEnCombate(false)
		}
	}
	
	method estoyVivo(){
		return energia > 0
	}
}


class Ataque {
	
	method image()
	
	method position() {
		const dirAtaque = self.direccionDeAtaque()
		return dirAtaque.siguiente(charmander.position())
	}	
	
	method direccionDeAtaque() {
		return if(self.estaEnDireccionInadecuada()) { derecha } else { charmander.direccion() }
	}
	
	method estaEnDireccionInadecuada() {
		return charmander.direccion() != izquierda
	}
	
	method meEncontro(elemento) {
		elemento.desaparecer()
	}
	
	method desaparecer() {
		game.schedule(500, { => game.removeVisual(self) })
	}
	
//	method atacar(elemento) {
//		elemento.desaparecer()
//   }
   
    method estaEnLaMismaPosicion(algo) {  ///////
		return self.position() == algo.position()
	}
}


class GarraMetal inherits Ataque {
	
	override method image() { 
		return "garra-metal-" + charmander.sufijo() + ".png"
	}
	
	method animacionDeGarra(){
		game.addVisual(self)
	    charmander.puedoPegar(false)
		game.schedule(600, { charmander.puedoPegar(true) })
		self.desaparecer()
	}
}


class Fuego inherits Ataque {
	
	override method image() { 
		return "disparoDeFuego-" + charmander.sufijo() + ".png"
	}
	
	method animacionDeFuego(){
		game.addVisual(self)
	    charmander.puedoPegar(false)
		game.schedule(600, { charmander.puedoPegar(true) })
		self.desaparecer()
	}
}

class Pokeball {

	const property position
	const property nivelActual 
	
	method image() = "pokeball.png"
	
	method obstruyeElCamino() = false
	
	method meEncontro(pokemon){
		nivelActual.pasarDeLaberinto()
	}
	
	method desaparecer() {}
}


////////////////////////////////////////////////////////////////////////////////////

class Baya {
	var property position
	
	method image() 
	
	method obstruyeElCamino() = false
	
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
	
    method image() = "trampa.png"
    
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