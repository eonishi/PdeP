class SalaDeEscape {
	const nombre
	const dificultad
	
	method dificultad(){
		return dificultad
	}
	
	method nombre(){
		return nombre
	}
	
	method precio(){
		return 10000 + self.adicional()
	}
	method esDificil(){
		return dificultad > 7
	}
	
	method precioDivididoEn(unaCantidad){
		return self.precio()/unaCantidad
	}
	
	method adicional()
}


class SalaDeAnime inherits SalaDeEscape {
	override method adicional(){
		return 7000
	}
}

class SalaDeHistoria inherits SalaDeEscape {
	const basadaEnHechosReales
	
	override method adicional(){
		return dificultad*0.314
	}
	
	override method esDificil(){
		return super() and !basadaEnHechosReales
	}
}


class SalaDeTerror inherits SalaDeEscape {
	var cantidadDeSustos 
	
	override method adicional(){
		if(self.sustosMayorA(5)){
			return cantidadDeSustos*0.20
		}
		else {
			return 0
		}
	}
	
	override method esDificil() {
		return super() or self.sustosMayorA(5)
	}
	
	method sustosMayorA(unNumero){
		return cantidadDeSustos > unNumero
	}
}