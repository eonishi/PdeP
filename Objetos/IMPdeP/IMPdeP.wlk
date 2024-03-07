object iMPdeP {
	const peliculas = []
	const artistas = []
	
	method artistaConMejorPaga(){
		return artistas.max({actor => actor.sueldo()})
	}
	
	method peliculasBajoPresupuesto(){
		return peliculas.filter({peli => peli.esDeBajoPresupuesto()})
	}
	
	method gananciasTotalesDeBajoPresupuesto(){
		return self.peliculasBajoPresupuesto().sum({peli => peli.presupuesto()})
	}
	
	method recategorizarActores(){
		artistas.forEach({actor => actor.recategorizar()})
	}
}
