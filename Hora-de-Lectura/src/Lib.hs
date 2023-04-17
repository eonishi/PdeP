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
type Libro = (Nombre, Autor, Paginas)
type Biblioteca = [Libro]
type Saga = [Libro]

-- Declaracion de los libros
elVisitante :: Libro
elVisitante = ("El visitante", "Stephen King", 592)

snk1 :: Libro
snk1 = ("SNK-1", "Hajime Isayama", 40)

snk3 :: Libro
snk3 = ("SNK-3", "Hajime Isayama", 40)

snk127 :: Libro
snk127 = ("SNK-127", "Hajime Isayama", 40)

fundacion :: Libro
fundacion = ("Fundacion", "Isaac Asimov", 230)

sandman5 :: Libro
sandman5 = ("Sandman-5", "Neil Gaiman", 35)

sandman10 :: Libro
sandman10 = ("Sandman-10", "Neil Gaiman", 35)

sandman12 :: Libro
sandman12 = ("Sandman-12", "Neil Gaiman", 35)

eragon :: Libro
eragon = ("Eragon", "Christopher Paolini", 544)

eldest :: Libro
eldest = ("Eldest", "Christopher Paolini", 704)

brisignr :: Libro
brisignr = ("Brisignr","Christopher Paolini", 700)

legado :: Libro
legado = ("Legado","Christopher Paolini", 811)


-- Mi biblioteca
biblioteca :: Biblioteca
biblioteca = [elVisitante, snk1, snk3, snk127, fundacion, sandman5, sandman10, sandman12, eragon, eldest, brisignr, legado]

-- Funciones Accessors
nombre :: Libro -> Nombre
nombre (nombre, _, _) = nombre

autor :: Libro -> Autor
autor (_, autor, _) = autor

paginas :: Libro -> Int
paginas (_ ,_ , paginas) = paginas 


-- Promedio de las hojas de mi biblioteca
promedioDeHojas :: Biblioteca -> Paginas
promedioDeHojas biblioteca = div (cantidadDeHojas biblioteca) (length biblioteca)

cantidadDeHojas :: Biblioteca -> Paginas
cantidadDeHojas biblioteca = (sum.listaDePaginas) biblioteca

listaDePaginas :: Biblioteca -> [Paginas]
listaDePaginas biblioteca  = map paginas biblioteca

-- Lectura Obligatoria
lecturaObligatoria :: Libro -> Bool
lecturaObligatoria libro = autor libro == "Stephen King" || perteneceSagaEragon libro || esMismoLibro libro fundacion

sagaEragon :: Saga
sagaEragon = [eragon, eldest, brisignr, legado]

perteneceSagaEragon :: Libro -> Bool
perteneceSagaEragon libro = elem libro sagaEragon

esMismoLibro :: Libro -> Libro -> Bool
esMismoLibro unLibro otroLibro = nombre unLibro == nombre otroLibro &&
                                autor unLibro == autor otroLibro &&
                                paginas unLibro == paginas otroLibro

-- Biblioteca fantasiosa
esBibliotecaFantasiosa :: Biblioteca -> Bool
esBibliotecaFantasiosa biblioteca = any esLibroFantasioso biblioteca

esDeAutor :: Libro -> Autor -> Bool -- Funcion auxiliar para saber si un libro es de un autor
esDeAutor unLibro unAutor = autor unLibro == unAutor

esLibroFantasioso :: Libro -> Bool
esLibroFantasioso unLibro = esDeAutor unLibro "Christopher Paolini" || esDeAutor unLibro "Neil Gaiman"


-- Nombre de la biblioteca
nombreDeLaBiblioteca :: Biblioteca -> Nombre
nombreDeLaBiblioteca nombre = (sacarVocales.unirNombres) nombre 

sacarVocales :: Nombre -> Nombre
sacarVocales nombre = filter (`notElem` "aAeEiIoOuU -áÁéÉíÍóÓúÚ") nombre

unirNombres :: Biblioteca -> Nombre
unirNombres biblioteca =  (concat.listaDeNombres) biblioteca
-- uniNombres biblioteca = concatMap nombre biblioteca

listaDeNombres :: Biblioteca -> [Nombre]
listaDeNombres biblioteca = map nombre biblioteca

-- Biblioteca Ligera
bibliotecaLigera :: Biblioteca -> Bool
bibliotecaLigera biblioteca = all esLibroLigero biblioteca

esLibroLigero :: Libro -> Bool
esLibroLigero libro = paginas libro < 40

-- Funcion que devuelve el genero del libro
genero :: Libro -> String
genero unLibro 
    | autor unLibro == "Stephen King" = "Terror"
    | esAutorJapones unLibro = "Manga"
    | esLibroLigero unLibro = "Comic"
    | otherwise = "No clasificado"

autoresJaponeses :: [Autor]
autoresJaponeses = ["Hajime Isayama"]

esAutorJapones :: Libro -> Bool
esAutorJapones (_, autor, _) = autor `elem` autoresJaponeses 