{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use infix" #-}
module Lib
    () where

import Text.Show.Functions ()

type Nombre = String
type Truco = Plato -> Plato
type Peso = Int
type Dificultad = Int
type Gramos = Int
type Ingrediente = String
type Componente = (Ingrediente, Gramos)

data Participante = Participante {
    nombre :: Nombre,
    trucosDeCocina :: [Truco],
    especialidad :: Plato
} deriving (Show)

data Plato = Plato {
    dificultad :: Dificultad,
    componentes :: [Componente]
} deriving (Show, Eq)

-- Parte A 
mapComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
mapComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion . componentes $ unPlato}

agregarComponente :: Componente -> Plato -> Plato
agregarComponente unComponente unPlato = mapComponentes (unComponente :) unPlato

duplicarGramos :: Componente -> Componente
duplicarGramos (ingredientes, gramos) = (ingredientes, gramos * 2)

modificarDificultad :: Dificultad -> Plato -> Plato
modificarDificultad unaDificultad unPlato = unPlato {dificultad = unaDificultad}

hayMucho :: Componente -> Bool
hayMucho (_, gramos) = gramos > 10

-- 1
endulzar :: Gramos -> Truco
endulzar gramosAzucar unPlato = agregarComponente ("Azucar", gramosAzucar) unPlato

-- 2
salar :: Gramos -> Truco
salar cantidadSal unPlato = agregarComponente ("sal", cantidadSal) unPlato

-- 3
darSabor :: Gramos -> Gramos -> Truco
darSabor gramosSal gramosAzucar unPlato = endulzar gramosAzucar . salar gramosSal $ unPlato

-- 4
duplicarPorcion :: Truco
duplicarPorcion unPlato = mapComponentes (map duplicarGramos) unPlato

-- 5
simplificar :: Truco
simplificar unPlato 
    | esComplejo unPlato = mapComponentes hayMucho . modificarDificultad 5 $ unPlato
    | otherwise = unPlato

-- Información de platos
platoTiene :: Ingrediente -> Plato -> Bool
platoTiene unIgrediente unPlato = elem unIgrediente (ingredientes unPlato)

gramosDe :: Ingrediente -> Plato -> Gramos
gramosDe unIngrediente unPlato = gramos unIngrediente

-- 1
esVegano :: Plato -> Bool
esVegano unPlato = not (platoTiene carne unPlato) && not (platoTiene huevo unPlato) && not (platoTiene lacteo unPlato) 

-- 2
esSinTacc :: Plato -> Bool
esSinTacc unPlato = not (platoTiene harina unPlato)

-- 3
esComplejo :: Plato -> Bool
esComplejo unPlato = (length . componentes $ unPlato) > 5 && dificultad unPlato > 7

-- 4
noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = gramosDe sal unPlato > 2

-- Parte B
pepeRonccino :: Participante
pepeRonccino = Participante {
    nombre = "Pepe Ronccino",
    trucosDeCocina = [darSabor 2 5, simplificar, duplicarPorcion],
    especialidad = tortillaDePapa
}
tortillaDePapa :: Plato
tortillaDePapa = Plato {
    dificultad = 8,
    ingredientes = [sal{gramos = 1}, huevo, papa, cebolla, aceite, pimienta, oregano, ajo]
}

-- Parte C
-- 1
cocinar :: Plato -> Participante -> Plato
cocinar unPlato unParticipante = foldl (\plato truco -> truco plato) unPlato (trucosDeCocina unParticipante)

-- 2
esMejorQue :: Plato -> Plato -> Plato
esMejorQue unPlato otroPlato
    | (dificultad unPlato < dificultad otroPlato) = unPlato
    | otherwise = otroPlato

-- 3
--participanteEstrella :: [Participante] -> Participante


-- Parte D
{-
platinum :: Plato
platinum = Plato {
    nombrePlato = "Platinum",
    dificultad = 10,
    ingredientes = [carne ..]
-}