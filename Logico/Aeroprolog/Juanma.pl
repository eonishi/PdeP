%vende(Empresa, EstiloDeViaje, Destino).
vende(mcs, crucero(10), rioDeJaneiro).
vende(mcs, crucero(20), mykonos).
vende(vacaviones, allInclusive(burjAlArab), dubai).
vende(vacaviones, allInclusive(wyndhamPlayaDelCarmen), playaDelCarmen).
vende(moxileres, mochila([carpa, bolsaDeDormir, linterna]), elBolson).
vende(moxileres, mochila([camara, cantimplora, protectorSolar, malla]), puntaDelDiablo).
vende(tuViaje, clasico(primavera, avion), madrid).
vende(tuViaje, clasico(verano, micro), villaGesell).

vende(tuViaje, clasico(invierno, bicicleta), osaka).%agrego yo
vende(tuViaje, clasico(verano, micro),copaCabana).%agrego yo

%crucero(CantidadDeDias).
%allInclusive(Hotel).
%mochila(Objetos).
%clasico(Temporada, MedioDeTransporte).

%en que contienente qued cada destino
%continente(Destino, Continente).
continente(rioDeJaneiro, sudAmerica).
continente(mykonos, europa).
continente(dubai, asia).
continente(playaDelCarmen, centroAmerica).
continente(puntaDelDiablo, sudAmerica).
continente(madagascar, africa).
continente(madrid, europa).

continente(villaGesell,sudAmerica). %agrego yo
continente(elBolson,sudAmerica). %agrego yo
continente(ariaryMalgache,asia).%agrego yo

%sabemos la moneda de cada destino y el cambio de su moneda a pesos argentinos
%moneda(Destino, Moneda).
moneda(rioDeJaneiro, real).
moneda(osaka, yen).
moneda(shenzhen, renminbi).

moneda(copaCabana,ariaryMalgache).%agrego yo
moneda(mykonos,yen).%agrego yo
%cambioAPesos(Moneda, Conversion).
cambioAPesos(real, 58).
cambioAPesos(yen, 2).
cambioAPesos(pesoMexicano, 17).
cambioAPesos(ariaryMalgache, 0.063).

viajaA(UnaEmpresa,UnContinente):-
    vende(UnaEmpresa,_,UnDestino),
    continente(UnDestino,UnContinente).

esMasCaro(UnDestino,OtroDestino):-
    conversionAPesoDe(UnDestino,UnaConversion),
    conversionAPesoDe(OtroDestino,OtraConversion),
    UnaConversion>=OtraConversion.

conversionAPesoDe(UnDestino,UnaConversion):-
    vende(_,_,UnDestino),
    moneda(UnDestino,UnaMoneda),
    cambioAPesos(UnaMoneda,UnaConversion).

conviene(UnDestino):-
    monedaMuyBarata(UnDestino), %su moneda vale menos que un peso 
    not(continente(UnDestino,europa)).

    monedaMuyBarata(UnDestino):-
        conversionAPesoDe(UnDestino,UnaConversion),
        UnaConversion<1.

elDestinoMasExclusivo(UnDestino,UnaEmpresa):-
    vende(UnaEmpresa,_,UnDestino),
    forall(vende(UnaEmpresa,_,OtroDestino),esMasCaro(UnDestino,OtroDestino)).

ventaExtravagante(UnDestino):-
    vende(_,EstiloDeViaje,UnDestino),
    not(conviene(UnDestino)),
    esExtravagante(EstiloDeViaje).

    esExtravagante(crucero(CantidadDeDias)):-
        CantidadDeDias>365.
    esExtravagante(mochila([])).
    esExtravagante(clasico(invierno,tuktuk)).
    esExtravagante(clasico(invierno,bicicleta)).

indiceDeExtravagancia(Indice,UnaEmpresa):-
    vende(UnaEmpresa,_,_),
    destinosExtravagantesDe(UnaEmpresa,CantidadDeDestinosExtravagantes),
    Indice is CantidadDeDestinosExtravagantes/100.
    
    destinosExtravagantesDe(UnaEmpresa,Cantidad):-
        findall(Destino,esVentaExtravaganteDe(UnaEmpresa,Destino), DestinosExtravagantes),
        length(DestinosExtravagantes,Cantidad).

    esVentaExtravaganteDe(UnaEmpresa,UnDestino):-
        vende(UnaEmpresa,_,UnDestino),
        ventaExtravagante(UnDestino).

vende(destinoInicial,clasico(otoño,avion),sidney). %lo de otoño lo tome como una afirmacion de que la empresa efectivamente hara los viajes en esa epoca
continente(sidney,oceania).
moneda(sidney,dolarAustraliano).
cambioAPesos(dolarAustraliano,187).

vende(destinoInicial,clasico(primavera,avion),osaka).
continente(osaka,asia).

vende(pDePViajes,mochila([adaptadorElectrico,protectorSolar,malla],oranjestad)).
continente(oranjestad,sudAmerica). %segun wikipedia queda en america del sur
moneda(oranjestad,florin).