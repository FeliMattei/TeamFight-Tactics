import generadores.*
import wollok.game.*
import jugador.*

object tienda {
	var property stock = []
	var property stockVisual = []
	
	method actualizar(){
		self.eliminarVisuales()
		stockVisual = []
		var x = 11
		const y = 1
		stock.forEach{ campeon => 
			stockVisual.add(campeon.generarVisualTienda(x, y))
			x += 1
		}
		self.verificarPrecios()
	}
	
	method eliminarVisuales(){
		stockVisual.forEach{ campeon => 
			game.removeVisual(campeon)
		}
	}
	
	method comprar(indice){
		if(stock.size() >= indice + 1){
			const campeonAComprar = stock.get(indice)
			if(!jugador.tieneElOro(campeonAComprar.precio())){
				game.say(jugador, "No tengo oro suficiente.")
			} else if (!jugador.tieneEspacioEnElBanco()) {
				game.say(jugador, "No tengo espacio en el banco.")
			} else {
				stock.remove(campeonAComprar)
				jugador.moverAlBanco(campeonAComprar)
				jugador.restarOro(campeonAComprar.precio())
				self.actualizar()
			}
		} else {
			game.say(jugador, "No hay nada para comprar.")
		}
	}
	
	method reiniciar(){
		stock.clear()
		5.times({ i => campeonesTiendaAleatorios.agregarEnTienda() })
		self.actualizar()
	}
	
	method verificarPrecios(){ slots.actualizarSlots(stockVisual) }
}

object campeonesTiendaAleatorios {
	const campeones = [new AsheTienda(), new BraumTienda(), new VayneTienda(), new ZedTienda()]
	
	method devolver(){
		const posicion = 0.randomUpTo(campeones.size()).roundUp() - 1
		return campeones.get(posicion)
	}
	
	method agregarEnTienda(){ tienda.stock().add(self.devolver()) }
}

object slots {
	var slots = []
	
	method actualizarSlots(lista){
		self.removerSlots()
		lista.forEach{ campeon => 
			if(jugador.tieneElOro(campeon.precio())){
				const slotVacio = new SlotVacio(position = game.at(campeon.position().x(), campeon.position().y()))
				game.addVisual(slotVacio)
				slots.add(slotVacio)
			} else {
				const slotBloq = new SlotBloqueado(position = game.at(campeon.position().x(), campeon.position().y()))
				game.addVisual(slotBloq)
				slots.add(slotBloq)
			}
		}
	}
	
	method removerSlots(){
		slots.forEach{ slot => 
			game.removeVisual(slot)
			slots.remove(slot)
		}
	}
}

class SlotVacio {
	var property position = null
	method image() = "imagenes/Tienda/vacio_tienda.png"
}

class SlotBloqueado {
	var property position = null
	method image() = "imagenes/Tienda/bloqueado_tienda.png"
}

