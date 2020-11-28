import wollok.game.*
import combate.*
import visuales.*
import habilidades.*
import sinergias.*

class Campeon {	
	method vidaInicial()
	method vida()
	method vida(nuevaVida)
	method resistenciaMagica()
	method armadura()
	
	method mana()
	method mana(nuevaMana)
	method danioBasico()
	method danioMagico()

	method habilidad()
	
	method visualAsociada()
	method visualAsociada(nuevaVisual)
	
	method estaMuerto() = self.vida() <= 0
	
	method perderVida(danio){
		self.vida(self.vida() - danio.max(0))
		self.visualAsociada().analizarVida()
	}
		
	method estrategiaOfensiva(enemigo){
		const habilidad = self.habilidad()

		if(self.mana() == habilidad.manaRequerida()){
			habilidad.ofensiva(self, enemigo)
			self.mana(0)
		} else {
			ataqueBasico.ejecutar(self, enemigo)
			self.mana(self.mana() + 1)
		}
	}
		
	method estrategiaDefensiva(danio, enemigo){
		self.perderVida(danio)
	}
}

// Ashe
class Ashe inherits Campeon {
	var property vidaInicial = 500
	var property vida = vidaInicial
	var property resistenciaMagica = 5
	var property armadura = 5
	
	var property visualAsociada = null
	
	var property rol = tirador
	
	var property mana = 0
	var property danioBasico = 70
	var property danioMagico = 3

	var property habilidad = new FlechaEncantada()
}

// Braum
class Braum inherits Campeon {
	var property vidaInicial = 640
	var property vida = vidaInicial
	var property resistenciaMagica = 30
	var property armadura = 45
	
	var property visualAsociada = null
	
	var property rol = scout
	
	var property mana = 0
	var property danioBasico = 0
	var property danioMagico = 0
	
	var property habilidad = new DevolverDanio()
		
	override method estrategiaOfensiva(enemigo){
		ataqueBasico.ejecutar(self, enemigo)
	}
	
	override method estrategiaDefensiva(danio, enemigo){		
		if(self.mana() == habilidad.manaRequerida()){
			const nuevoDanio = habilidad.defensiva(danio, enemigo, self)
			self.perderVida(nuevoDanio)
			self.mana(0)
		} else {
			self.perderVida(danio)
			self.mana(self.mana() + 1)
		}
	}
}

// Enemigo
class Enemigo inherits Campeon {
	var property vidaInicial = 500
	var property vida = vidaInicial
	var property resistenciaMagica = 5
	var property armadura = 5
	
	var property visualAsociada = null
	
	var property rol = scout
	
	var property mana = 0
	var property danioBasico = 70
	var property danioMagico = 3

	var property habilidad = new FlechaEncantada()
}

// Vayne
class Vayne inherits Campeon {
	var property vidaInicial = 430
	var property vida = vidaInicial
	var property resistenciaMagica = 5
	var property armadura = 10
	
	var property visualAsociada = null
	
	var property rol = tirador
	
	var property mana = 0
	var property danioBasico = 70
	var property danioMagico = 3

	var property habilidad = new ProyectilDePlata()
}

// Zed
class Zed inherits Campeon {
	var property vidaInicial = 500
	var property vida = vidaInicial
	var property resistenciaMagica = 15
	var property armadura = 10
	
	var property visualAsociada = null
	
	var property rol = asesino

	var property mana = 0
	var property danioBasico = 55
	var property danioMagico = 3

	var property habilidad = new CuchilladaSombria()
	
	override method estrategiaOfensiva(enemigo){
		habilidad.ofensiva(self, enemigo)
	}
}

// Yone
class Yone inherits Campeon {
	var property vidaInicial = 580
	var property vida = vidaInicial
	var property resistenciaMagica = 10
	var property armadura = 20
	
	var property visualAsociada = null
	
	var property rol = asesino

	var property mana = 0
	var property danioBasico = 65
	var property danioMagico = 3

	var property habilidad = new DestinoSellado()
}