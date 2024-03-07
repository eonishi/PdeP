object amateur {
	method puedeSalirDe(unaSala, hizoMuchasSalas){
		return !unaSala.esDificil() and hizoMuchasSalas
			}
	
	method proximoNivel(){
		return profesional
	}
}

object profesional{
	method puedeSalirDe(unaSala, hizoMuchasSalas){
		return true
	}
	
	method proximoNivel(){
		return self
	}
}
