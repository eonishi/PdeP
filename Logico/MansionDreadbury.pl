viveEnLaMansion(tiaAgatha).
viveEnLaMansion(mayordomo).
viveEnLaMansion(charles).

odia(tiaAgatha, Persona):-
    viveEnLaMansion(Persona),
    Persona \= mayordomo.

odia(charles, Persona):-
    not(odia(tiaAgatha, Persona)).

odia(mayordomo, Persona):-
    odia(tiaAgatha, Persona).

masRico(tiaAgatha, Persona):-
    not(odia(mayordomo,Persona)),
    viveEnLaMansion(Persona).

quienMata(Asesino, Victima):-
    odia(Asesino, Victima),
    not(masRico(Victima, Asesino)),
    viveEnLaMansion(Asesino),
    Asesino \= Victima.


