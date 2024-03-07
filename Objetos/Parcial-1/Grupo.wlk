import nolesalcanzaelsaldoexception.*
import Escapista.*

class Grupo {
	const escapistas = #{}
	
	method puedenSalirDe(unaSala){
		return escapistas.any({escapista=>escapista.puedeSalir(unaSala, escapista.hizoMuchasSalas())})
	}
	method escaparDe(unaSala){
		self.pagarSala(unaSala)
		self.actualizarRegistros(unaSala)
	}
	
	method pagarSala(unaSala){
		if(self.puedenPagar(unaSala)){
			self.dividirGastos(unaSala)
		}
		else{
			throw new NoLesAlcanzaElSaldoException(message="No tienen suficiente saldo")
		}
	}
	
	method puedenPagar(unaSala){
		return self.todosPuedenPagar(unaSala) or self.puedenPagarLosMillos(unaSala)
	}
	
	method todosPuedenPagar(unaSala){
		return escapistas.all({escapista => escapista.puedePagar(unaSala)})
	}
	
	method puedenPagarLosMillos(unaSala){
		return self.saldoDeLosMillosSegunLa(unaSala) > unaSala.precio()
	}
	
	method saldoDeLosMillosSegunLa(sala){
		return escapistas.filter({escapista => escapista.puedePagar(sala)}).sum({escapista => escapista.saldo()})
	}
	
	method dividirGastos(unaSala){
		escapistas.forEach({escapista => escapista.pagar(self.gastoDividido(unaSala))})
	}
	
	method gastoDividido(unaSala){
		return unaSala.precioDivididoEn(escapistas.size())
	}
	
	method actualizarRegistros(unaSala){
		escapistas.forEach({escapista => escapista.agregarNuevaSala(unaSala)})
	}
}
