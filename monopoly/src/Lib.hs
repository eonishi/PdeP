{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Lib
    ( 
    ) where

import Text.Show.Functions ()

type Nombre = String
type Dinero = Int
type Tactica = String

data Jugador = Jugador {
    nombre      :: Nombre,
    dinero      :: Dinero,
    tactica     :: Tactica,
    propiedades :: [Propiedad],
    acciones    :: [Accion]
}  deriving Show

data Propiedad = Propiedad {
    nombrePropiedad :: Nombre,
    precio          :: Dinero
} deriving Show

--data Accion = UnaAccion{ 
--    pagarAAccionista    :: Jugador -> Jugador,
--    enojarse            :: Jugador -> Jugador,
--    pasarPorElBanco     :: Jugador -> Jugador,
--    gritar              :: Jugador -> Jugador,
--    subastar            :: Jugador -> Jugador,
--    cobrarAlquileres    :: Jugador -> Jugador
--} ¿¿se puede hacer hacer Accion con un data constructors??

type Accion = Jugador -> Jugador 

-- Defino a los jugadores
carolina :: Jugador
carolina = Jugador {
    nombre = "Carolina",
    dinero = 500,
    tactica = "Accionista",
    propiedades = [],
    acciones = [ pagarAccionistas ]
}

manuel :: Jugador
manuel = Jugador{
    nombre = "Manuel",
    dinero = 500,
    tactica = "Oferente singular",
    propiedades = [],
    acciones = [enojarse]
}