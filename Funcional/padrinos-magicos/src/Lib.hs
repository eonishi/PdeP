import Text.Show.Functions ()

data Chico = Chico
    {
        nombre :: String,
        edad:: Int,
        habilidades:: Habilidades,
        deseos:: [Deseo]
    } deriving Show

type Deseo = Chico -> Chico
type Habilidades = [String]

carlos :: Chico
carlos = Chico
    {
        nombre = "Carlos",
        edad = 12,
        habilidades = ["Comer", "tomar", "Domir"],
        deseos = [serMayor, aprenderHabilidades ["Correr"], aprenderHabilidades ["Algo"]]
    }


aprenderHabilidades :: Habilidades -> Deseo
aprenderHabilidades unashabilidades unChico = unChico{habilidades = unashabilidades ++ habilidades unChico }

serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = aprenderHabilidades todosLosNeedForSpeed 

todosLosNeedForSpeed :: [String]
todosLosNeedForSpeed = map(\unNumero -> "jugar NSF" ++ show unNumero) [1..]

--serMayor :: Deseo
--serMayor = cambiarEdad (=18)

cambiarEdad :: Num a =>   Chico -> ((a -> a) -> a) -> Chico
cambiarEdad unChico alteracionDeEdad  = unChico {edad = alteracionDeEdad (edad unChico) }

type PadrinoMagico = Chico -> Chico

edadActual :: Chico -> Int
edadActual = edad

primerDeseo :: Chico -> Deseo
primerDeseo = head.deseos

cumplirDeseo :: Deseo -> Chico -> Chico
cumplirDeseo unDeseo = unDeseo

cumplirPrimerDeseo :: Chico -> Chico
cumplirPrimerDeseo pibe = cumplirDeseo (primerDeseo pibe) pibe

--wanda :: PadrinoMagico
--wanda pibe = cambiarEdad(edadActual pibe +1).cumplirPrimerDeseo $ pibe


