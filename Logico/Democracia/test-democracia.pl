%test del TP Logico:

:- consult('TP-logico.pl').

%Correr todos los test:
tests :-
    test_esPicante,
    test_leGana.

%Pruebas del Punto 2

test_esPicante :-
    esPicante(buenosAires),
    not(esPicante(santaFe)),
    not(esPicante(sanLuis)).


%Pruebas del Punto 3
test_leGana :-
    leGana(frank,   garrett, tierraDelFuego),
    leGana(frank,   jackie,  santaFe),
    not(leGana(claire,  jackie,  misiones)),
    leGana(frank,   claire,  tierraDelFuego),
    not(leGana(heather, linda,   buenosAires)).
