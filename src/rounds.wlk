import wollok.game.*
import contrincante.*
import jugador.*
import visuales.*

object campeonesAleatorios {
	const campeones = [new AsheVisual(), new BraumVisual(), new VayneVisual(), new ZedVisual()]
	
	method devolver(){
		const posicion = 0.randomUpTo(campeones.size()).roundUp() - 1
		return campeones.get(posicion)
	}
	
	method agregarAContrincante(){ contrincante.campeonesInventario().add(self.devolver()) }
}

object roundVisual {
	var property position = game.at(1,1)
	var round = 0
	
	method image() = "imagenes/Visuales/rounds/" + round + ".png"
	
	method generarVisual(){
		game.addVisual(self)
	}
	
	method avanzarRound(){ 
		round++
	}
}

// Rounds
object primerRound {
	
	const campeonesTotal = 1
	const siguienteRound = segundoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 4
	method vidaPorCampeon() = 2
	
}

object segundoRound {
	const campeonesTotal = 2
	const siguienteRound = tercerRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 4
	method vidaPorCampeon() = 2
}

object tercerRound {
	const campeonesTotal = 2
	const siguienteRound = cuartoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 5
	method vidaPorCampeon() = 3
}

object cuartoRound {
	const campeonesTotal = 3
	const siguienteRound = quintoRound

	method siguiente(){
		roundVisual.avanzarRound()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 6
	method vidaPorCampeon() = 3
}

object quintoRound {
	const campeonesTotal = 3
	const siguienteRound = sextoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 7
	method vidaPorCampeon() = 3
}

object sextoRound {
	const campeonesTotal = 4
	const siguienteRound = septimoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 7
	method vidaPorCampeon() = 3
}

object septimoRound {
	const campeonesTotal = 4
	const siguienteRound = octavoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 8
	method vidaPorCampeon() = 3
}

object octavoRound {
	const campeonesTotal = 5
	const siguienteRound = novenoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 8
	method vidaPorCampeon() = 3
}

object novenoRound {
	const campeonesTotal = 6
	const siguienteRound = decimoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 8
	method vidaPorCampeon() = 3
}

object decimoRound {
	const campeonesTotal = 6
	const siguienteRound = ultimoRound
	
	method siguiente(){
		roundVisual.avanzarRound()
		nivelDelJugador.subirNivel()
		return siguienteRound
	}
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 10
	method vidaPorCampeon() = 3
}

object ultimoRound {
	const campeonesTotal = 7
	
	method siguiente() = ultimoRound
	
	method preparar(){
		contrincante.campeonesInventario().clear()
		campeonesTotal.times({ i => campeonesAleatorios.agregarAContrincante() })
	}
	
	method vidaPorJugador() = 10
	method vidaPorCampeon() = 3
}