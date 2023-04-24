module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- 1
esMultiploDeTres :: Int -> Bool
esMultiploDeTres x = mod x 3 == 0

--2
esMultiploDe :: Int -> Int -> Bool
esMultiploDe x y = mod x y == 0

--3
cubo :: Num a => a -> a -- ¿Por qué la extension me lo sugiere como Num y no como Int?
                        -- ¿Qué significa la flecha =>?
cubo x = x * x * x

--4
area :: Float -> Float -> Float
area x y = x * y

--5
esBisiesto :: Int -> Bool
esBisiesto año = esMultiploDe año 400 || esMultiploDe año 4 && not (esMultiploDe año 100)

--6
celsiusToFahrenheit :: Float -> Float
celsiusToFahrenheit temperatura = temperatura * 1.8 + 32

--7
fahrenheitToCelsius :: Float -> Float
fahrenheitToCelsius temperatura = (temperatura - 32) / 1.8

--8
haceFrio :: Float -> Bool
haceFrio temperatura = fahrenheitToCelsius temperatura < 8

--9
mcm :: Int -> Int -> Int
mcm x y = div (x * y) (gcd x y)

--10
---a
dispersion :: [Float] -> Float
dispersion mediciones = maximum mediciones - minimum mediciones

---b
diasParejos :: [Float] -> Bool
diasParejos mediciones = dispersion mediciones < 30

diasLocos :: [Float] -> Bool
diasLocos mediciones = dispersion mediciones > 100

diasNormales :: [Float] -> Bool 
diasNormales mediciones = not (diasParejos mediciones) && not (diasLocos mediciones)

--11
---a
pesoPino :: Float -> Float
pesoPino altura = if altura < 300   then 3*altura 
                                    else 3*300 + 2*(altura - 300)

---b
esPesoUtil :: Float -> Bool
esPesoUtil peso = peso > 400 && peso < 1000

---c
sirvePino :: Float -> Bool
sirvePino = esPesoUtil.pesoPino -- ¿Problemas en la composición de funciones?
                                -- sirvePino altura = (esPesoUtil.pesoPino) altura #mal

--12
---a
esCuadradoPerfecto :: Int -> Bool
esCuadradoPerfecto n = iteradorCuadradoPerfecto n 1
    where
        iteradorCuadradoPerfecto n i
            | i*i == n = True
            | i*i > n = False
            | otherwise = iteradorCuadradoPerfecto n (i+1)