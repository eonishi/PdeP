data Participante = Participante {
    nombre :: String,
    trucos :: [Truco],
    especialidad :: Plato
}

data Plato = Plato {
    dificultad :: Int,
    componentes :: [Componente]
}

type Truco = Plato -> Plato 
type Componente = (Ingrediente, Int)
type Ingrediente = String

---------------------------

modificarComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
modificarComponentes unaFuncion plato = plato {componentes = unaFuncion.componentes $ plato} 

agregarComponente :: Ingrediente -> Int -> Plato
agregarComponente ingrediente gramos = modificarComponentes (\componentes -> (ingrediente,gramos):componentes) 

endulzar :: Int -> Truco
endulzar gramos = agregarComponente "Azucar" gramos

salar :: Int -> Truco
salar gramos = agregarComponente "Sal" gramos

darSabor :: Int -> Int -> Truco
darSabor gramosAzucar gramosSal = endulzar gramosAzucar . salar gramosSal

duplicarPorcion :: Truco
duplicarPorcion unPlato = modificarComponentes (map duplicarCantidad)

duplicarCantidad :: Componente -> Componente
duplicarCantidad (ingrediente, cantidad ) = (ingrediente, cantidad*2) 

simplificar :: Truco
simplificar unPlato
    | not (esUnBardo unPlato) = unPlato
    | esUnBardo unPlato = modificarDificultad 5 . quitarComponentesExtras 

esUnBardo :: Plato -> Bool
esUnBardo = tieneMasDe 5 . dificultadMayorA 7

tieneMasDe :: Int -> Plato -> Bool
tieneMasDe cantidadDeComponentes unPlato = cantidadDeComponentes < (length . componentes $ unPlato)

dificultadMayorA :: Int -> Plato -> Bool
dificultadMayorA unadificultad unPlato = unadificultad < dificultad unPlato