import jugador.*
import rounds.*
import wollok.game.*
import campeones.*
import visuales.*
import teclado.*
import contrincante.*
import generadores.*
import sinergias.*
import tienda.*

object combate {

	var campeonesAliado = []
	var campeonesEnemigo = []
	
	var round = primerRound
	
	var index = 0
	
	method aliados() = return campeonesAliado
	method enemigos() = return campeonesEnemigo
	
	method nuevoCombate(){
		teclado.cambiarEstado(teclado_combate)
		index = 0
		self.prepararRound()
		self.prepararCampeones()
		self.prepararSinergias()
		self.iniciar()
	}
	
	method prepararRound(){ round.preparar() }
	
	method prepararSinergias(){
		sinergia.preparar(campeonesEnemigo)
		sinergia.preparar(campeonesAliado)
	}
	
	method prepararCampeones(){
		self.eliminarVisualesInventario()
		self.generarAliados(campeonesAliado)
		self.generarEnemigos(campeonesEnemigo)
	}
	
	method eliminarVisualesInventario(){
		jugador.borrarVisualesInventario()
	}
	
	method generarAliados(listaNueva){
		const campeonesAGenerar = jugador.campeonesInventario()
		var x = 6
		const y = 4
		campeonesAGenerar.forEach{ campeon => 
			const visual = campeon.crearVisual(x, y)
			visual.asociarCampeon()
			listaNueva.add(visual)
			x += 1
		}
	}
	
	method generarEnemigos(listaNueva){
		const campeonesAGenerar = contrincante.campeonesInventario()
		var x = 13
		const y = 9
		campeonesAGenerar.forEach{ campeon => 
			const visual = campeon.crearVisual(x, y)
			visual.asociarCampeon()
			listaNueva.add(visual)
			x -= 1
		}
	}
	
	method iniciar(){
		self.indexarTicks()
		self.combatir()
		tiempoDeCombate.iniciar()
	}
		
	method empate(){
		self.reiniciarRound()
		visualResultado.empate()
		contrincante.perderVida(5)
		jugador.perderVida(5)
		jugador.ganarRound()
	}
	
	method indexarTicks(){
		//Indexar ticks para que los ticks de los ataques sean únicos.
		campeonesAliado.forEach{ campeon => self.asignarIndex(campeon) }
		campeonesEnemigo.forEach{ campeon => self.asignarIndex(campeon) }
	}
	
	method asignarIndex(campeon){
		campeon.indexTick(index)
		index++
	}
	
	method combatir(){
		campeonesAliado.forEach{ campeon => campeon.configurarTarget() }
		campeonesEnemigo.forEach{ campeon => campeon.configurarTarget() }
	}
	
	method finalizarAtaque(campeon){
		game.removeTickEvent("Index" + campeon.indexTick())
	}
	
	method removerVisuales(campeon){
		game.removeVisual(campeon)
		game.removeVisual(campeon.barraDeVida())
	}
	
	method removerTargetsAtaque(campeon){
		const nuevaLista = campeonesAliado.filter{ enemigo => enemigo.targetAtaque() == campeon } +
						 	campeonesEnemigo.filter{ enemigo => enemigo.targetAtaque() == campeon }
						 
		nuevaLista.forEach{ alguien => alguien.targetAtaque(null) }
	}
	
	method eliminarCampeonesEnArena(){
		campeonesAliado.forEach{ campeon => self.removerCampeon(campeon) }
		campeonesEnemigo.forEach{ campeon => self.removerCampeon(campeon) }
	}
	
	method reiniciarCampeones(){
		jugador.actualizarVisualesInventario()
	}
	
	method reiniciarRound(){
		tiempoDeCombate.finalizar()
		self.eliminarCampeonesEnArena()
		self.reiniciarCampeones()
		tienda.reiniciar()
		sinergia.reiniciarSinergias()
		round = round.siguiente()
		teclado.cambiarEstado(teclado_tienda)
	}
	
	method esElUltimo(){
		if(campeonesAliado.isEmpty()){
			const danio = self.perderVidaSegunCampeones(campeonesEnemigo)
			visualResultado.derrota()
			self.reiniciarRound()
			jugador.perderRound(danio)
		} else if (campeonesEnemigo.isEmpty()){
			jugador.ganarRound()
			const danio = self.perderVidaSegunCampeones(campeonesAliado)
			visualResultado.victoria()
			self.reiniciarRound()
			contrincante.perderRound(danio)
		}
	}
	
	method perderVidaSegunCampeones(listaDeCampeones){
		return listaDeCampeones.size() * round.vidaPorCampeon() + round.vidaPorJugador()
	}
	
	method removerCampeon(campeon){
		campeonesAliado.remove(campeon)
		campeonesEnemigo.remove(campeon)
		self.removerTargetsAtaque(campeon)
		self.finalizarAtaque(campeon)
		self.removerVisuales(campeon)
	}
	
	method removerDelCombate(campeon){
		self.removerCampeon(campeon)
		self.esElUltimo()
	}
	
	// Funciones auxiliares
	
	method buscarEnemigos(campeon){
		const estaAliado = campeonesAliado.any{alguien => alguien == campeon}
		if(estaAliado){
			return campeonesEnemigo
		} else {
			return campeonesAliado
		}
	}
	
	method distanciaEntreCampeones(unCampeon, otroCampeon){
		const x1 = unCampeon.position().x()
		const x2 = otroCampeon.position().x()
		const y1 = unCampeon.position().y()
		const y2 = otroCampeon.position().y()
		
		return ((x2-x1).square() + (y2-y1).square()).squareRoot().roundUp()
	}
}

object visualResultado {
	var property position = game.at(1,2)
	var property image = "imagenes/Visuales/resultado/victoria.png"

	method mostrar(){
		game.addVisual(self)
		game.schedule(6000, {game.removeVisual(self)})
	}

	method victoria(){
		self.image("imagenes/Visuales/resultado/victoria.png")
		self.mostrar()
	}
	
	method derrota(){
		self.image("imagenes/Visuales/resultado/derrota.png")
		self.mostrar()
	}
	
	method empate(){
		self.image("imagenes/Visuales/resultado/empate.png")
		self.mostrar()
	}
}

// ************************************************************

object tiempoDeCombate {
	var tiempo = 0
	
	method iniciar(){
		game.onTick(1000, "Cronometro", {
			if(tiempo == 40){
				combate.empate()
			} else {
				tiempo++
			}
		})
	}
	
	method finalizar(){
		tiempo = 0
		game.removeTickEvent("Cronometro")
	}
}

// ******************* CRITERIOS DE BÚSQUEDA  *******************

object elDeMenosVida {
	method buscar(listaDeEnemigos, campeon){
		return listaDeEnemigos.min({ enemigo => enemigo.campeonAsociado().vida() })
	}
}

object elMasCercano {
	method buscar(listaDeEnemigos, campeon){
		return listaDeEnemigos.min({ enemigo => combate.distanciaEntreCampeones(campeon, enemigo)})
	}
}

