import wollok.game.*
import visuales.*
import combate.*

object sinergia {
	var property sinergias = [tirador, scout, asesino]
	
	method preparar(lista){
		self.reiniciarSinergias()
		self.analizar(lista)
		var campeonesQueCumplenRequisitos = self.verificarCampeones(lista)
		self.activar(campeonesQueCumplenRequisitos)
		self.activarVisuales()
		self.reiniciarContadores()
	}
	
	method verificarCampeones(lista){ return lista.filter{ campeon => campeon.campeonAsociado().rol().cumpleRequisitos() } }
	
	method activar(lista){ lista.forEach{ campeon => campeon.campeonAsociado().rol().ejecutar(campeon) } }
	
	method analizar(lista){ lista.forEach{ campeon => campeon.campeonAsociado().rol().sumarContador() }	}
	
	method activarVisuales(){
		var activadas = sinergias.filter{ sinergia => sinergia.cumpleRequisitos() }
		activadas.forEach{ sinergia => sinergia.activar() }
	}
	
	method reiniciarContadores(){ sinergias.forEach{ sinergia => sinergia.reiniciarContador() } }
	
	method reiniciarSinergias(){ sinergias.forEach{ sinergia => sinergia.desactivar() } }
	
	method generarVisuales(){ self.sinergias().forEach{ sinergia => sinergia.generar() } }
}

object tirador {
	const requisitos = 2
	var cantidad = 0
		
	var property position = game.at(6, 1)
	var property image = "imagenes/Visuales/sinergias/tirador_off.png"
	
	method ejecutar(campeon){
		campeon.rango(campeon.rango() * 2)
	}
	
	method cumpleRequisitos() = cantidad >= requisitos
	method sumarContador(){ cantidad += 1 }
	method reiniciarContador() { cantidad = 0 }
	
	method generar(){ game.addVisual(self) }
	
	method activar(){ image = "imagenes/Visuales/sinergias/tirador_on.png" }
	
	method desactivar(){ image = "imagenes/Visuales/sinergias/tirador_off.png" }
}

object scout {
	const requisitos = 3
	var cantidad = 0
	
	var property position = game.at(5, 1)
	var property image = "imagenes/Visuales/sinergias/scout_off.png"
	
	method ejecutar(campeon){
		campeon.criterioDeBusqueda(elDeMenosVida)
	}
	
	method cumpleRequisitos() = cantidad >= requisitos
	method sumarContador(){ cantidad += 1 }
	method reiniciarContador() { cantidad = 0 }
		
	method generar(){ game.addVisual(self) }
	
	method activar(){ image = "imagenes/Visuales/sinergias/scout_on.png" }
	
	method desactivar(){ image = "imagenes/Visuales/sinergias/scout_off.png" }
}

object asesino {
	const requisitos = 2
	var cantidad = 0
	
	var property position = game.at(4, 1)
	var property image = "imagenes/Visuales/sinergias/asesino_off.png"
	
	method ejecutar(campeon){
		campeon.velocidadDeAtaque(campeon.velocidadDeAtaque() / 2)
	}
	
	method cumpleRequisitos() = cantidad >= requisitos
	method sumarContador(){ cantidad += 1 }
	method reiniciarContador() { cantidad = 0 }
		
	method generar(){ game.addVisual(self) }
	
	method activar(){ image = "imagenes/Visuales/sinergias/asesino_on.png" }
	
	method desactivar(){ image = "imagenes/Visuales/sinergias/asesino_off.png" }
}