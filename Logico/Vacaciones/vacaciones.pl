destino(dodain, pehuenia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).
destino(alf,    bariloche).
destino(alf,    sanMartin).
destino(alf,    elBolson).
destino(nico,   marDelPlata).
destino(vale,   cafalate).
destino(vale,   elBolson).

destino(martu, Lugar) :- 
    destino(alf, Lugar);
    destino(nico, Lugar).

destino(pepe, esquel).
destino(pepe, pehuenia).
destino(carlos, pehuenia).

%------Revisar el caso Juan !!!!!-------------



%atraccion (destino, atraccion )
%atracciones: 
%   parqueNacional(Nombre)
%   excursion(Nopmbre)
%   cerro(Cerro, Altura)
%   cuerpoDeAgua(nombre, sePuedePescar, temperaturaPromdio)
%   playa(indiceMarea)


atraccion(esquel,   parqueNacional(losAlerces)).
atraccion(esquel,   excursion(trochita)).
atraccion(esquel,   excursion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue, 14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, 19)).

permitePescar(moquehue).
permitePescar(alumine).

vacacionesCopadas(Persona):-
    destino(Persona, _),
    forall(destino(Persona, Lugar), tieneAlMenosUnaAtraccionCopada(Lugar)).

tieneAlMenosUnaAtraccionCopada(Lugar):-
    atraccion(Lugar, Atraccion),
    atraccionCopada(Atraccion).

atraccionCopada(cerro(_,2000)).
atraccionCopada(cuerpoDeAgua(Nombre, Temperatura)):-
    permitePescar(Nombre); 
    Temperatura > 20.
atraccionCopada(playa(IndiceMarea)):- IndiceMarea < 5.
atraccionCopada(excursion(Excursion)):- atom_length(Excursion, Cantidad), Cantidad > 7.
atraccionCopada(parqueNacional(_)).

seCruzaron(Persona, OtraPersona):-
    destino(Persona, Lugar),
    destino(OtraPersona, Lugar),
    Persona \= OtraPersona.

noSeCruzaron(Persona, OtraPersona):-
    destino(Persona, Lugar),
    destino(OtraPersona, OtraLugar),
    Lugar \= OtraLugar.


%Punto 4

costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(cafalate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

lugarGasolero(Lugar):-
    costoDeVida(Lugar, Costo),
    Costo < 160.

vacacionesGasoleras(Persona):-
    destino(Persona, _),
    forall(destino(Persona, Lugar), lugarGasolero(Lugar)).


armarIntinerario(Persona, Intinerario):-
    destino(Persona, _),
    findall(Lugar, destino(Persona, Lugar), Destinos),
    permutation(Destinos, Intinerario).