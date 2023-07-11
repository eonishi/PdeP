
{-# HLINT ignore "Redundant lambda" #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}

import Text.Show.Functions ()
import Control.Applicative (Alternative(empty))


-- Deficinion del tipo de dato "Persona"
data Persona = UnaPersona
  { edad :: Edad,
    nombre :: Nombre,
    felicidonios :: Felicidad,
    habilidades :: [Habilidad],
    sueniosQueCumplir :: [Suenio]
}deriving (Show)

-- Alias utiles para mejorar la expresividad del codigo
type Suenio = Persona -> Persona
type Nombre = String
type Edad = Int
type Felicidad = Int
type Habilidad = String
type Ciudad = String
type Carrera = String
type Fuente = Persona -> Persona
type Criterio = Fuente -> Fuente  -> Persona -> Bool

martina :: Persona
martina = UnaPersona{
  edad = 23,
  nombre = "Martina",
  felicidonios = 500,
  habilidades = [],
  sueniosQueCumplir = [comboPerfecto, recibirseDe "medicina", enamorarseDe mateo, viajarA ["Barcelona"]]
}

mateo :: Persona
mateo = UnaPersona{
  edad = 22,
  nombre = "Mateo",
  felicidonios = 0,
  habilidades = [],
  sueniosQueCumplir = []
}

agustin :: Persona
agustin = UnaPersona{
   edad = 25,
   nombre = "Agustin",
   felicidonios = 100,
   habilidades = [],
   sueniosQueCumplir = [queSigaTodoIgual]
   }

eugenia :: Persona
eugenia = UnaPersona{
   edad = 22,
   nombre = "Eugenia",
   felicidonios = 5000,
   habilidades = [],
   sueniosQueCumplir = [recibirseDe "diseñoDeInteriores", viajarA ["Paris"], enamorarseDe manuel]
   }

manuel :: Persona
manuel = UnaPersona{
    edad = 25,
    nombre = "Manuel",
    felicidonios = 15,
    habilidades = [],
    sueniosQueCumplir = [enamorarseDe eugenia]
}

-- PUNTO 1
-- Funciones que se usan para punto a y b
cantidadDeSuenios :: Persona -> Int
cantidadDeSuenios unaPersona = length . sueniosQueCumplir $ unaPersona

esMuyFeliz :: Persona -> Bool
esMuyFeliz unaPersona = felicidonios unaPersona > 100

esPocoFeliz ::  Persona -> Bool
esPocoFeliz unaPersona = felicidonios unaPersona <= 50

esModeradamenteFeliz ::Persona -> Bool
esModeradamenteFeliz unaPersona = felicidonios unaPersona > 50 && felicidonios unaPersona <= 100

operaSegunLaFelicidad :: Persona  ->    (Persona->Int)   ->   (Int->Int->Int) ->      (Int->Int->Int)             ->(Int->Int->Int)     ->(Persona->Int)        ->(Persona->Int)   ->Int          ->Int
operaSegunLaFelicidad   unaPersona dataEnComun operacionMuyFeliz operacionModeradamenteFeliz operacionPocoFeliz dataMuyFeliz dataModeradamenteFeliz dataPocoFeliz --Salida
  | esMuyFeliz unaPersona = operacionMuyFeliz (dataEnComun unaPersona) (dataMuyFeliz unaPersona)
  | esModeradamenteFeliz unaPersona = operacionModeradamenteFeliz (dataEnComun unaPersona)  (dataModeradamenteFeliz unaPersona)
  | esPocoFeliz unaPersona = operacionPocoFeliz (dataEnComun unaPersona)  dataPocoFeliz

-- Parte A
coeficienteDeSatisfaccion ::Persona ->Int
coeficienteDeSatisfaccion unaPersona = operaSegunLaFelicidad unaPersona felicidonios (*) (*) div edad cantidadDeSuenios 2


-- Parte B
gradoDeAmbicion' :: Persona -> Int
gradoDeAmbicion' unaPersona = operaSegunLaFelicidad unaPersona cantidadDeSuenios (*) (*) (*) felicidonios edad 2


-- PUNTO 2

-- Parte A
tieneNombreLargo :: Persona -> Bool
tieneNombreLargo unaPersona = (> 10) . length . nombre $ unaPersona

-- Parte B
esPersonaSuertuda :: Persona -> Bool
esPersonaSuertuda unaPersona = even . (* 3) . coeficienteDeSatisfaccion $ unaPersona

-- Parte C
tieneNombreLindo :: Persona -> Bool
tieneNombreLindo unaPersona = (== 'a') . last . nombre $ unaPersona

-- PUNTO 3

recibirseDe :: Carrera -> Suenio
recibirseDe unaCarrera unaPersona = sumarFelicidad ((*1000) . length $ unaCarrera) . agregarHabilidad unaCarrera $ unaPersona

viajarA :: [Ciudad] -> Suenio
viajarA ciudades unaPersona = sumarEdad 1 . sumarFelicidad ( (*100) .length $ ciudades) $ unaPersona

enamorarseDe :: Persona -> Suenio
enamorarseDe otraPersona unaPersona = sumarFelicidad (felicidonios otraPersona)  unaPersona

queSigaTodoIgual :: Suenio
queSigaTodoIgual = id

comboPerfecto :: Suenio
comboPerfecto unaPersona = sumarFelicidad 100 . viajarA ["Berazategui", "Paris"] . recibirseDe "Medicina" $ unaPersona

sumarFelicidad :: Felicidad -> Persona -> Persona
sumarFelicidad unaCantidadFelicidad unaPersona = unaPersona {felicidonios = felicidonios unaPersona + unaCantidadFelicidad}

sumarEdad :: Edad -> Persona -> Persona
sumarEdad unaEdad unaPersona = unaPersona{ edad = unaEdad + edad unaPersona}

agregarHabilidad :: Habilidad -> Persona -> Persona
agregarHabilidad unaHabilidad unaPersona = unaPersona {habilidades = unaHabilidad : habilidades unaPersona}

--Punto 4

quitarPrimerSuenio :: Persona -> Persona
quitarPrimerSuenio unaPersona = unaPersona {sueniosQueCumplir = tail . sueniosQueCumplir  $ unaPersona}

cumplirPrimerSuenio :: Persona -> Persona
cumplirPrimerSuenio unaPersona = (head . sueniosQueCumplir $ unaPersona) unaPersona

--Punto A
fuenteMinimalista :: Fuente
fuenteMinimalista = quitarPrimerSuenio . cumplirPrimerSuenio

--Punto B
cumplioTodosSusSuenios:: Persona -> Bool
cumplioTodosSusSuenios = null . sueniosQueCumplir
{-
fuenteCopada :: Fuente
fuenteCopada unaPersona
  | cumplioTodosSusSuenios unaPersona = unaPersona
  | otherwise = fuenteCopada . cumplirPrimerSuenio $ unaPersona
-}
fuenteCopada :: Fuente
fuenteCopada = dejarSinSuenios . cumplirTodosSusSuenios

cumplirTodosSusSuenios:: Persona->Persona
cumplirTodosSusSuenios unaPersona = foldr ($) unaPersona (sueniosQueCumplir unaPersona)
--cumplirTodosSusSuenios unaPersona = foldr (.) id (sueniosQueCumplir unaPersona) $ unaPersona

dejarSinSuenios :: Persona->Persona
dejarSinSuenios unaPersona = unaPersona{ sueniosQueCumplir = []}


--Punto C
fuenteAPedido :: Int -> Fuente
fuenteAPedido numero unaPersona = (sueniosQueCumplir unaPersona !! numero) unaPersona

--Punto D
fuenteSorda :: Fuente
fuenteSorda = id


--Punto 5
lasFuentes :: [Fuente]
lasFuentes = [fuenteMinimalista, fuenteCopada, fuenteAPedido 0, fuenteSorda]

unTipoDeCriterio :: Fuente -> Fuente -> Persona -> (Persona -> a) -> (a -> a -> Bool) -> Bool
unTipoDeCriterio fuente otraFuente persona accessor presedencia = presedencia (accessor . fuente $ persona) (accessor . otraFuente $ persona)

masFelicidad :: Criterio
masFelicidad fuente otraFuente persona = unTipoDeCriterio fuente otraFuente persona felicidonios (>)

menosFelicidad :: Criterio
menosFelicidad fuente otraFuente persona = unTipoDeCriterio fuente otraFuente persona felicidonios (<)

masHabilidad :: Criterio
masHabilidad fuente otraFuente persona = unTipoDeCriterio fuente otraFuente persona (length.habilidades) (>)

fuenteGanadora :: [Fuente] -> Persona -> Criterio -> Fuente
fuenteGanadora unasFuentes unaPersona unCriterio = foldl1 (laMejorFuenteDe unCriterio unaPersona) unasFuentes

laMejorFuenteDe :: Criterio -> Persona -> Fuente -> Fuente -> Fuente
laMejorFuenteDe criterio persona fuente otraFuente
  | criterio fuente otraFuente persona = fuente
  | otherwise = otraFuente

--Punto 6
condicionDeFelicidad :: Persona -> (Int -> Bool) -> Suenio  -> Bool
condicionDeFelicidad unaPersona condicion unSueño   = condicion . felicidonios . unSueño $ unaPersona

sueniosValioso :: Persona -> [Suenio]
sueniosValioso = unTipoDeSuenio (>100)

suenioRaro :: Persona -> Bool
suenioRaro unaPersona = any (noCambiaFelicidonios unaPersona) . sueniosQueCumplir $ unaPersona

noCambiaFelicidonios ::  Persona -> Suenio ->Bool
noCambiaFelicidonios unaPersona unSuenio  = felicidonios unaPersona == (felicidonios . unSuenio $ unaPersona)

unTipoDeSuenio ::  (Int -> Bool) -> Persona ->[Suenio]
unTipoDeSuenio unaCondicion unaPersona = filter (condicionDeFelicidad unaPersona unaCondicion) (sueniosQueCumplir unaPersona)

felicidadGrupal :: [Persona] -> Felicidad
felicidadGrupal  = sum . map (felicidonios . fuenteCopada)

-- Punto 7

matias :: Persona
matias = UnaPersona
  { edad = 30,
    nombre = "Matias",
    felicidonios = 100,
    habilidades = [],
    sueniosQueCumplir = cycle [viajarA ["Paris"],viajarA ["Madrid", "Paris", "Chivilcoy"]]
}



{- Justificación

Dada una lista de suenios infinitos, nuestro diseño de cada fuente funciona
de la siguiente manera con cada una de las fuentes:

-fuenteMinimalista: Funcionaría porque solo es una combinacion de las funciones
head y tail, que ambas funcionan con lazy evaluation, entonces aplicando la funcion 
antes de evaluar la lista, la fuente minimalista es capaz de devolver resultados 
sin detenerse a evaluar infinitamente las listad de suenios (solo cumple el primero)

-fuenteCopada: Funcionaría pero no sería capaz de devolver resultados, ya que la funcion quedaria evaluando el siguiente sueño de la lista
y debido a la infinidad de la misma nunca podrá terminar.

-fuenteAPedido: Funciona, porque evalua el suenio que recibe y lo ejecuta, de manera que vemos los valores plasmados en la terminal, porque usa lazy evaluation.

-fuenteSorda: Como sólo se trata de la funcion "id" que trabaja con lazy evaluation,
ya sabe que tiene que devolver exactamente toda la lista antes de evaluarla, entonces
directamente, devuelve la misma lista, funciona

-}