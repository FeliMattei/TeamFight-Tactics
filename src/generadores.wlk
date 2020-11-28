import wollok.game.*
import visuales.*

class AsheTienda {
	const property precio = 2
	
	var property position = null
	
	method image() = "imagenes/Tienda/ashe_tienda.png"
	
	method generarVisualTienda(x, y){
		const visual = new AsheTienda(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
	
	method generarVisual(x, y) {
		const visual = new AsheVisual(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
}

class BraumTienda {
	const property precio = 1
	
	var property position = null
	
	method image() = "imagenes/Tienda/braum_tienda.png"
	
	method generarVisualTienda(x, y){
		const visual = new BraumTienda(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
	
	method generarVisual(x, y) {
		const visual = new BraumVisual(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
}

class EnemigoTienda {
	const property precio = 1
	
	method generarVisual(x, y) {
		const visual = new EnemigoVisual(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
}

class VayneTienda {
	const property precio = 3
	var property position = null
	
	method image() = "imagenes/Tienda/vayne_tienda.png"
	
	method generarVisualTienda(x, y){
		const visual = new VayneTienda(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
	
	method generarVisual(x, y) {
		const visual = new VayneVisual(position = game.at(x,y))		
		game.addVisual(visual)
		
		return visual
	}
}

class ZedTienda {
	const property precio = 2
	
	var property position = null
	
	method image() = "imagenes/Tienda/zed_tienda.png"
	
	method generarVisualTienda(x, y){
		const visual = new ZedTienda(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
	
	method generarVisual(x, y) {
		const visual = new ZedVisual(position = game.at(x,y))	
		game.addVisual(visual)
		
		return visual
	}
}

class YoneTienda {
	const property precio = 3
	
	var property position = null
	
	method image() = "imagenes/Tienda/yone_tienda.png"
	
	method generarVisualTienda(x, y){
		const visual = new YoneTienda(position = game.at(x,y))
		game.addVisual(visual)
		
		return visual
	}
	
	method generarVisual(x, y) {
		const visual = new YoneVisual(position = game.at(x,y))	
		game.addVisual(visual)
		
		return visual
	}
}