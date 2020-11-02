SET S /S-1*S-4/;
*SET TIME /T0,T1,T2/;
*SET ACTIVOS /X1, X2/;
*SET POSIBILIDADES /UU, UD, DU, DD/;

VARIABLES RP2,W(S),Y(S);
POSITIVE VARIABLES W(S),Y(S);

EQUATIONS FO,R4;

FO.. RP2=E=Y('S-1')-4*W('S-1');
R4.. 1.25*55*1.25+1.14*1.14*0-Y('S-1')+ W('S-1')=E=70;



MODEL MARKOWIT /ALL/;

SOLVE MARKOWIT USING NLP MAXIMIZING RP2;