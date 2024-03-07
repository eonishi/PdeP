%canta(Nombre, Cancion(Nombre, Duracion))

canta(megurineLuka,  cancion(nightFive, 4)       ).
canta(megurineLuka,  cancion(foreverYoung, 5)    ).
canta(hatsuneMiku,   cancion(tellYourWorld, 4)   ).
canta(gumi,          cancion(foreverYoung, 4)    ). 
canta(gumi,          cancion(tellYourWorld, 5)   ). 
canta(seeU,          cancion(novemberRain, 6)    ). 
canta(seeU,          cancion(nightFive, 5)       ). 

%-
novedoso(Cantante) :- 
    sabeAlMenosDosCanciones(Cantante),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo < 15.
    
sabeAlMenosDosCanciones(Cantante) :-
    canta(Cantante, UnaCancion),
    canta(Cantante, OtraCancion),
    UnaCancion \= OtraCancion.
    
tiempoTotalCanciones(Cantante, TiempoTotal) :-
    findall(TiempoCancion, 
    tiempoDeCancion(Cantante, TiempoCancion), Tiempos), 
    sumlist(Tiempos,TiempoTotal).
    
tiempoDeCancion(Cantante,TiempoCancion):-  
    canta(Cantante,Cancion),
    tiempo(Cancion,TiempoCancion).
    
tiempo(cancion(_, Tiempo), Tiempo).

acelerado(Cantante):-
    vocaloid(Cantante),
    not(
        (   
            tiempoDeCancion(Cantante, Tiempo), 
            Tiempo > 4
        )
        ).

    
vocaloid(Cantante):- canta(Cantante,_).    
    
    
    
%---
%concierto(Nombre, Pais, Fama, Tipo)
%tipo-> gigante(cantidadMinimaDeCanciones, duracionTotalMayorA)
%tipo-> mediano(duracionTotalMenorA)
%tipo-> pequeño(cancionDurasMasQue)

concierto(mikuExpo,     estadosUnidos,  2000,   gigante(2, 6)).
concierto(magicalMirai, japon,          3000,   gigante(3, 10)).
concierto(vocalekt,     estadosUnidos,  1000,   mediano(9)).
concierto(mikuFest,     argentina,      100,    pequenio(4)).

puedeParticipar(hatsuneMiku, Concierto):- concierto(Concierto,_,_,_).
puedeParticipar(Cantante, Concierto):-
    vocaloid(Cantante),
    Cantante \= hatsuneMiku,
    concierto(Concierto,_,_,Tipo),
    cumpleCondicionSegunElTipo(Cantante, Tipo).

cumpleCondicionSegunElTipo(Cantante, gigante(MinimoDeCanciones, DuracionTotal)):-
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo > DuracionTotal,
    cancionesTotales(Cantante, Canciones),
    Canciones >= MinimoDeCanciones.

cumpleCondicionSegunElTipo(Cantante, mediano(DuracionTotal)):-
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo =< DuracionTotal.

cumpleCondicionSegunElTipo(Cantante, pequenio(TiempoMinimoDeUnaCancion)):-
    tiempoDeCancion(Cantante, Tiempo),
    Tiempo >= TiempoMinimoDeUnaCancion.

cancionesTotales(Cantante, CancionesTotales):-
    findall(Cancion, canta(Cantante, Cancion), ListaDeCanciones),
    length(ListaDeCanciones, CancionesTotales ).
    

%vocaloidMasFamoso(Cantante):-
%    findall(Indice, indiceDeFama(Cantante, Indice), )


masFamoso(Cantante) :-
	nivelFamoso(Cantante, NivelMasFamoso),
	forall(nivelFamoso(_, Nivel), NivelMasFamoso >= Nivel).

nivelFamoso(Cantante, Nivel):- 
    famaTotal(Cantante, FamaTotal), 	cancionesTotales(Cantante, Cantidad), 
    Nivel is FamaTotal * Cantidad.
    
    famaTotal(Cantante, FamaTotal):- 
    vocaloid(Cantante),
    findall(Fama, famaConcierto(Cantante, Fama),  
    CantidadesFama), 	
    sumlist(CantidadesFama, FamaTotal).
    
    famaConcierto(Cantante, Fama):-
    puedeParticipar(Cantante,Concierto),
    fama(Concierto, Fama).
    
    fama(Concierto,Fama):- 
    concierto(Concierto,_,Fama,_).

%------

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

%unicoCantanteDe(Concierto, Cantante):-

conocido(Cantante, OtroCantante):- conoce(Cantante, OtroCantante).
conocido(Cantante, OtroCantante):- 
    conoce(Cantante, UnCantante), 
    conoce(UnCantante, OtroCantante).
