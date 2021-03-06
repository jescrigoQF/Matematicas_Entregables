*MODELO MARKOWITZ*
*DEFINIMOS SETS
SETS  I CATEGORIAS /AC,BON,AC_IN/;
ALIAS(I,J);

*ESCALARES
SCALAR M OBJETIVO MEDIO DEL RENDIMIENTO DE LA CARTERA /9.0/;

*VECTOR DE LISTA
PARAMETERS MEDIA(I) MEDIAS ANUALES DE RENDIMIENTO
/AC 10.8
BON 7.6
AC_IN 9.5 
/;

TABLE C(I,J) MATRIZ DE VARIANZAS Y COVARIANZAS
            AC     BON     AC_IN
AC          2.25   -0.12   0.45
BON         -0.12  0.64    0.336
AC_IN       0.45   0.336   1.44;

VARIABLES VAR, X(I);

POSITIVE VARIABLES X(I);


EQUATIONS FO, RESTRIC1, RESTRIC2;

*FO.. VAR=E=SUM(I,X(I)*SUM(J,X(J)*C(I,J)));
FO.. VAR=E=SUM((I,J),X(I)*C(I,J)*X(J));
RESTRIC1.. SUM(I,MEDIA(I)*X(I))=G=M;
RESTRIC2.. SUM(I,X(I))=E=1;

MODEL MARKOWITZ/FO,RESTRIC1,RESTRIC2/;

SOLVE MARKOWITZ USING NLP MINIMIZING VAR;

  