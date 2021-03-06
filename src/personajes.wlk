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
	const property medallasRecogidas = #{}
	
	method hablar() = "Char char"
	

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
	
	method meEncontre(elemento) {
		return elemento.meEncontre(self)	
	}
	
	method estoyVivo(){
		return self.energia() > 0
	}
	
	method ganar(){
		self.terminar("Gané")
		game.schedule(3000, {pantallaFinal.iniciar()})
		game.schedule(7000, {game.stop()})
	}
	
	method perder() {
		if (not self.estoyVivo()) { 
			self.terminar("Perdí")
			game.schedule(5000, {game.stop()})
		}
	}
	
	method terminar(mensaje){
		    puedoPegar = false
			game.say(self, mensaje)
			game.removeTickEvent("DANIOENEMIGO")
	}
	
	method mover(dir) {
		direccion = dir
		if (self.puedoMover(dir)) {
			self.irA(dir.siguiente(position))
		}
	}
	
	method puedoMover(dir){
		return self.estoyVivo() && self.nohayObstaculoAlFrente(dir) && self.fueraDeCombate()
	}
	
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

	
	method fueraDeCombate() {
		return (not estoyEnCombate) && puedoPegar  
	}
	
	method nohayObstaculoAlFrente(dir) {
		var obstaculos = game.getObjectsIn(dir.siguiente(position))
		obstaculos = obstaculos.filter({obstaculo => obstaculo.obstruyeElCamino()})
		return obstaculos.isEmpty()
	}
	
	method dispararFuego() {
		    self.validarGolpe()
			const fuego = new Fuego()
			fuego.animacionDeFuego()	
	}
	
	method atacarConGarra() {
		    self.validarGolpe()
			const ataqueGarra = new GarraMetal()
			ataqueGarra.animacionDeGarra()
	}
	
	method validarGolpe(){
		self.validarEstado()
	    if(!puedoPegar){
			self.error("No puedo atacar tan seguido")
		}
	}
	
	method validarEstado(){
			if(!self.estoyVivo()){
				self.error("Estoy muerto")
		}
	}
	
	
	method danioARecibir(){
		return (500..1000).anyOne() / self.defensa()
	}
	
	method decirEstado(){
		return "Energia:" + energia.toString() +
			   " Ataque:"  + ataque.toString() +
			   " Defensa:" + defensa.toString()
	}
	
	method recibirDanio() {	
		if(estoyEnCombate){
			const calculoDanio = self.danioARecibir().roundUp(0)
			energia = (energia-calculoDanio).max(0)
			self.perder()
		}	
	}
	
	method agregarMedalla(medalla) {
		medallasRecogidas.add(medalla)
	}
	
	
	method reiniciarPosicion() {
		self.position(game.at(1,1))	
	}	 
}

class Pokemon {
	var property position 
	var property energia 
	var property direccion = derecha
	var property estoyEnCombate = false
	const property image
	
	method obstruyeElCamino() = false
	
	method recibirAtaqueDe(pokemonEnemigo) { 
		game.say(self,"Entre en combate!")
		pokemonEnemigo.estoyEnCombate(true)
		self.restarEnergiaTrasAtaque(pokemonEnemigo)
		self.perdiCombateCon(pokemonEnemigo)
	}
	
	method restarEnergiaTrasAtaque(pokemonEnemigo) {
		energia = (energia - pokemonEnemigo.ataque()).max(0)
	}
	
	method perdiCombateCon(pokemon){
		if(self.estoyDebilitado()){
			pokemon.estoyEnCombate(false)
			self.perder()
		}
	}
		
	method perder(){
		if (self.estoyDebilitado()){
			game.removeVisual(self)
		}
	}
	
	method meEncontre(pokemonEnemigo){
		game.say(self,"Te atrapé")
		pokemonEnemigo.energia(0)
		pokemonEnemigo.perder()	
	}
	
	method estoyDebilitado(){
		return energia == 0
	}
	
	
}


class PokemonGuardia inherits Pokemon {
	
	method sufijo() {
		return direccion.sufijo()
	}
	
	override method image(){
		return image + self.sufijo() + ".png"
	}
	
