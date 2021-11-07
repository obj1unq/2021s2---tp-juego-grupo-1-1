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
	var puedoPegar = true
	
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
	
	method hayUnObstaculoAl(dir){
		return mapaDeParedes.estanEnElCaminoDe(dir.siguiente(position)) || ( estoyEnCombate || not puedoPegar)
	}
	
	method irA(nuevaPosicion) {

		position = nuevaPosicion
	}
	
//	method siguiente(posicion) {}
	
	method dispararFuego() {
		if(puedoPegar){
			self.animacionDeFuego()
			game.onCollideDo(fuego, { objeto => fuego.meEncontro(objeto) }) 
		}
	}
	
	method animacionDeFuego(){
		game.addVisual(fuego)
	    puedoPegar = false
		game.schedule(600, { puedoPegar=true })
		fuego.desaparecer()
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
	
}



class Pokemon {
	var property position 
	var property energia 
	const property image
	
	method image() 
	
	method quemar(elemento) { }   ///////
	
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


object fuego {
	var position 
	
	method position() {
		return self.siguiente(charmander.position())
	}
	
	method siguiente(posicion) {
		return if (charmander.miraHacia(izquierda)) { 
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
	
	method quemar(elemento) {
		elemento.desaparecer()
   	}
   
    method estaEnLaMismaPosicion(algo) {  ///////
		return position == algo.position()
	}
}

object pokeball{
	
	method position() { return game.at(6,1)}
	
	method image() = "pokeball.png"
	
	method meEncontro(pokemon){
		pokemon.ganar()
	}
	
}


////////////////////////////////////////////////////////////////////////////////////

class Baya {
	var property position
	
	method image() 
	
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
    
    method desaparecer() {
    	game.removeVisual(self)
    }
    
    method meEncontro(pokemon) {
    	pokemon.modificarEnergia(self)    	
	    pokemon.modificarDefensa(self)
	    pokemon.perder()
   }
}



