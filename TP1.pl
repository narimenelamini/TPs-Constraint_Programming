
/*        TP1 --- PROLOG */
/* Exo 1: Lits */
appartient(X, [X|_]):-!.
appartient(X, [_,Y|L]):- appartient(X,Y|L).

premier(X,[X|_]).

dernier(X,[X]).
dernier(X,[_,Y|L]):-dernier(X,[Y|L]).

avantDernier(X,[X,_]).
avantDernier(X,[_,Y,Z|L]):-avantDernier(X,[Y,Z|L]).

supprimerK(1,[_|L],L).
supprimerK(K,[X,Y|L1],[X|L2]):- supprimerK(Kmoins1,[Y|L1],L2),K is Kmoins1+1.

longueur(0,[]).
longueur(N,[_|L]):-
	longueur(Nmoins1,L),
	N is Nmoins1 +1.

somme([X],X).
somme([X,Y|L],S):-
    somme([Y|L],S2),
    S is S2+X.

affiche1([]).
affiche1([X|L]):-write(X),
    nl,
    affiche1(L).

affiche2([]).
affiche2([X|L]):-
   affiche2(L),
   write(X),
   nl.

npair([]).
npair([-,-|L]):-npair(L).

appartient(X, [X|_]):-!.
appartient(X, [_,Y|L]):- appartient(X,[Y|L]).

aumoins2occ(X,[X,Y|L]):-!,
      appartient(X,[Y|L]).
aumoins2occ(X,[_,Y,Z|L]):-
      aumoins2occ(X,[Y,Z|L]).

concat([],L,L).
concat([X|L1],L2,[X|L3]):-
      concat(L1,L2,L3).
/* Exo 2 : Arbre généalogique */
homme(ali).
homme(hacene).
homme(hakim).
homme(mohamed).
homme(said).
homme(samir).

femme(djamila).
femme(fatma).
femme(houria).
femme(lilia).
femme(linda).

pere(mohamed,samir).
pere(samir,lilia).
pere(samir,said).
pere(said,hacene).
pere(said,linda).
pere(hakim,ali).

mere(fatma,samir).
mere(houria,lilia).
mere(houria,said).
mere(lilia,ali).
mere(djamila,hacene).
mere(djamila,linda).

/* parent(X,Y) : X est un parent de Y, pere ou mere */
parent(X,Y):-pere(X,Y),!.
parent(X,Y):-mere(X,Y).

/* fils(X,Y) : X est fils de Y */
fils(X,Y):-homme(X),parent(Y,X).

/* fille(X,Y) : X est fille de Y */
fille(X,Y):-femme(X),parent(Y,X).

/* enfant(X,Y) : X est enfant de Y */
enfant(X,Y):-fils(X,Y),!.
enfant(X,Y):-fille(X,Y).

/* grand_pere(X,Y) : X est grand-pere de Y */
grand_pere(X,Y):-pere(X,Z),parent(Z,Y).

/* grand_mere(X,Y) : X est grand-mere de Y */
grand_mere(X,Y):-mere(X,Z),parent(Z,Y).

/* frere(X,Y) : X est frere de Y */
frere(X,Y):-homme(X),pere(Z,X),pere(Z,Y),mere(T,X),mere(T,Y).

/* soeur(X,Y) : X est soeur de Y */
soeur(X,Y):-femme(X),pere(Z,X),pere(Z,Y),mere(T,X),mere(T,Y).

/* frere_ou_soeur(X,Y) ssi X est frere ou soeur de Y */
frere_ou_soeur(X,Y):-frere(X,Y),!.
frere_ou_soeur(X,Y):-soeur(X,Y).

/* tante(X,Y) ssi X est tante de Y */
tante(X,Y):-soeur(X,Z),parent(Z,Y).

/* grand_parent(X,Y) ssi X est grand parent de Y (grand-pere ou grand-mere) */
grand_parent(X,Y):-grand_pere(X,Y),!.
grand_parent(X,Y):-grand_mere(X,Y).

/* cousin_cousine(X,Y) ssi X est un cousin ou une cousine de Y */
cousin_cousine(X,Y):-parent(Z,X),parent(T,Y),frere_ou_soeur(Z,T).