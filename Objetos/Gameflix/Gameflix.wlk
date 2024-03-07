import Juego.*

object gameflix {
	const juegos = [mario64,Silksong,hollowKnight,GoW,CSGO,CoD,pacman,tetris]
	const clientes=[]
	
	method juegos(){
		return juegos
	}
	
	method filtrar(categoria){
		return juegos.filter(juego=>juego.categoria() == categoria)
		
	}
	method buscar(nombre){
		return juegos.filter(juego=>juego.nombre()==nombre)
	}
	method recomendar(){
		return juegos.AnyOne()
	}
	method actualizar(cliente){
		
	}
	cobrarSuscripciones(){
		
	}
}
