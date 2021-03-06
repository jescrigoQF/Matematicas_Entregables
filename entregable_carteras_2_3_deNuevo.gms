
SETS T ESCENARIOS /t-0*t-51/
     J CATEGORIAS /RD, ARZ, KLM, PHI, UN/;
 

SCALAR n1 Escenarios /51/;
SCALAR n2 Activos /5/;
SCALAR M Objetivo de rendimiento /0.2/;
SCALAR P Probabilidad de cada escenario /0.02/;

TABLE C(T,J) PRECIOS DE LAS ACCIONES 
        RD       ARZ      KLM      PHI      UN
t-0    111.0    82.5     70.0     154.6    110.8 
t-1    108.1    81.6     73.7     152.4    108.0
t-2    107.9    80.1     72.3     146.1    103.7
t-3    108.5    83.1     69.7     157.5    106.6
t-4    111.4    85.0     69.5     168.4    107.3
t-5    115.5    92.6     74.8     166.9    109.5
t-6    113.2    91.6     73.8     164.1    108.7
t-7    111.9    88.3     70.2     169.0    111.1
t-8     99.7    80.8     64.3     143.8    101.0
t-9    105.1    86.1     71.8     151.3    105.4
t-10   100.9    81.8     71.7     148.3    109.6
t-11   105.0    85.6     69.5     140.6    112.8
t-12   105.2    84.6     70.5     131.5    113.6
t-13   107.0    90.3     74.9     138.0    117.4
t-14   109.0    88.3     78.5     135.4    123.1
t-15   111.4    85.6     73.0     114.0    124.5
t-16   107.2    81.6     74.5     116.1    118.7
t-17   111.3    87.4     75.0     121.6    125.0
t-18   108.6    87.5     77.0     127.6    127.7
t-19   105.6    86.6     72.4     116.2    121.2
t-20   105.9    90.0     71.4     128.6    125.1
t-21   104.7    91.4     68.9     129.4    119.9
t-22   107.7    95.3     69.7     137.1    117.9
t-23   107.4    92.9     68.6     134.5    124.6
t-24   108.0    97.0     70.2     156.0    124.3
t-25   104.7   102.6     74.3     159.5    128.8
t-26   112.8   107.0     76.3     155.9    134.2
t-27   109.7   110.4     86.0     155.0    140.9
t-28   111.7   109.7     88.9     149.9    138.2
t-29   120.4   105.9     83.5     153.5    141.6
t-30   118.0   105.9     83.4     153.0    140.6
t-31   119.7   103.0     84.9     149.9    158.2
t-32   116.7   102.4     84.9     153.7    149.6
t-33   115.8   107.2     86.1     167.0    152.8
t-34   113.7   104.5     78.9     181.0    144.3
t-35   115.7   105.8     79.5     189.4    155.5
t-36   114.4   104.8     79.1     197.9    154.2
t-37   113.8   103.8     79.9     201.7    154.5
t-38   114.0   107.0     82.0     196.3    158.0
t-39   114.1   107.4     77.2     188.0    163.8
t-40   111.5   112.0     78.5     189.9    164.3
t-41   109.2   106.8     77.1     172.1    163.9
t-42   110.1   105.3     76.1     178.0    165.6
t-43   112.8   113.1     82.6     171.0    161.4
t-44   111.0   116.6     91.4     179.5    165.4
t-45   105.6   126.7     94.5     180.6    160.9
t-46   107.3   123.1     90.0     173.5    162.0
t-47   103.2   112.3     88.5     164.4    153.0
t-48   102.8   103.1     81.8     164.2    141.2
t-49    93.9    95.0     80.7     153.0    133.4
t-50    93.6    92.7     80.5     164.0    139.3;

PARAMETERS MEDIA(J) MEDIAS ANUALES DE RENDIMIENTO
/RD -0.28
ARZ 0.33
KLM 0.40
PHI 0.30
UN  0.55
/;

SET I /t-0*t-49 /;
PARAMETER R(I,J) RENDIMIENTO ENTRE PERIODOS
loop((I(T),J),R(I,J)=100*(C(T+1,J)-C(T,J))/C(T,J));

*PLANTEAMOS EL MODELO
VARIABLES LOWVAR,X(J),Q(I) ;
POSITIVE VARIABLES X(J),Q(I);
EQUATIONS FO, RESTRICT1(I), RESTRICT2, RESTRICT3;

FO.. LOWVAR=E=P*SUM(I, POWER(Q(I),2));
RESTRICT1(I).. SUM(J,(R(I,J)*X(J)))+Q(I)=G=M;
RESTRICT3.. SUM(J,MEDIA(J)*X(J))=G=M;
RESTRICT2.. SUM(J,X(J))=e=1;

MODEL EJERCICIO1 /ALL/;

SOLVE EJERCICIO1 USING NLP MINIMAZING LOWVAR;
DISPLAY X.L;

*CALCULAMOS LA VARIANZA DE LA CARTERA DE ACTIVOS
PARAMETER varianza;
varianza=P*SUM(I, POWER(SUM(J,X.L(J)*(R(I,J)- MEDIA(J))),2));
display varianza;