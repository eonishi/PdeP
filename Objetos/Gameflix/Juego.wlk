class Juego {
	var nombre
	var precio
	var categoria
	
	method precio(){
		return precio
	}
	method categoria(){
		return categoria
	}
	method nombre(){
		return nombre
	}
}

const tetris = new Juego(nombre="Tetris",precio=20, categoria="arcade")
const pacman = new Juego(nombre="Pacman",precio=20, categoria="arcade")
const CoD = new Juego(nombre="Call of Duty",precio=50, categoria="FPS")
const CSGO = new Juego(nombre="Counter Strike",precio=5, categoria="FPS")
const GoW = new Juego(nombre="God of War",precio=70, categoria="H&S")
const hollowKnight = new Juego(nombre="Hollow Knight",precio=10, categoria="metroidvania")
const Silksong = new Juego(nombre="Silksong",precio=30, categoria="metroidvania")
const mario64 = new Juego(nombre="Mario 64",precio=40, categoria="plataforma")
