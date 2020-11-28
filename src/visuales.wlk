import wollok.game.*
import generadores.*
import campeones.*
import jugador.*
import combate.*

class CampeonVisual {
	
	method campeonAsociado()
	method campeonAsociado(nuevoCampeon)
	
	method position()
	method position(nuevaPosicion)
	method image()
	method barraDeVida()
	
	method velocidadDeAtaque()
	method rango()
	
	method criterioDeBusqueda()
	
	method targetAtaque()
	method targetAtaque(nuevoTarget)
	
	method indexTick()
	
	method analizarVida(){
		self.barraDeVida().cambiarImagen(self.campeonAsociado())
		self.muerte()
	}
	
	method muerte() { if (self.campeonAsociado().estaMuerto()) combate.removerDelCombate(self)  }
	
	method moverse(otroCampeon){
		const x1 = self.position().x()
		const y1 = self.position().y()
		const x2 = otroCampeon.position().x()
		const y2 = otroCampeon.position().y()
		
		if (y2 > y1){ 		//UNO ARRIBA
			self.position(game.at(x1,y1+1))
			self.barraDeVida().position(game.at(x1,y1+2))
		} else if (y2 < y1){ //UNO ABAJO
			self.position(game.at(x1,y1-1))
			self.barraDeVida().position(game.at(x1,y1))
		} else if (x2 > x1){ //UNO DERECHA
			self.position(game.at(x1+1,y1))
			self.barraDeVida().position(game.at(x1+1,y1+1))
		} else if (x2 < x1){ //UNO IZQUIERDA
			self.position(game.at(x1-1,y1))
			self.barraDeVida().position(game.at(x1-1,y1+1))
		}
	}
	
	method configurarTarget(){
		game.onTick(1400, "Index" + self.indexTick(), {
			const listaDeEnemigos = combate.buscarEnemigos(self)
			if(listaDeEnemigos.size() > 0){
				const enemigo = self.buscarEnemigoMasApropiado(listaDeEnemigos)
				self.asignarTarget(enemigo)
			} else {
				game.removeTickEvent("Index" + self.indexTick())
			}
		})
	}
	
	method buscarEnemigoMasApropiado(listaDeEnemigos){
		return self.criterioDeBusqueda().buscar(listaDeEnemigos, self)
	}
		
	method puedeAtacar(enemigo) = combate.distanciaEntreCampeones(self, enemigo) <= self.rango()
	
	method asignarTarget(enemigo){
		if(self.puedeAtacar(enemigo)){
			game.removeTickEvent("Index" + self.indexTick())
			self.targetAtaque(enemigo)
			self.estrategiaDeCombate()
		} else {
			self.moverse(enemigo)
		}
	}
	
	method estrategiaDeCombate(){
		game.onTick(self.velocidadDeAtaque(), "Index" + self.indexTick(), {
			if(self.targetAtaque() != null){
				self.campeonAsociado().estrategiaOfensiva(self.targetAtaque().campeonAsociado())
			} else {
				game.removeTickEvent("Index" + self.indexTick())
				self.configurarTarget()
			}
		})
	}
}

class AsheVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = new AsheTienda()
	
	var property position = null
	var property image =  "imagenes/Campeones/ashe.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1450
	var property rango = 2
	
	var property criterioDeBusqueda = elMasCercano
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Ashe())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new AsheVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

class BraumVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = new BraumTienda()
	
	var property position = null
	var property image =  "imagenes/Campeones/braum.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1800
	var property rango = 1
	
	var property criterioDeBusqueda = elMasCercano
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Braum())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new BraumVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

class EnemigoVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = null
	
	var property position = null
	var property image =  "imagenes/Campeones/enemigo.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1600
	var property rango = 2
	
	var property criterioDeBusqueda = elMasCercano
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Enemigo())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new EnemigoVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

class VayneVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = new VayneTienda()
		
	var property position = null
	var property image =  "imagenes/Campeones/vayne.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1400
	var property rango = 2
	
	var property criterioDeBusqueda = elMasCercano
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Vayne())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new VayneVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

class ZedVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = new ZedTienda()
		
	var property position = null
	var property image =  "imagenes/Campeones/zed.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1250
	var property rango = 1
	
	var property criterioDeBusqueda = elMasCercano
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Zed())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new ZedVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

class YoneVisual inherits CampeonVisual {
	
	var property campeonAsociado = null
	var property generadorAsociado = new YoneTienda()
		
	var property position = null
	var property image =  "imagenes/Campeones/yone.png"
	var property barraDeVida = new BarraVidaCampeones()
	
	var property velocidadDeAtaque = 1350
	var property rango = 1
	
	var property criterioDeBusqueda = elDeMenosVida
	
