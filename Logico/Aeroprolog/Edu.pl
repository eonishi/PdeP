%vende(Empresa, EstiloDeViaje, Destino).

vende(mcs, crucero(10), rioDeJaneiro).
vende(mcs, crucero(20), mykonos).
vende(vacaviones, allInclusive(burjAlArab), dubai).
vende(vacaviones, allInclusive(wyndhamPlayaDelCarmen), playaDelCarmen).
vende(moxileres, mochila([carpa, bolsaDeDormir, linterna]), elBolson).
vende(moxileres, mochila([camara, cantimplora, protectorSolar, malla]), puntaDelDiablo).
vende(tuViaje, clasico(primavera, avion), madrid).
vende(tuViaje, clasico(verano, micro), villaGesell).
vende(destinoFinal, clasico(otonio,avion), sidney). % 7
vende(destinoFinal, clasico(primavera,avion), osaka). % 7
vende(pdepViajes, mochila([adaptadorElectrico, malla, protectorSolar]), oranjestad). %7

%crucero(CantidadDeDias).
%allInclusive(Hotel).
%mochila(Objetos).
%clasico(Temporada, MedioDeTransporte).

%continente(Destino, Continente).
continente(rioDeJaneiro, sudAmerica).
continente(mykonos, europa).
continente(dubai, asia).
continente(playaDelCarmen, centroAmerica).
continente(puntaDelDiablo, sudAmerica).
continente(madagascar, africa).
continente(algunLugar, algunContinente).
continente(madrid, europa).
continente(sidney, oceania). % 7
continente(osaka, asia). % 7

%moneda(Destino, Moneda).
moneda(rioDeJaneiro, real).
moneda(mykonos, euro).
moneda(osaka, yen).
moneda(shenzhen, renminbi).
moneda(algunLugar,ariaryMalgache).
moneda(sidney, dolarAustraliano). % 7
moneda(oranjestad, florin). % 7

%cambioAPesos(Moneda, Conversion).
cambioAPesos(real, 58).
cambioAPesos(yen, 2).
cambioAPesos(pesoMexicano, 17).
cambioAPesos(ariaryMalgache, 0.063).
cambioAPesos(euro, 800).
cambioAPesos(dolarAustraliano, 187). % 7 


% 1. viajaA/2
viajaA(Empresa, Continente):-
    vende(Empresa, _, Destino),
    continente(Destino, Continente).

% 2. esMasCaro/2
esMasCaro(Destino, OtroDestino):-
    moneda(Destino,_),
    moneda(OtroDestino,_),
    conversionDeMoneda(Destino, MonedaConvertida),
    conversionDeMoneda(OtroDestino, OtraMonedaConvertida),
    MonedaConvertida > OtraMonedaConvertida.

conversionDeMoneda(Destino, MonedaConvertida):-
    moneda(Destino, Moneda),
    cambioAPesos(Moneda, MonedaConvertida).

% 3. conviene/1
conviene(Destino):-
    continente(Destino, _),
    valeMenosQuePesoArg(Destino),
    destinoNoQuedaEn(Destino, europa).

valeMenosQuePesoArg(Destino):-
    moneda(Destino, Moneda),
    cambioAPesos(Moneda, Precio),
    Precio < 1.

destinoNoQuedaEn(Destino, Continente):-
    continente(Destino,_),
    not(continente(Destino, Continente)).

% 4. elDestinoMasExclusivo/2
elDestinoMasExclusivo(Destino, Empresa):-
    vende(Empresa, _ , Destino),
    vende(Empresa, _ ,OtroDestino),
    forall(vende(Empresa,_,Destino),esMasCaro(Destino, OtroDestino)).

% 5. ventaExtravagante/1
ventaExtravagante(Destino):-
    vende(_, EstiloDeViaje, Destino),
    not(conviene(Destino)),
    esExtravagante(EstiloDeViaje).

esExtravagante(crucero(Dias)):-
    Dias > 365.
esExtravagante(mochila([])).
esExtravagante(clasico(invierno,_)):-
    vende(_,_,tuktuk).
esExtravagante(clasico(_, bicicleta)):-
    vende(_,_,tandem).

% 6. indiceDeExtravagancia/2
indiceDeExtravagancia(Indice, Empresa):-
    cantidadDeVentasExtravagantes(Empresa,Cantidad),
    Indice is Cantidad / 100.

cantidadDeVentasExtravagantes(Empresa, Cantidad):-
    vende(Empresa, _ , _),
    findall(Destino,(vende(Empresa,_,Destino), ventaExtravagante(Destino)),Ventas),
    length(Ventas, Cantidad).

% 7. Aplicadas en la base de conocimiento 
