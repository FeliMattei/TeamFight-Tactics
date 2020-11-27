# TeamFight Tactics

![Portada](imagenes/git/portada.png)

## Desarrolladores
- Mattei Felipe ([Github](https://github.com/FeliMattei))
- Orlando Agustín ([Github](https://github.com/AgustinOrlando))
- Samudio Leandro Ivan ([Github](https://github.com/LeandroSamudio))
- Taveira Quercia Juan José ([Github](https://github.com/JuanchiTaveira))

Realizamos este proyecto como trabajo práctico integrador para la materia Paradigmas de Programación en la UTN.

## Introducción

TeamFight Tactics es un juego de estrategia individual por rondas, en el cual tendrás que comprar campeones y armar sinergias entre ellos para vencer al enemigo.  

## ¿Cómo jugar?

El juego se desarrolla en una arena donde se llevará a cabo el combate, encabezado por un jugador y un rival. Con el oro inicial deberás adquirir un [campeón](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#campeón) de la tienda para iniciar el primer round *(Podés guiarte con la configuración del [teclado](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#configuración-del-teclado))*.  
A medida que avancen las rondas subirás de nivel, lo que te permitirá colocar en la arena más campeones para la lucha. Además, sumarás oro al finalizar cada una de ellas.  
En el caso de perder, se le restará vida al jugador dependiendo de la cantidad de campeones enemigos y del round en el que se encuentren.  

La partida finalizará cuando muera alguno de los jugadores.

## Campeones

Son los encargados de combatir en la arena. Cada uno de ellos se mueve de manera independiente, según la [estrategia de búsqueda](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#estrategia-de-búsqueda) planificada.  
Cada campeón posee una [habilidad](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#habilidades) y un rol que, al acumular una determinada cantidad de campeones con dicho rol, se activará una [sinergia](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#sinergias) que modificará sus estadísticas.

### Ashe

![Ashe](imagenes/Campeones/ashe.png)   *"Todo el mundo en una flecha"*

#### Estadísticas:  
Precio: 2  
Vida: 500  
Armadura: 5  
Resistencia Mágica: 5  
Rango: 2  
Daño Mágico: 3  
Daño Básico: 70  
Velocidad de Ataque: 1450  
Criterio de Búsqueda: El más cercano  
Rol: Tirador  
Habilidad: [Flecha Encantada](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#flecha-encantada)

### Zed

![Zed](imagenes/Campeones/zed.png)   *"La espada invisible es la mas mortífera"*

#### Estadísticas:  
Precio: 2  
Vida: 500  
Armadura: 5  
Resistencia Mágica: 5  
Rango: 2  
Daño Mágico: 3  
Daño Básico: 70  
Velocidad de Ataque: 1450  
Rol: Tirador  
Habilidad: [Cuchillada Sombría](https://github.com/FeliMattei/TeamFight-Tactics/blob/master/README.md#cuchillada-sombría)

## Habilidades
### Flecha Encantada

### Cuchillada Sombría

## Criterio de búsqueda
### El más cercano
### El de menos vida

## Sinergias

## Configuración del teclado
