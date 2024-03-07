import Gameflix.*

class Suscripcion {
	
	var precio
	
	method juegoPermitido(juego){
		return true
	}
	
}

object premium inherits Suscripcion (precio = 50){
	override method juegoPermitido(juego) {
		return gameflix.juegos().contains(juego)
	}
}

object base inherits Suscripcion (precio = 25){
	override method juegoPermitido(juego) {
		return juego.precio() < 30
	}
}

object infantil inherits Suscripcion (precio = 10){
	override method juegoPermitido(juego){
		return juego.categoria() == "infantil"
	}
}

object prueba inherits Suscripcion (precio = 0){
	override method juegoPermitido(juego){
		return juego.categoria() == "demo"
	}
}
