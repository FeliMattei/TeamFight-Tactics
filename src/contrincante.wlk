import configuracion.*
import wollok.game.*
import generadores.*
import sinergias.*
import campeones.*
import visuales.*
import jugador.*

object contrincante {
	
	var property vidaInicial = 100
	var property vida = vidaInicial
	var property campeonesInventario = []
	
	var property barraDeVida = new BarraVidaContrincante()
	
	var property position = null
	method image() = "imagenes/Invocadores/contrincante.png"
	
	method perderVida(danio){
		vida = (vida - danio).max(0)
		barraDeVida.cambiarImagen(self)
	}
	
	method muerte(){
		game.removeVisual(self)
		game.removeVisual(barraDeVida)
		victoria.ejecutar()
	}
	
	method estaMuerto() = vida <= 0
	method perderRound(danio){
		self.perderVida(danio)
		if(self.estaMuerto()){ self.muerte() }
	}

}
