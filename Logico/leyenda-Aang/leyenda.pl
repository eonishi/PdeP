% esPersonaje/1 nos permite saber qué personajes tendrá el juego

esPersonaje(zuko).
esPersonaje(toph).
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(azula).
esPersonaje(iroh).
esPersonaje(bumi).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(tayLee).
esPersonaje(suki).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(katara, sangre).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi, tierra).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
%reinoTierra(nombreDelLugar, estructura)
%nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(suki, nacionDelFuego(prision, 200)).
visito(tayLee, nacionDelFuego(prision, 200)).
visito(aang, nacionDelFuego(prision, 200)).
visito(katara, nacionDelFuego(prision, 200)).
visito(toph, nacionDelFuego(prision, 200)).


% 1. esElAvatar si controla todos los elementos básicos

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

% 2. noEsMaestro, esMaestroPrincipiante y esMaestroAvanzado nos permiten saber si un personaje es maestro de un elemento

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje, _)).

esMaestroPrincipiante(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje, Elemento),
    esElementoBasico(Elemento).

esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_, Elemento).

esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    esElAvatar(Personaje).

% 3. sigueA/2 nos permite saber si un personaje sigue a otro

sigueA(Perseguido, Seguidor):-
    esPersonaje(Perseguido),
    esPersonaje(Seguidor),
    forall(visito(Perseguido, Lugar), visito(Seguidor, Lugar)),
    Perseguido \= Seguidor.

sigueA(aang, zuko).

% 4. esDignoDeConocer/1 nos permite saber si un lugar es digno de conocer.

esDignoDeConocer(Lugar):-
    visito(_, Lugar),
    esDigno(Lugar).

esDigno(temploAire(_)).
esDigno(tribuAgua(norte)).
esDigno(reinoTierra(_,Estructura)):-
    not(member(muro, Estructura)).

% 5. esPopular/1 nos permite saber si un lugar es popular. Un lugar es popular si lo visitaron al menos 4 personajes.

esPopular(Lugar) :-
    visito(_, Lugar),
    findall(Personaje, visito(Personaje, Lugar), Personajes),
    list_to_set(Personajes, PersonajesUnicos),
    length(PersonajesUnicos, Cantidad),
    Cantidad >= 4.