	override method recibirAtaqueDe(pokemonEnemigo) { 
		super(pokemonEnemigo)
		self.comprobarCombate()
	}
	
	method comprobarCombate() {
		if (not self.tengoEnemigoAlFrente())
			charmander.estoyEnCombate(false)
	}
	
	// LOOP MOVIMIENTO
	
	method moverHastaEntrarEnCombate() {
		game.onTick(800, self.nombreMovimiento(), {self.moverSigPosicion()
												   self.detenerseYLuchar()})
	}
	
	method nombreMovimiento() {
		return "Movimiento Pokemon" + self.identity().toString()
	}
	
	// MOVIMIENTOS
	 
	method moverSigPosicion() {
		
	    if(self.tengoEnemigoAlFrente()){
			estoyEnCombate = true
		} 
		else if(self.meAtacaronPorDetras()){
			direccion = direccion.opuesta()
			estoyEnCombate = true
		}
		else {
			self.avanzarUnPaso()
		}
	}
	
	method avanzarUnPaso() {
		if(self.hayObstaculoAlFrente()) {
			direccion = direccion.opuesta()
		}
		
		position = direccion.siguiente(position)
	}
	
	method tengoEnemigoAlFrente() {
		const alFrente = game.getObjectsIn(direccion.siguiente(position))
		return alFrente.contains(charmander)
	}
	
	
	method meAtacaronPorDetras(){
		const atras = game.getObjectsIn(direccion.opuesta().siguiente(position))
		return atras.contains(charmander)
	}
	
	method hayObstaculoAlFrente() {
		var obstaculos = game.getObjectsIn(direccion.siguiente(position))
		obstaculos = obstaculos.filter({obstaculo => obstaculo.obstruyeElCamino()})
		return not obstaculos.isEmpty()
	}
	
	method detenerseYLuchar() {
		if(estoyEnCombate) { game.removeTickEvent(self.nombreMovimiento())  }
	}
	
	method initialize() {
		self.moverHastaEntrarEnCombate()
	}
}

class Ataque {
	
	method image()
	
	method position() {
		const dirAtaque = self.direccionDeAtaque()
		return dirAtaque.siguiente(charmander.position())
	}	
	
	method direccionDeAtaque() {
		return if(self.noEstaEnDireccionPorDefecto()) { derecha } else { charmander.direccion() }
	}
	
	method noEstaEnDireccionPorDefecto() {
		return charmander.direccion() != izquierda
	}
	
	method meEncontre(elemento) {
		elemento.recibirAtaqueDe(charmander)
	}
	
	method desaparecer() {
		game.schedule(500, { => game.removeVisual(self) })
	}
	
	
	method atacar(){
		game.addVisual(self)
		game.onCollideDo(self, {objeto => self.meEncontre(objeto)})
	    charmander.puedoPegar(false)
		game.schedule(500, { charmander.puedoPegar(true) })
		self.desaparecer()
	}
	
	method obstruyeElCamino(){
		return false
	}
}

class GarraMetal inherits Ataque {
	
	override method image() { 
		return "garra-metal-" + charmander.sufijo() + ".png"
	}
	
	method animacionDeGarra(){
		self.atacar()
	}
}

class Fuego inherits Ataque {
	
	override method image() { 
		return "disparoDeFuego-" + charmander.sufijo() + ".png"
	}
	
	method animacionDeFuego(){
		self.atacar()
		
	}
}
	

class Pokeball {

	const property position
	const property nivelActual 
	
	method image() { 
		return "pokeball.png"
	}
	
	method obstruyeElCamino() {
		return false
	}
	
	method meEncontre(protagonista){
		nivelActual.pasarDeLaberinto()
	}
	
	method recibirAtaqueDe() {
		// Sin efecto 
	}
}

object entrenador {
	const property position = game.at(16,9)
	
	method image() { 
		return "red.png"
	}
	
	method obstruyeElCamino() {
		return false
	}
	
	method meEncontre(pokemon){
		pokemon.ganar()
	}
	
	method recibirAtaqueDe(pokemon) {
		// Sin efecto 
	}
}
