{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}
module Lib
  (
  )
where

import Text.Show.Functions ()

-- Alias utiles para la expresividad del código

type Habilidad = String

type Nombre = String

type Edad = Int

type Felicidad = Int

type Sueño = Persona -> Persona

type Carrera = String

type Ciudades = String

-- Definiciones de tipos de datos a utilizar
data Persona = Persona
  { nombre :: Nombre,
    edad :: Edad,
    felicidonios :: Felicidad,
    sueñosQueCumplir :: [Sueño],
    habilidades :: [Habilidad]
  }
  deriving (Show)

-- Modelado de una persona para las pruebas
carla :: Persona
carla =
  Persona
    { nombre = "Carla Madison",
      edad = 25,
      felicidonios = 100,
      sueñosQueCumplir = [],
      habilidades = ["Cantar", "Ver series", "Derivar cuadraticas"]
    }

-- Punto 1
-- a) Coeficiente de satisfacción
coeficienteDeSatisfaccion :: Persona -> Int
coeficienteDeSatisfaccion unaPersona
  | felicidonios unaPersona > 100 = felicidonios unaPersona * edad unaPersona
  | felicidonios unaPersona <= 100 && felicidonios unaPersona > 50 = felicidonios unaPersona * cantidadDeSueños unaPersona
  | otherwise = div (felicidonios unaPersona) 2

cantidadDeSueños :: Persona -> Int
cantidadDeSueños unaPersona = length (sueñosQueCumplir unaPersona)

-- b) Grado de ambición
gradoDeAmbicion :: Persona -> Int
gradoDeAmbicion unaPersona
  | felicidonios unaPersona > 100 = felicidonios unaPersona * cantidadDeSueños unaPersona
  | felicidonios unaPersona <= 100 && felicidonios unaPersona > 50 = edad unaPersona * cantidadDeSueños unaPersona
  | otherwise = cantidadDeSueños unaPersona * 2

-- Punto 2
-- a) Nombre largo
nombreLargo :: Persona -> Bool
nombreLargo unaPersona = (> 10) . length . nombre $ unaPersona

-- b) Persona suertuda
personaSuertuda :: Persona -> Bool
personaSuertuda unaPersona = even . (* 3) . coeficienteDeSatisfaccion $ unaPersona

-- c) Nombre lindo
nombreLindo :: Persona -> Bool
nombreLindo unaPersona = (== 'a') . last . nombre $ unaPersona

-- Punto 3 (Los posibles sueños)
-- a)
recibirseDeCarrera :: Carrera -> Sueño
recibirseDeCarrera unaCarrera unaPersona =
  unaPersona
    { felicidonios = felicidonios unaPersona + 1000,
      habilidades = unaCarrera : habilidades unaPersona
    }

-- b)
viajarACiudades :: [Ciudades] -> Sueño
viajarACiudades unasCiudades unaPersona =
  unaPersona
    { felicidonios = felicidonios unaPersona + ((* 100) . length $ unasCiudades),
      edad = edad unaPersona + 1
    }

-- c)
enamorarseDeOtraPersona :: Persona -> Sueño
enamorarseDeOtraPersona unaPersona personaEnamorada =
  personaEnamorada {felicidonios = felicidonios personaEnamorada + felicidonios unaPersona}

-- d)
todoSigaIgual :: Sueño
todoSigaIgual unaPersona = unaPersona

-- f)
comboPerfecto :: Sueño
comboPerfecto unaPersona = sumarFelicidad 100 . viajarACiudades ["Berazategui", "Paris"] . recibirseDeCarrera "Medicina" $ unaPersona

sumarFelicidad :: Int -> Persona -> Persona
sumarFelicidad unaCantidad unaPersona = unaPersona {felicidonios = felicidonios unaPersona + unaCantidad}