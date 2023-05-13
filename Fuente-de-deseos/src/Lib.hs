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
  | esMuyFeliz unaPersona = felicidonios unaPersona * edad unaPersona
  | esModeradamenteFeliz unaPersona = felicidonios unaPersona * cantidadDeSueños unaPersona
  | otherwise = div (felicidonios unaPersona) 2

-- b) Grado de ambición
gradoDeAmbicion :: Persona -> Int
gradoDeAmbicion unaPersona
  | esMuyFeliz unaPersona = felicidonios unaPersona * cantidadDeSueños unaPersona
  | esModeradamenteFeliz unaPersona = edad unaPersona * cantidadDeSueños unaPersona
  | otherwise = cantidadDeSueños unaPersona * 2

-- funciones auxiliar para evitar la repeticion de lógica
esMuyFeliz :: Persona -> Bool
esMuyFeliz unaPersona = felicidonios unaPersona > 100

esModeradamenteFeliz :: Persona -> Bool
esModeradamenteFeliz unaPersona = felicidonios unaPersona <= 100 && felicidonios unaPersona > 50

cantidadDeSueños :: Persona -> Int
cantidadDeSueños unaPersona = length (sueñosQueCumplir unaPersona)

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
recibirseDeCarrera unaCarrera unaPersona = sumarFelicidad 1000 . agregarHabilidades unaCarrera $ unaPersona

-- b)
viajarACiudades :: [Ciudades] -> Sueño
viajarACiudades unasCiudades unaPersona = sumarEdad 1 . sumarFelicidad ((* 100) . length $ unasCiudades) $ unaPersona

-- c)
enamorarseDeOtraPersona :: Persona -> Sueño
enamorarseDeOtraPersona unaPersona personaEnamorada = felicidonios unaPersona `sumarFelicidad` personaEnamorada

-- d)
todoSigaIgual :: Sueño
todoSigaIgual = id

-- f)
comboPerfecto :: Sueño
comboPerfecto unaPersona = sumarFelicidad 100 . viajarACiudades ["Berazategui", "Paris"] . recibirseDeCarrera "Medicina" $ unaPersona

sumarFelicidad :: Int -> Persona -> Persona
sumarFelicidad unaCantidad unaPersona = unaPersona {felicidonios = felicidonios unaPersona + unaCantidad}

sumarEdad :: Edad -> Persona -> Persona
sumarEdad unaEdad unaPersona = unaPersona { edad = unaEdad + edad  unaPersona }

agregarHabilidades :: Habilidad -> Persona -> Persona
agregarHabilidades unaHabilidad unaPersona = unaPersona { habilidades = unaHabilidad : habilidades unaPersona}