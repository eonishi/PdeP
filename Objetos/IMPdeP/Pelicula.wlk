class Pelicula{
	const nombre
	const elenco = []
	
	method presupuesto(){
		return self.sueldosTotales() + self.sueldosTotales()*0.70
	}
	
	method sueldosTotales(){
		return elenco.sum({actor => actor.sueldo()})
	}
	
	method ganacias(){
		return self.recaudacion() - self.presupuesto()	
	}
	
	method recaudacion(){
		return 1000000 + self.extraRecaudado()
	}
	method extraRecaudado()
	method rodarPelicula(){
		elenco.forEach({actor => actor.actuar()})
	}
	
	method esDeBajoPresupuesto(){
		return self.presupuesto() < 500000
	}
}

class PeliculaAccion inherits Pelicula {
	const vidriosRotos
	
	override method presupuesto(){
		return super() + self.costeDeVidrios()
	}
	
	method costeDeVidrios(){
		return vidriosRotos * 1000
	}
}

class PeliculaDrama inherits Pelicula{
	override method extraRecaudado(){
		return  nombre.size() * 100000
	}
}

class PeliculaTerror inherits Pelicula{
	const cantidadDeCuchos
	override method extraRecaudado(){
		return cantidadDeCuchos * 20000
	}
}