	var property targetAtaque = null
	var property indexTick = null
	
	method asociarCampeon(){
		self.campeonAsociado(new Yone())
		self.campeonAsociado().visualAsociada(self)
	}
	
	method crearVisual(x, y){
		const visual = new YoneVisual(position = game.at(x,y))	
		const barraVida = visual.barraDeVida()
		
		game.addVisual(visual)
		barraVida.asignar(x, y)
		
		return visual
	}
}

// ******************* BARRA DE VIDA *******************

class BarraDeVida{
	var property position = null
	method image()
	method image(nuevaImagen)
	
	method asignar(x,y){
		position = game.at(x,y+1)
		game.addVisual(self)
	}
}

class BarraVidaCampeones inherits BarraDeVida {
	var property image = "imagenes/Visuales/campeones_barra_de_vida/vida_100.png"
	
	method cambiarImagen(alguien){
		const porcentajeDeVida = (alguien.vida()/alguien.vidaInicial()).roundUp(1) * 100
		self.image("imagenes/Visuales/campeones_barra_de_vida/vida_" + porcentajeDeVida.toString() + ".png")
	}
}

class BarraVidaJugador inherits BarraDeVida {
	var property image = "imagenes/Visuales/jugador_barra_de_vida/vida_jugador_100.png"
	
	method cambiarImagen(alguien){
		const porcentajeDeVida = (alguien.vida()/alguien.vidaInicial()).roundUp(1) * 100
		self.image("imagenes/Visuales/jugador_barra_de_vida/vida_jugador_" + porcentajeDeVida.toString() + ".png")
	}
}

class BarraVidaContrincante inherits BarraDeVida {
	var property image = "imagenes/Visuales/contrincante_barra_de_vida/vida_contrincante_100.png"
	
	method cambiarImagen(alguien){
		const porcentajeDeVida = (alguien.vida()/alguien.vidaInicial()).roundUp(1) * 100
		self.image("imagenes/Visuales/contrincante_barra_de_vida/vida_contrincante_" + porcentajeDeVida.toString() + ".png")
	}
}

// ******************* ANIMACIONES *******************

object levelUp {
	var n = 1
	var property position = null
	
	method iniciar(){ 
		position = jugador.position()
		game.addVisual(self)
		game.onTick(80, "LevelUp", { 
			self.animar(jugador)
		})
	}
	
	method finalizar(){
		game.removeTickEvent("LevelUp")
		game.removeVisual(self)
	}
		
	method image() = "imagenes/Visuales/animaciones/levelUp/levelUp_" + n + ".png"
	
	method animar(alguien){
		n++
		position = alguien.position()
		if(n == 8){
			n = 1
			self.finalizar()
		}
	}
}

class Animacion{
	var n = 1
	var property position = null
	var campeon = null
	
	method iniciar(unCampeon, otroCampeon)
	
	method finalizar(){
		game.removeTickEvent("Animacion" + campeon.indexTick())
		game.removeVisual(self)
	}
	
	method imagen()
	method imagen(nuevaImagen)
	
	method image() = self.imagen() + n + ".png"
	
	method animar(alguien){
		n++
		position = alguien.position()
		if(n == 7){
			self.finalizar()
		}
	}
}

class Animacion_Ataque inherits Animacion {
	override method iniciar(enemigo, champ){ 
		position = enemigo.position()
		campeon = champ
		game.addVisual(self)
		game.onTick(50, "Animacion" + campeon.indexTick(), { 
			self.animar(enemigo)
		})
	}
}

class Animacion_Defensa inherits Animacion {
	override method iniciar(enemigo, champ){
		position = champ.position()
		campeon = champ
		game.addVisual(self)
		game.onTick(50, "Animacion" + campeon.indexTick(), { 
			self.animar(campeon)
		})
	}
}

class Animacion_Basico inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/basico/basico_" }
class Animacion_FlechaEncantada inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/flechaEncantada/flecha_" }
class Animacion_PonerseDuro inherits Animacion_Defensa { var property imagen = "imagenes/Visuales/animaciones/ponerseDuro/ponerseDuro_" }
class Animacion_DevolverDanio_Ataque inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/devolverDanioAtaque/devolverDanioAtaque_" }
class Animacion_DevolverDanio_Defensa inherits Animacion_Defensa { var property imagen = "imagenes/Visuales/animaciones/devolverDanioDefensa/devolverDanioDefensa_" }
class Animacion_ProyectilDePlata inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/proyectilDePlata/proyectilDePlata_" }
class Animacion_CuchilladaSombria inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/cuchilladaSombria/cuchilladaSombria_" }
class Animacion_DestinoSellado inherits Animacion_Ataque { var property imagen = "imagenes/Visuales/animaciones/destinoSellado/destinoSellado_" }




