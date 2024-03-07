%  1) Base de Conocimiento
%Informacion de los candidatos
candidato(jackie,       amarillo).
candidato(seth,         amarillo).
candidato(heather,      amarillo).
candidato(peter,        not(amarillo)).
candidato(garrett,      azul).
candidato(linda,        azul).
candidato(frank,        rojo).
candidato(claire,       rojo).
candidato(catherine,    rojo).

edad(jackie,    26).
edad(heather,   54).
edad(peter,     26).
edad(garrett,   64).
edad(linda,     30).
edad(frank,     50).
edad(claire,    52).
edad(catherine, 59).

%Relacion partidos -> provincias
sePostula(azul,      buenosAires).
sePostula(azul,      chaco).
sePostula(azul,      tierraDelFuego).
sePostula(azul,      sanLuis).
sePostula(azul,      neuquen).

sePostula(rojo,      buenosAires).
sePostula(rojo,      santaFe).
sePostula(rojo,      cordoba).
sePostula(rojo,      chubut).
sePostula(rojo,      tierraDelFuego).
sePostula(rojo,      sanLuis).

sePostula(amarillo,  buenosAires).
sePostula(amarillo,  chaco).
sePostula(amarillo,  formosa).
sePostula(amarillo,  tucuman).
sePostula(amarillo,  salta).
sePostula(amarillo,  santaCruz).
sePostula(amarillo,  laPampa).
sePostula(amarillo,  corrientes).
sePostula(amarillo,  misiones).

%Habitantes por provincia
habitantes(buenosAires,     15355000).
habitantes(chaco,           1143201).
habitantes(tierraDelFuego,  160720).
habitantes(sanLuis,         489255).
habitantes(neuquen,         637913).
habitantes(santaFe,         3397532).
habitantes(cordoba,         3567654).
habitantes(chubut,          577466).
habitantes(formosa,         527895).
habitantes(tucuman,         1687305).
habitantes(salta,           1333365).
habitantes(santaCruz,       273964).
habitantes(laPampa,         349299).
habitantes(corrientes,      992595).
habitantes(misiones,        1189446). 


% Intencion de voto:
% intencionDeVotoEn(Provincia,      Partido,    Porcentaje)
intencionDeVotoEn(buenosAires,      rojo,       40).
intencionDeVotoEn(buenosAires,      azul,       30).
intencionDeVotoEn(buenosAires,      amarillo,   30).

intencionDeVotoEn(chaco,            rojo,       50).
intencionDeVotoEn(chaco,            azul,       20).
intencionDeVotoEn(chaco,            amarillo,   0).

intencionDeVotoEn(tierraDelFuego,   rojo,       40).
intencionDeVotoEn(tierraDelFuego,   azul,       20).
intencionDeVotoEn(tierraDelFuego,   amarillo,   10).

intencionDeVotoEn(sanLuis,          rojo,       50).
intencionDeVotoEn(sanLuis,          azul,       20).
intencionDeVotoEn(sanLuis,          amarillo,   0).

intencionDeVotoEn(neuquen,          rojo,       80).
intencionDeVotoEn(neuquen,          azul,       10).
intencionDeVotoEn(neuquen,          amarillo,   0).

intencionDeVotoEn(santaFe,          rojo,       20).
intencionDeVotoEn(santaFe,          azul,       40).
intencionDeVotoEn(santaFe,          amarillo,   40).

intencionDeVotoEn(cordoba,          rojo,       10).
intencionDeVotoEn(cordoba,          azul,       60).
intencionDeVotoEn(cordoba,          amarillo,   20).

intencionDeVotoEn(chubut,           rojo,       15).
intencionDeVotoEn(chubut,           azul,       15).
intencionDeVotoEn(chubut,           amarillo,   15).

intencionDeVotoEn(formosa,          rojo,       0).
intencionDeVotoEn(formosa,          azul,       0).
intencionDeVotoEn(formosa,          amarillo,   0).

intencionDeVotoEn(tucuman,          rojo,       40).
intencionDeVotoEn(tucuman,          azul,       40).
intencionDeVotoEn(tucuman,          amarillo,   20).

intencionDeVotoEn(salta,            rojo,       30).
intencionDeVotoEn(salta,            azul,       60).
intencionDeVotoEn(salta,            amarillo,   10).

intencionDeVotoEn(santaCruz,        rojo,       10).
intencionDeVotoEn(santaCruz,        azul,       20).  
intencionDeVotoEn(santaCruz,        amarillo,   30).

intencionDeVotoEn(laPampa,          rojo,       25).
intencionDeVotoEn(laPampa,          azul,       25).
intencionDeVotoEn(laPampa,          amarillo,   40).

intencionDeVotoEn(corrientes,       rojo,       30).
intencionDeVotoEn(corrientes,       azul,       30).
intencionDeVotoEn(corrientes,       amarillo,   10).

intencionDeVotoEn(misiones,         rojo,       90).
intencionDeVotoEn(misiones,         azul,       0).
intencionDeVotoEn(misiones,         amarillo,   0).