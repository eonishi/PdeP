{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Lib
    ( 
    ) where
import Text.Show.Functions ()

type Color = String
type Velocidad = Int
type Distancia = Int
type Carrera = [Auto]
type Puesto = Int
type Tiempo = Int

data Auto = Auto
    {
        color :: Color,
        velocidad :: Velocidad,
        distancia :: Distancia
    } deriving (Eq, Show)

-- 1 
--a 
estaCercaDe :: Auto -> Auto -> Bool
estaCercaDe unAuto otroAuto = (unAuto /= otroAuto) && distanciaEntreAutosEs (<10) otroAuto unAuto

distanciaEntreAutosEs :: (Int -> Bool) -> Auto -> Auto -> Bool
distanciaEntreAutosEs condicion unAuto otroAuto = condicion (distanciaEntreAutos unAuto otroAuto)

distanciaEntreAutos :: Auto -> Auto -> Distancia
distanciaEntreAutos unAuto otroAuto = abs (distancia unAuto - distancia otroAuto)

--b 
vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo unAuto laCarrera = ningunoCerca unAuto laCarrera  && ganandoATodos unAuto laCarrera

ningunoCerca :: Auto -> Carrera -> Bool
ningunoCerca unAuto carrera = any (estaCercaDe unAuto) carrera

ganandoATodos :: Auto -> Carrera -> Bool
ganandoATodos unAuto laCarrera = all (ganaAutoDeOtro unAuto) laCarrera

ganaAutoDeOtro :: Auto -> Auto -> Bool
ganaAutoDeOtro unAuto otroAuto = distancia unAuto > distancia otroAuto

--c
puestoDe :: Auto -> Carrera -> Puesto
puestoDe unAuto laCarrera = (1+) . cantidadDeAutosAdelante laCarrera $ unAuto

cantidadDeAutosAdelante :: [Auto] -> Auto -> Int
cantidadDeAutosAdelante laCarrera unAuto =  length . filter (ganaAutoDeOtro unAuto) $ laCarrera


--2 
--a
correr :: Tiempo -> Auto -> Auto
correr unTiempo unAuto = unAuto{ distancia = unTiempo*velocidad unAuto + distancia unAuto }

--b 
--I
alterarVelocidad :: (Velocidad -> Velocidad) -> Auto -> Auto
alterarVelocidad modificador unAuto = unAuto{ velocidad = modificador . velocidad $ unAuto}

--II
bajarVelocidad :: Velocidad -> Auto -> Auto
bajarVelocidad laVelocidad unAuto
    | velocidad unAuto < laVelocidad  = alterarVelocidad (flip (-) (velocidad unAuto)) unAuto
    | otherwise                       = alterarVelocidad (flip (-) laVelocidad) unAuto


--3 
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

--a
type PowerUp =  Auto -> Carrera -> Carrera

terremotos :: PowerUp
terremotos unAuto carrera = afectarALosQueCumplen (estaCercaDe unAuto) (alterarVelocidad (50-)) carrera

--b
miguelitos :: Velocidad -> PowerUp
miguelitos  unaVelocidad unAuto carrera = afectarALosQueCumplen (not . estaCercaDe unAuto) (alterarVelocidad (unaVelocidad-)) carrera

--c 
jetPack :: Tiempo -> PowerUp
jetPack unTiempo unAuto carrera = (:carrera) . alterarVelocidad (`div` 2) . correr unTiempo . alterarVelocidad (*2) $  find (== unAuto) carrera

find :: (a -> Bool) -> [a] -> a
find condicion lista = head . filter condicion $ lista
