module Lib
    (
    ) where

precioTotal :: Int -> Int -> Int -> Int -> Int
precioTotal precio cantidad descuento costoEnvio = aplicarCostoEnvio (aplicarDescuento precio descuento * cantidad) costoEnvio 
-- ¿costoEnvio es redundante?

aplicarDescuento :: Int -> Int -> Int
aplicarDescuento precio descuento = precio - div (precio * descuento) 100

aplicarCostoEnvio :: Int -> Int -> Int
aplicarCostoEnvio precio costoEnvio = precio + costoEnvio

entregaSencilla :: String -> Bool
entregaSencilla dia = even(length dia)

esProductoDeElite :: String -> Bool
esProductoDeElite producto = esProductoCodiciado producto && esProductoDeLujo producto && not (esProductoCorriente producto) 

esProductoCodiciado :: String -> Bool
esProductoCodiciado producto = length producto > 10

esProductoDeLujo :: String -> Bool
esProductoDeLujo producto = elem 'X' producto || elem 'Z' producto

esProductoCorriente :: String -> Bool
esProductoCorriente producto =  head producto == 'A' ||head producto == 'E' ||head producto == 'I' || head producto == 'O' ||head producto == 'U'

descodiciarProducto :: String -> String
descodiciarProducto = take 10 

productoXL :: String -> String
productoXL producto = producto ++ "XL"

versionBarata :: String -> String
versionBarata = reverse.descodiciarProducto