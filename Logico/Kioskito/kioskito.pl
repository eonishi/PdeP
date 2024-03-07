
% turno(Persona, dia, ).
atiende(dodain,     lunes,      9,  15).
atiende(dodain,     miercoles,  9,  15).
atiende(dodain,     viernes,    9,  15).
atiende(lucas,      martes,     10, 20).
atiende(juanC,      sabados,     18, 22).
atiende(juanC,      domingos,    18, 22).
atiende(juanFdS,    jueves,     10, 20).
atiende(juanFdS,    viernes,    12, 20).
atiende(leoC,       lunes,      14, 18).
atiende(leoC,       miercoles,   14, 18).
atiende(martu,      miercoles,  23, 24).


atiende(vale, Dia, Entrada, Salida) :- 
    atiende(dodain, Dia, Entrada, Salida);
    atiende(juanC, Dia, Entrada, Salida).


% 2

quienAtiendeLos(Dia, Hora, Persona):-
    atiende(Persona, Dia, Entrada, Salida),
    between(Entrada, Salida, Hora).


% 3

foreverAlone(Persona,Dia,Hora):-
    quienAtiendeLos(Dia, Hora, Persona),
    not((quienAtiendeLos(Dia, Hora, OtraPersona), OtraPersona \= Persona)).

% 4
posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, quienAtiendeLos(Dias,_, Persona)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).
  

%5 
venta(dodain,   fecha(10, 8), [golosina(1200), cigarillos([jockey])], golosina(50)).
venta(dodain,   fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosina(10)]).
venta(martu,    fecha(12, 8), [golosina(1000), cigarillos([chesterfield, colorado, parisiennes])]).
venta(lucas,    fecha(11, 8), [golosina(600)]).
venta(lucas,    fecha(18, 8), [bebidas(false, 2), cigarillos([derby])]).

personaSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).
  
  vendedora(Persona):-venta(Persona, _, _).
  
  ventaImportante(golosinas(Precio)):-Precio > 100.
  ventaImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
  ventaImportante(bebidas(true, _)).
  ventaImportante(bebidas(_, Cantidad)):-Cantidad > 5.