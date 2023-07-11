{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
module Lib
    (
    ) where

-- Definicion de tipos y alias utiles
type Nombre = String
type Autor = String
type Paginas = Int
type Biblioteca = [Libro]
type Saga = [Libro]

-- Declaracion del tipo de dato Libro
-- Funciones Accessors (estan implicitos en la declaracon del tipo de dato Libro -record syntax-)
data Libro = Libro {
    nombre :: Nombre,
    autor :: Autor,
    paginas :: Paginas 
} deriving (Eq, Show)

-- Declaracion de los libros
elVisitante :: Libro
elVisitante = Libro "El visitante" "Stephen King" 592

snk1 :: Libro
snk1 = Libro "SNK-1" "Hajime Isayama" 40

snk3 :: Libro
snk3 = Libro "SNK-3" "Hajime Isayama" 40

snk127 :: Libro
snk127 = Libro "SNK-127" "Hajime Isayama" 40

fundacion :: Libro
fundacion = Libro "Fundacion" "Isaac Asimov" 230

sandman5 :: Libro
sandman5 =  Libro"Sandman-5" "Neil Gaiman" 35

sandman10 :: Libro
sandman10 = Libro "Sandman-10" "Neil Gaiman" 35

sandman12 :: Libro
sandman12 = Libro "Sandman-12" "Neil Gaiman" 35

eragon :: Libro
eragon = Libro "Eragon" "Christopher Paolini" 544

eldest :: Libro
eldest = Libro "Eldest" "Christopher Paolini" 704

brisignr :: Libro
brisignr = Libro "Brisignr""Christopher Paolini" 700

legado :: Libro
legado = Libro "Legado""Christopher Paolini" 811


-- Mi biblioteca
biblioteca :: Biblioteca
biblioteca = [elVisitante, snk1, snk3, snk127, fundacion, sandman5, sandman10, sandman12, eragon, eldest, brisignr, legado]

-- Promedio de las hojas de mi biblioteca
promedioDeHojas :: Biblioteca -> Paginas
promedioDeHojas biblioteca = div (cantidadDeHojas biblioteca) (length biblioteca)

cantidadDeHojas :: Biblioteca -> Paginas
cantidadDeHojas biblioteca = (sum.listaDePaginas) biblioteca

listaDePaginas :: Biblioteca -> [Paginas]
listaDePaginas biblioteca  = map paginas biblioteca

-- Lectura Obligatoria
lecturaObligatoria :: Libro -> Bool
lecturaObligatoria (Libro _ "Stephen King" _) = True
lecturaObligatoria (Libro "Fundacion" "Isaac Asimov" 230) = True
lecturaObligatoria unLibro = perteneceSagaEragon unLibro

sagaEragon :: Saga
sagaEragon = [eragon, eldest, brisignr, legado]

perteneceSagaEragon :: Libro -> Bool
perteneceSagaEragon libro = elem libro sagaEragon


-- Biblioteca fantasiosa
esBibliotecaFantasiosa :: Biblioteca -> Bool
esBibliotecaFantasiosa biblioteca = any esLibroFantasioso biblioteca

esLibroFantasioso :: Libro -> Bool
esLibroFantasioso (Libro _ "Christopher Paolini" _) = True 
esLibroFantasioso (Libro _ "Neil Gaiman" _ ) = True
esLibroFantasioso (Libro {}) = False


-- Nombre de la biblioteca
nombreDeLaBiblioteca :: Biblioteca -> Nombre
nombreDeLaBiblioteca nombre = (sacarVocales.unirNombres) nombre 

sacarVocales :: Nombre -> Nombre
sacarVocales nombre = filter (`notElem` "aAeEiIoOuU -áÁéÉíÍóÓúÚ") nombre

unirNombres :: Biblioteca -> Nombre
unirNombres biblioteca =  concatMap nombre biblioteca

-- Biblioteca Ligera
bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera biblioteca = all lecturaLigera biblioteca

lecturaLigera :: Libro -> Bool
lecturaLigera libro = paginas libro < 40

-- Funcion que devuelve el genero del libro
genero :: Libro -> String
genero unLibro 
    | autor unLibro == "Stephen King" = "Terror"
    | esAutorJapones unLibro = "Manga"
    | lecturaLigera unLibro = "Comic"
    | otherwise = "No clasificado"

autoresJaponeses :: [Autor]
autoresJaponeses = ["Hajime Isayama"]

esAutorJapones :: Libro -> Bool
esAutorJapones (Libro _ autor _) = autor `elem` autoresJaponeses 