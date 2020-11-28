import campeones.*
import visuales.*

/*	Cada personaje tiene un target ataque que es al enemigo al que va a apuntar, por lo tanto esta función:
 *  		- Detectar si tenemos la maná para ejecutar la habilidad:
 * 				> Utiliza la habilidad y reinicia la maná a 0.
 * 				> Caso contrario ejecuto un ataque básico y sumo la maná en 1.
*/

/*	- Lista de hechizos
 * 			> Flecha Encantada: Realizará un ataque mágico en forma de flecha encantada, 
 * 								cuyo daño es igual a cuatro veces su daño básico.
 * 			> Ponerse Duro: Bloqueará el siguiente ataque del enemigo.
 * 			> Devolver Danio: El campeón recibirá la mitad del daño y devolverá al enemigo la otra mitad.
 *			> Proyectil de Plata: El campeón realizará un ataque de daño de verdadero igual al doble de su daño básico.
 * 			> Cuchillada Sombría: El campeón achuchillará al rival realizandole un daño básico y recuperará la mitad del daño en forma de vida.
 * 			> Destino Sellado: El campeón eliminará automáticamente a su enemigo sin importar su vida ni defensas.
 */

object ataqueBasico {
	method ejecutar(campeon, enemigo){
		const danioARealizar = campeon.danioBasico() - enemigo.armadura()
		enemigo.estrategiaDefensiva(danioARealizar, campeon)
	
		const animacion = new Animacion_Basico()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())	
	}
}

class FlechaEncantada {
	const property manaRequerida = 3
	
	method ofensiva(campeon, enemigo){
		const danioARealizar = (campeon.danioBasico() * 4) - enemigo.resistenciaMagica()
		enemigo.estrategiaDefensiva(danioARealizar, campeon)
		
		const animacion = new Animacion_FlechaEncantada()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())	
	}
}

class PonerseDuro {
	const property manaRequerida = 4
		
	method defensiva(danio, enemigo, campeon){
	
		const animacion = new Animacion_PonerseDuro()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())
		
		return 0
	}
}

class DevolverDanio {
	const property manaRequerida = 3
		
	method defensiva(danio, enemigo, campeon){
		const danioARecibir = danio / 2
		
		if(!enemigo.estaMuerto()){
			enemigo.perderVida(danioARecibir)
			const animacionAtaque = new Animacion_DevolverDanio_Ataque()
			animacionAtaque.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())
			const animacionDefensa = new Animacion_DevolverDanio_Defensa()
			animacionDefensa.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())
			return danioARecibir
		} else {
			return 0
		}
	}
}

class ProyectilDePlata {
	const property manaRequerida = 2
	
	method ofensiva(campeon, enemigo){	
		const danioARealizar = (campeon.danioBasico() * 2)
		enemigo.estrategiaDefensiva(danioARealizar, campeon)
		const animacion = new Animacion_ProyectilDePlata()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())	
	}
}

class CuchilladaSombria {
	
	method ofensiva(campeon, enemigo){
		const danio = campeon.danioBasico() - enemigo.armadura()
		const roboDeVida = (danio / 2)
		const nuevaVida = (campeon.vida() + roboDeVida).min(campeon.vidaInicial())
		campeon.vida(nuevaVida)
		campeon.visualAsociada().analizarVida()
		enemigo.estrategiaDefensiva(danio, campeon)
		const animacion = new Animacion_CuchilladaSombria()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())	
	}
}

class DestinoSellado {
	const property manaRequerida = 7
	
	method ofensiva(campeon, enemigo){
		const vidaEnemigo = enemigo.vida()
		const animacion = new Animacion_CuchilladaSombria()
		animacion.iniciar(enemigo.visualAsociada(), campeon.visualAsociada())	
		enemigo.perderVida(vidaEnemigo)
	}
}