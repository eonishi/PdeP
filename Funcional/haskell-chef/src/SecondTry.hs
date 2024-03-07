{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import GHC.Float (int2Double)
{-# HLINT ignore "Use infix" #-}
data Participante = Participante {
    nombre :: String,
    trucos :: [Truco],
    especialidad :: Plato
}

data Plato = Plato {
    dificultad :: Int,
    componentes :: [Componente]
}

tortillaDePapa :: Plato
tortillaDePapa = Plato{
    dificultad = 12,
    componentes = [("Papa", 2000),("Huevo", 150),("Cebolla", 100),("Sal", 20),("Oregano", 14),("Pimiento", 12)]
}

type Truco = Plato -> Plato 
type Componente = (Ingrediente, Int)
type Ingrediente = String

---------------------------

modificarComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
modificarComponentes unaFuncion plato = plato {componentes = unaFuncion.componentes $ plato} 

agregarComponente :: Ingrediente -> Int -> Plato -> Plato
agregarComponente ingrediente gramos = modificarComponentes (\componentes -> (ingrediente,gramos):componentes) 

endulzar :: Int -> Truco
endulzar = agregarComponente "Azucar" 

salar :: Int -> Truco
salar = agregarComponente "Sal" 

darSabor :: Int -> Int -> Truco
darSabor gramosAzucar gramosSal = endulzar gramosAzucar . salar gramosSal

duplicarPorcion :: Truco
duplicarPorcion = modificarComponentes (map duplicarCantidad)

duplicarCantidad :: Componente -> Componente
duplicarCantidad (ingrediente, cantidad ) = (ingrediente, cantidad*2) 

simplificar :: Truco
simplificar unPlato
    | esUnBardo unPlato = modificarDificultad 5 . quitarComponentesExtras $ unPlato
    | otherwise = unPlato

esUnBardo :: Plato -> Bool
esUnBardo unPlato = tieneMasDeNComponentes 5 unPlato && dificultadMayorA 7 unPlato

tieneMasDeNComponentes :: Int -> Plato -> Bool
tieneMasDeNComponentes n  = (> n) . length . componentes 

dificultadMayorA :: Int -> Plato -> Bool
dificultadMayorA unaDificultad  = (> unaDificultad) . dificultad 

modificarDificultad :: Int -> Plato -> Plato
modificarDificultad newDificultad unPlato = unPlato {dificultad = newDificultad}

quitarComponentesExtras :: Plato -> Plato
quitarComponentesExtras = modificarComponentes (filter masDe10Gramos) 

masDe10Gramos :: Componente -> Bool
masDe10Gramos (_, gramos) = gramos > 10


------------------------------------------------------------
ingredientesNoAptoVegano :: [Ingrediente]
ingredientesNoAptoVegano = ["Carne", "Huevo", "Leche", "Queso", "Yogur", "Manteca"]

esVegano :: Plato -> Bool
esVegano = not . any esProductoAnimal . componentes  

esProductoAnimal :: Componente -> Bool
esProductoAnimal (ingrediente, _ ) = elem ingrediente ingredientesNoAptoVegano

esSinTacc :: Plato -> Bool
esSinTacc = not . tiene "harina" 

tiene :: Ingrediente -> Plato -> Bool
tiene unIngrediente = elem unIngrediente . ingredientes

ingredientes :: Plato -> [Ingrediente]
ingredientes = map fst . componentes 

esComplejo :: Plato -> Bool
esComplejo = esUnBardo

noAptoHiperTension :: Plato -> Bool
noAptoHiperTension unPlato = tiene "Sal" unPlato && cantidadDe "Sal" unPlato < 2

cantidadDe :: Ingrediente -> Plato -> Int
cantidadDe unIngrediente = cantidad . conseguirIngrediente unIngrediente . componentes

cantidad :: Componente -> Int
cantidad (_ , cantidad) = cantidad

conseguirIngrediente :: Ingrediente -> [Componente] -> Ingrediente
conseguirIngrediente ingredienteDeseado  = head . filter (\(ingrediente,_) -> ingredienteDeseado == ingrediente) 