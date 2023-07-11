{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}

module Lib
    ( 
    ) where

-- APLICACION PARCIAL
-- 1) Funcion siguiente
siguiente :: Num a => a -> a 
siguiente = (+1)

-- 2) Funcion mitad
mitad :: Float -> Float
mitad = (/2)

-- 3) Funcion inversa
inversa :: Float -> Float
inversa = (1/)

-- 4) Funcion triple
triple :: Num a => a -> a
triple = (*3)

--5) Funcion esNumeroPositivo
esNumeroPositivo :: (Ord a, Num a) => a -> Bool
esNumeroPositivo = (>0)

-- COMPOSICION
-- 6) Es multiplo de 2 
esMultiploDe2 :: Int -> Bool
esMultiploDe2 = (==0) . (`mod` 2)

-- 7) Es un numero bisiesto 
esBisiesto :: Int -> Bool
esBisiesto  año = ((==0) . (`mod` 400)) año || ((==0).(`mod` 4)) año && ((/=0).(`mod` 100)) año -- Poco declarativo y expresivo(?)

--8) Inversa de la raiz cuadrada
inversaRaizCuadrada :: Float -> Float
inversaRaizCuadrada = inversa . sqrt

-- 9) Incremento M al cuadrado de N
incrementMCuadradoN :: Num a => a -> a -> a 
incrementMCuadradoN numeroM numeroN = (+numeroN) . (^2) $ numeroM
