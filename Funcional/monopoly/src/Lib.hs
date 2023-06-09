{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}
module Lib
  (
  )
where

import Text.Show.Functions ()

type Nombre = String

type Dinero = Int

type Tactica = String

data Jugador = Jugador
  { nombre :: Nombre,
    dinero :: Dinero,
    tactica :: Tactica,
    propiedades :: [Propiedad],
    acciones :: [Accion]
  }
  deriving (Show)

data Propiedad = Propiedad
  { nombrePropiedad :: Nombre,
    precio :: Dinero
  }
  deriving (Show)

-- data Accion = UnaAccion{
--    pagarAAccionista    :: Jugador -> Jugador,
--    enojarse            :: Jugador -> Jugador,
--    pasarPorElBanco     :: Jugador -> Jugador,
--    gritar              :: Jugador -> Jugador,
--    subastar            :: Jugador -> Jugador,
--    cobrarAlquileres    :: Jugador -> Jugador
-- } ¿¿se puede hacer hacer Accion con un data constructors?? no tiene sentido porque no es un tipo de dato

type Accion = Jugador -> Jugador

-- Defino a los jugadores
carolina :: Jugador
carolina =
  Jugador
    { nombre = "Carolina",
      dinero = 500,
      tactica = "Accionista",
      propiedades = [],
      acciones = [pagarAccionistas]
    }

manuel :: Jugador
manuel =
  Jugador
    { nombre = "Manuel",
      dinero = 500,
      tactica = "Oferente singular",
      propiedades = [],
      acciones = [enojarse]
    }

-- Defino las propiedades
casaDePaja :: Propiedad
casaDePaja = Propiedad {nombrePropiedad = "Casa de paja", precio = 100}

casaDeMadera :: Propiedad
casaDeMadera = Propiedad {nombrePropiedad = "Casa de madera", precio = 200}

casaDeLadrillo :: Propiedad
casaDeLadrillo = Propiedad {nombrePropiedad = "Casa de ladrillo", precio = 130}

casaDeDulces :: Propiedad
casaDeDulces = Propiedad {nombrePropiedad = "Casa de dulces", precio = 400}

casaDePapel :: Propiedad
casaDePapel = Propiedad {nombrePropiedad = "Casa de papel", precio = 500} -- Casa de papel??? (no la vi)

-- Declaracion de las ACCIONES
pasarPorElBanco :: Accion
pasarPorElBanco unJugador = cambiarTacticaACompradorCompulsivo . sumarDinero 40 $ unJugador

sumarDinero :: Int -> Jugador -> Jugador
sumarDinero cantidad unJugador = unJugador {dinero = dinero unJugador + cantidad}

cambiarTacticaACompradorCompulsivo :: Jugador -> Jugador
cambiarTacticaACompradorCompulsivo unJugador = unJugador {tactica = "Comprador compulsivo"}

pagarAccionistas :: Accion
pagarAccionistas unJugador
  | tactica unJugador == "Accionista" = sumarDinero 200 unJugador
  | otherwise = restarDinero 100 unJugador

restarDinero :: Int -> Jugador -> Jugador
restarDinero cantidad unJugador = unJugador {dinero = dinero unJugador - cantidad}

enojarse :: Accion
enojarse unJugador = agregarAccion gritar . sumarDinero 50 $ unJugador

agregarAccion :: Accion -> Jugador -> Jugador
agregarAccion unaAccion unJugador = unJugador {acciones = unaAccion : acciones unJugador}

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHH" ++ nombre unJugador}

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador
  | tactica unJugador == "Oferente singular" || tactica unJugador == "Accionista" = pagarPropiedad unaPropiedad unJugador
  | otherwise = unJugador

pagarPropiedad :: Propiedad -> Jugador -> Jugador
pagarPropiedad unaPropiedad unJugador =
  unJugador
    { propiedades = unaPropiedad : propiedades unJugador,
      dinero = dinero unJugador - precio unaPropiedad
    }

cobrarAlquileres :: Accion
cobrarAlquileres unJugador = totalAlquiler unJugador `sumarDinero` unJugador

totalAlquiler :: Jugador -> Dinero
totalAlquiler unJugador = sum . listaAlquiler $ unJugador

listaAlquiler :: Jugador -> [Dinero]
listaAlquiler unJugador = map valorDelAlquiler (propiedades unJugador)

valorDelAlquiler :: Propiedad -> Dinero
valorDelAlquiler unaPropiedad
  | precio unaPropiedad < 150 = 10
  | otherwise = 20