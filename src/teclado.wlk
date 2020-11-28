import configuracion.*
import contrincante.*
import wollok.game.*
import campeones.*
import combate.*
import jugador.*
import tienda.*

object teclado {

	var property estado = teclado_inicio

	var property position = game.at(8, 1)
	var property image = "imagenes/Visuales/estados/teclado_tienda.png"
	
	method configurar(){
		game.addVisual(self)

		keyboard.c().onPressDo{ estado.onPressC() }
		keyboard.i().onPressDo{ estado.onPressI() }
		keyboard.b().onPressDo{ estado.onPressB() }
		keyboard.v().onPressDo{ estado.onPressV() }
		
		keyboard.num1().onPressDo{ estado.onPressNum1() }
		keyboard.num2().onPressDo{ estado.onPressNum2() }
		keyboard.num3().onPressDo{ estado.onPressNum3() }
		keyboard.num4().onPressDo{ estado.onPressNum4() }
		keyboard.num5().onPressDo{ estado.onPressNum5() }
		keyboard.num6().onPressDo{ estado.onPressNum6() }
		keyboard.num7().onPressDo{ estado.onPressNum7() }
		keyboard.num8().onPressDo{ estado.onPressNum8() }
		keyboard.num9().onPressDo{ estado.onPressNum9() }
		keyboard.d().onPressDo{ estado.onPressD() }
		keyboard.g().onPressDo{ estado.onPressG() }
		keyboard.enter().onPressDo{ estado.onPressEnter() }
	}
	
	method cambiarEstado(nuevoEstado) { 
		estado = nuevoEstado
		image = "imagenes/Visuales/estados/" + nuevoEstado + ".png"
	}
}

class EstadoSelector {
	
	method onPressC() { teclado.cambiarEstado(teclado_tienda) }
	method onPressI() { teclado.cambiarEstado(teclado_banco) }
	method onPressB() { teclado.cambiarEstado(teclado_inventario) }
	method onPressV() { teclado.cambiarEstado(teclado_venta) }
	method onPressD() { 			
		if(jugador.tieneElOro(2) && jugador.tieneCampeones()){
				tienda.reiniciar()
				jugador.restarOro(2)	
			} else {
				game.say(jugador, "No tengo oro suficiente.")
		} 
	}
	method onPressG() { game.say(jugador, "Tengo " + jugador.oro() + " monedas de oro.") }
	method onPressEnter() {
		if(jugador.campeonesInventario().size() >= 1) {
			combate.nuevoCombate()
		} else {
			game.say(jugador, "¡¡No puedo empezar sin campeones!!")
		} 
	}
	method onPressNum1() {}
	method onPressNum2() {}
	method onPressNum3() {}
	method onPressNum4() {}
	method onPressNum5() {}
	method onPressNum6() {}
	method onPressNum7() {}
	method onPressNum8() {}
	method onPressNum9() {}
	
}

object teclado_inicio inherits EstadoSelector {
	override method onPressI() {}
	override method onPressB() {}
	override method onPressV() {}
	override method onPressC() {}
	override method onPressD() {}
	override method onPressG() {}
	override method onPressEnter() { inicio.remover() }
	override method onPressNum1() {}
	override method onPressNum2() {}
	override method onPressNum3() {}
	override method onPressNum4() {}
	override method onPressNum5() {}
	override method onPressNum6() {}
	override method onPressNum7() {}
	override method onPressNum8() {}
	override method onPressNum9() {}
}

object teclado_combate inherits EstadoSelector {
	override method onPressI() {}
	override method onPressB() {}
	override method onPressV() {}
	override method onPressC() {}
	override method onPressD() {}
	override method onPressEnter() {}
	override method onPressNum1() {}
	override method onPressNum2() {}
	override method onPressNum3() {}
	override method onPressNum4() {}
	override method onPressNum5() {}
	override method onPressNum6() {}
	override method onPressNum7() {}
	override method onPressNum8() {}
	override method onPressNum9() {}
}

object teclado_final inherits EstadoSelector {
	override method onPressC() {}
	override method onPressI() {}
	override method onPressB() {}
	override method onPressV() {}
	override method onPressD() {}
	override method onPressG() {}
	override method onPressEnter() { game.stop() }
	override method onPressNum1() {}
	override method onPressNum2() {}
	override method onPressNum3() {}
	override method onPressNum4() {}
	override method onPressNum5() {}
	override method onPressNum6() {}
	override method onPressNum7() {}
	override method onPressNum8() {}
	override method onPressNum9() {}
}

// Comprar campeones de la tienda según posición
object teclado_tienda inherits EstadoSelector {
	override method onPressNum1() { tienda.comprar(0) }
	override method onPressNum2() { tienda.comprar(1) }
	override method onPressNum3() { tienda.comprar(2) }
	override method onPressNum4() { tienda.comprar(3) }
	override method onPressNum5() { tienda.comprar(4) }
}

// Mover campeones al inventario según posición en el banco
object teclado_banco inherits EstadoSelector {
	override method onPressNum1() { jugador.moverAlInventario(0) }
	override method onPressNum2() { jugador.moverAlInventario(1) }
	override method onPressNum3() { jugador.moverAlInventario(2) }
	override method onPressNum4() { jugador.moverAlInventario(3) }
	override method onPressNum5() { jugador.moverAlInventario(4) }
	override method onPressNum6() { jugador.moverAlInventario(5) }
	override method onPressNum7() { jugador.moverAlInventario(6) }
	override method onPressNum8() { jugador.moverAlInventario(7) }
	override method onPressNum9() { jugador.moverAlInventario(8) }
}

// Mover campeones al banco según posición en el inventario (arena)
object teclado_inventario inherits EstadoSelector {
	override method onPressNum1() { jugador.moverAlBancoDesdeInventario(0) }
	override method onPressNum2() { jugador.moverAlBancoDesdeInventario(1) }
	override method onPressNum3() { jugador.moverAlBancoDesdeInventario(2) }
	override method onPressNum4() { jugador.moverAlBancoDesdeInventario(3) }
	override method onPressNum5() { jugador.moverAlBancoDesdeInventario(4) }
	override method onPressNum6() { jugador.moverAlBancoDesdeInventario(5) }
	override method onPressNum7() { jugador.moverAlBancoDesdeInventario(6) }
	override method onPressNum8() { jugador.moverAlBancoDesdeInventario(7) }
}

// Vender campeones del banco según posición
object teclado_venta inherits EstadoSelector {
	override method onPressNum1() { jugador.venderCampeonDelBanco(0) }
	override method onPressNum2() { jugador.venderCampeonDelBanco(1) }
	override method onPressNum3() { jugador.venderCampeonDelBanco(2) }
	override method onPressNum4() { jugador.venderCampeonDelBanco(3) }
	override method onPressNum5() { jugador.venderCampeonDelBanco(4) }
	override method onPressNum6() { jugador.venderCampeonDelBanco(5) }
	override method onPressNum7() { jugador.venderCampeonDelBanco(6) }
	override method onPressNum8() { jugador.venderCampeonDelBanco(7) }
	override method onPressNum9() { jugador.venderCampeonDelBanco(8) }
}
