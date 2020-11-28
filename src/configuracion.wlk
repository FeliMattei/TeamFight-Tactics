import wollok.game.*
import contrincante.*
import campeones.*
import jugador.*
import teclado.*
import combate.*
import rounds.*
import tienda.*
import sinergias.*

object juego {
	
	method iniciar(){
		self.configurar()
		game.start()
	}
	
	method configurar(){
		self.configurarVentana()
		self.configurarInvocadores()
		self.configurarTienda()
		self.configurarSinergias()
		self.configurarStatsVisuales()
		inicio.ejecutar()
		teclado.configurar()
	}
		
	method configurarVentana() {
		game.title("Teamfight Tactics")
		game.boardGround("imagenes/Escenarios/arena.png")
		game.width(20)
		game.height(12)
	}
	
	method configurarInvocadores(){
		self.configurarJugador()
		self.configurarContrincante()
	}
	
	method configurarJugador(){
		const posicion = game.at(4, 4)
		jugador.position(posicion)
		game.addVisual(jugador)
		jugador.barraDeVida().asignar(4, 4)
	}
	
	method configurarContrincante(){
		const posicion = game.at(14, 10)
		contrincante.position(posicion)
		game.addVisual(contrincante)
		contrincante.barraDeVida().asignar(14, 10)
	}
	
	method configurarStatsVisuales(){
		nivelDelJugador.generarVisual()
		roundVisual.generarVisual()
	}
	
	method configurarTienda(){
		tienda.reiniciar()
	}
	
	method configurarSinergias(){
		sinergia.generarVisuales()
	}
}

object victoria{
	var property position = game.at(0,0)
	method image() = "imagenes/Escenarios/victoria.png"
	method ejecutar(){ 
		teclado.estado(teclado_final)
		game.schedule(700, { game.addVisual(self)} )
	}
}

object derrota{
	var property position = game.at(0,0)
	method image() = "imagenes/Escenarios/derrota.png"
	method ejecutar(){ 
		teclado.estado(teclado_final)
		game.schedule(700, { game.addVisual(self)} )
	}
}

object inicio{
	var property position = game.at(0,0)
	method image() = "imagenes/Escenarios/inicio.png"
	method ejecutar(){ 
		game.schedule(300, { game.addVisual(self) } )
	}
	method remover(){
		teclado.estado(teclado_tienda)
		game.removeVisual(self)
	}
}
