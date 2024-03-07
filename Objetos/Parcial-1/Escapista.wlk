import Maestria.*

class Escapista {
	var maestria
	const salasEscapadas = []
	var saldo = 0
	
	method maestria(unaMaestria){
		maestria = unaMaestria
	}
	
	method saldo(){
		return saldo
	}
	
	method puedeSalir(unaSala, hizoMuchasSalas){
		return maestria.puedeSalirDe(unaSala, hizoMuchasSalas)
	}
	
	method subirDeLvl(){
		if(self.hizoMuchasSalas()){
			self.maestria(maestria.proximoNivel())
		}
	}
	
	method hizoMuchasSalas(){
		return salasEscapadas.size() >= 6
	}
	
	method salasEscapadas(){
		return salasEscapadas.map({sala => sala.nombre()}).asSet()
	}
	method agregarNuevaSala(unaSala){
		salasEscapadas.add(unaSala)
	}
	method pagar(unaCantidad){
		saldo -= unaCantidad
	}
	
	method puedePagar(unaSala){
		return saldo > unaSala.precio()
	}
}
