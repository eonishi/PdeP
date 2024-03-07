import Text.Show.Functions ()

data Chico = Chico {
    nombre      :: String,
    edad        :: Int,
    habilidades :: [Habilidad],
    deseos      :: [Deseo]
} deriving Show

type Habilidad = String
type Deseo = Chico -> Chico

---------------- Deseos ---------------------
aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades lasHabilidades unChico = unChico { habilidades =  lasHabilidades ++ habilidades unChico } 

serGrosoEnNFS :: Deseo
serGrosoEnNFS  = map(\habilidad -> "jugar NFS" ++ show)[1..]