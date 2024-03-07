object amateur{
	method remuneracion(unActor){
		return 10000
	}
	
	method siguienteNivel(){
		return establecido
	}
}
object establecido{
	method remuneracion(unActor){
		if(unActor.esFamoso())
			return 15000
		else
			return 5000 * unActor.nivelDeFama()
	}
	
	method siguienteNivel(){
		return estrella
	}
	
}
object estrella{
	method remuneracion(unActor){
		return 30000 * unActor.cantidadDePelisActuadas()
	}
}