%vende(Empresa, EstiloDeViaje, Destino).
vende(mcs,          crucero(10),                                            rioDeJaneiro).
vende(mcs,          crucero(20),                                            mykonos).
vende(vacaviones,   allInclusive(burjAlArab),                               dubai).
vende(vacaviones,   allInclusive(wyndhamPlayaDelCarmen),                    playaDelCarmen).
vende(moxileres,    mochila([carpa, bolsaDeDormir, linterna]),              elBolson).
vende(moxileres,    mochila([camara, cantimplora, protectorSolar, malla]),  puntaDelDiablo).
vende(tuViaje,      clasico(primavera, avion),                              madrid).
vende(tuViaje,      clasico(verano, micro),                                 villaGesell).

%crucero(CantidadDeDias).
%allInclusive(Hotel).
%mochila(Objetos).
%clasico(Temporada, MedioDeTransporte).

%continente(Destino, Continente).
continente(rioDeJaneiro,    sudAmerica).
continente(mykonos,         europa).
continente(dubai,           asia).
continente(playaDelCarmen,  centroAmerica).
continente(puntaDelDiablo,  sudAmerica).
continente(madagascar,      africa).
continente(madrid,          europa).

%moneda(Destino, Moneda).
moneda(rioDeJaneiro,    real).
moneda(osaka,           yen).
moneda(shenzhen,        renminbi).

%cambioAPesos(Moneda, Conversion).
cambioAPesos(real,              58).
cambioAPesos(yen,               2).
cambioAPesos(pesoMexicano,      17).
cambioAPesos(ariaryMalgache,    0.063).


%viajaA/2: 
viajaA(Empresa, Continente ):-
    vende(Empresa, _, Destino),
    continente(Destino, Continente).

%esMasCaro/2
esMasCaro(Destino, OtroDestino):-
    conversionAPesos(Destino, Conversion),
    conversionAPesos(OtroDestino, OtraConversion),
    Conversion > OtraConversion.

conversionAPesos(Destino, Conversion):-
    moneda(Destino, Moneda),
    cambioAPesos(Moneda, Conversion).

%conviene
conviene(Destino):-
    monedaDevaluada(Destino),
    noQuedaEn(europa, Destino).

monedaDevaluada(Destino):-
    conversionAPesos(Destino,Conversion),
    Conversion < 1.

noQuedaEn(Continente, Destino):-
    continente(Destino, _),
    not(continente(Destino, Continente)).

%elDestinoMasExclusivo
elDestinoMasExclusivo(Destino, Empresa):-
    vende(Empresa,_, Destino),
    forall(vende(Empresa,_, OtroDestino), esMasCaro(Destino, OtroDestino)).

%ventaExtravagante
ventaExtravagante(Destino):-
    vende(_, EstiloDeViaje, Destino),
    not(conviene(Destino)),
    esExtravagante(EstiloDeViaje).

vehiculoExtravagante(tuktuk).
vehiculoExtravagante(monopatin).

esExtravagante(crucero(Dias)):- Dias > 365.
esExtravagante(mochila([])).
esExtravagante(clasico(invierno, Vehiculo)):- vehiculoExtravagante(Vehiculo).

%IndiceDeExtravagancia
indiceDeExtravagancia(Indice, Empresa):-
    vende(Empresa,_,_),
    cantidadDeVentasExtravagantes(Empresa, Cantidad),
    Indice is Cantidad/100.

cantidadDeVentasExtravagantes(Empresa, Cantidad):-
    findall(Destino, ventaExtravagante(Destino), Destinos),
    findall(Destino, (vende(Empresa,_,Destino), member(Destino, Destinos)), VentasExtravagantes),
    length(VentasExtravagantes, Cantidad).
