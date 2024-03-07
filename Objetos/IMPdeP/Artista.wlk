class Artista {
	var experiencia
	var cantidadDePelisActuadas
	var ahorros
	
	method cantidadDePelisActuadas(){
		return cantidadDePelisActuadas
	}
	
	method sueldo(){
		return experiencia.remuneracion(self)
	}
	method nivelDeFama(){
		return cantidadDePelisActuadas/2
	}
	
	method esFamoso(){
		return self.nivelDeFama() > 15
	}
	
	method recategorizar(){
		if(experiencia.cumpleCondicionesDeXP(self)){
			experiencia = experiencia.siguienteNivel()
		}
	}
	
	method actuar(){
		cantidadDePelisActuadas++
		ahorros += self.sueldo()
	}
	
}
