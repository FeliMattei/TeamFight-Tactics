import configuracion.*
import wollok.game.*
import generadores.*
import sinergias.*
import campeones.*
import visuales.*
import tienda.*

object jugador {

	var property vidaInicial = 100
	var property vida = vidaInicial
	var property campeonesInventario = []
	var property visualesInventario = []
	var property campeonesEnElBanco = []
	var property visualesBanco = []
	
	var property nivel = 1
	var property oro = 200
	
	var property barraDeVida = new BarraVidaJugador()
	
	var property position = null
	method image() = "imagenes/Invocadores/jugador.png"
	
	method actualizarVisualesBanco(){
		self.borrarVisualesBanco()
		var x = 5
		const y = 3
		campeonesEnElBanco.forEach{ campeon =>
			self.visualesBanco().add(campeon.generarVisual(x, y))
			x += 1
		}
	}
	
	method actualizarVisualesInventario(){
		self.borrarVisualesInventario()
		var x = 6
		const y = 4
		campeonesInventario.forEach{ campeon =>
			self.visualesInventario().add(campeon.crearVisual(x, y))
			x += 1
		}
	}
	
	method borrarVisualesBanco(){
		visualesBanco.forEach{ campeon => 
			game.removeVisual(campeon)
			visualesBanco.remove(campeon)
		}
	}
	
	method borrarVisualesInventario(){
		visualesInventario.forEach{ campeon => 
			game.removeVisual(campeon)
			game.removeVisual(campeon.barraDeVida())
			visualesInventario.remove(campeon)
		}
	}
	
	method moverAlBanco(campeon){
		self.campeonesEnElBanco().add(campeon)
		self.actualizarVisualesBanco()
	}
	
	method moverAlInventario(index){
		if(campeonesEnElBanco.size() >= index + 1){
			if(self.tieneEspacioEnElInventario()){
				const campeonAMover = campeonesEnElBanco.get(index)
				const visualAMover = visualesBanco.get(index)
				campeonesEnElBanco.remove(campeonAMover)
				campeonesInventario.add(visualAMover)
				self.actualizarVisualesBanco()
				self.actualizarVisualesInventario()
			} else {
				game.say(jugador, "Solo pueden combatir " + nivel + " campeones.")
			}
		} else {
			game.say(jugador, "No hay un campeón en esa posición")
		}
	}
	
	method moverAlBancoDesdeInventario(index){
		if(campeonesInventario.size() >= index + 1){
			if(self.tieneEspacioEnElBanco()){
				const campeonAMover = campeonesInventario.get(index)
				const visualAMover = visualesInventario.get(index)
				campeonesInventario.remove(campeonAMover)
				campeonesEnElBanco.add(visualAMover.generadorAsociado())
				self.actualizarVisualesBanco()
				self.actualizarVisualesInventario()
			} else {
				game.say(jugador, "Solo puedo tener 9 campeones en el banco.")
			}
		} else {
			game.say(jugador, "No hay un campeón en esa posición")
		}
	}
	
	method venderCampeonDelBanco(index){
		if(campeonesEnElBanco.size() >= index + 1){
			const campeonAMover = campeonesEnElBanco.get(index)
			const visualAMover = visualesBanco.get(index)
			self.ganarOro(campeonAMover.precio())
			game.say(jugador, "+" + campeonAMover.precio() + " monedas de oro.")
			campeonesEnElBanco.remove(campeonAMover)
			self.actualizarVisualesBanco()
		} else {
			game.say(jugador, "No hay un campeón en esa posición")
		}
	}
	
	method perderVida(danio){
		vida = (vida - danio).max(0)
		barraDeVida.cambiarImagen(self)
	}
	
	// Cada 10 de oro suma uno (acumulable hasta 5)
	method analizarEconomia(){ return oro.div(10).min(5) }
	
	method ganarOro(cantidad){ 
		oro += cantidad
		tienda.verificarPrecios()
	}
	
	method restarOro(cantidad){ 
		oro -= cantidad
		tienda.verificarPrecios()
	}
	
	method muerte(){
		game.removeVisual(self)
		game.removeVisual(barraDeVida)
		derrota.ejecutar()
	}
	
	method ganarRound(){ self.ganarOro(3 + self.analizarEconomia()) }
	method perderRound(danio){ 
		self.perderVida(danio)
		if(self.estaMuerto()){ self.muerte() }
		self.ganarOro(3 + self.analizarEconomia())
	}
	
	method tieneCampeones() = campeonesInventario.size() > 0 || campeonesEnElBanco.size() > 0
	method tieneElOro(cantidad) = oro >= cantidad
	method tieneEspacioEnElBanco() = campeonesEnElBanco.size() < 9
	method tieneEspacioEnElInventario() = campeonesInventario.size() < nivel
	method estaMuerto() = vida <= 0
}

object nivelDelJugador {
	var property position = game.at(2,1)
	var property nivel = 1
	
	method image() = "imagenes/Visuales/niveles/" + nivel + ".png"
	
	method generarVisual(){
		game.addVisual(self)
	}
	
	method subirNivel(){ 
		self.nivel((self.nivel() + 1).min(7))
		jugador.nivel(self.nivel())
		levelUp.iniciar()
	}
}
