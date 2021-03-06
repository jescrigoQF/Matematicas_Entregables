SET S /S-1*S-4/;
*SET TIME /T0,T1,T2/;
*SET ACTIVOS /X1, X2/;
*SET POSIBILIDADES /UU, UD, DU, DD/;

VARIABLES RP3,X11,X21,X121,X221,X122,X222,W(S),Y(S);
POSITIVE VARIABLES X11,X21,X122,X222,W(S),Y(S);

EQUATIONS FO,R0,R2,R5;

FO.. RP3=E=Y('S-3')-4*W('S-3');
R0.. X11+X21=E=55;
R2.. -1.06*X11-1.12*X21+X122+X222=E=0;
R5.. 1.25*X122+1.14*X222-Y('S-3')+ W('S-3')=E=70;




MODEL MARKOWIT /ALL/;

SOLVE MARKOWIT USING NLP MAXIMIZING RP3;