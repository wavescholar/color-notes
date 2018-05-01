function [attd_lgn,atd_p]=xyz2attd(XYZ,XYZb,vers)

%xyz2attd proporciona las respuestas ATTD del LGN y ATD perceptuales
%calculadas por el modelo ATTD, de la tesis doctoral de Juan Gomez
%Chova, para un test de valores triestimulo XYZ rodeado por un fondo
%de valores triestimulo XYZb.
%
%Las entradas que hay que especificar son:
%
%XYZ: valores triestimulo del test
%XYZb: valores triestimulo del fondo
%vers: version del modelo ATTD utilizada, en funcion del tipo de
%   adaptación multiplicativa del LGN:
%   vers=1: sin adaptación multiplicativa
%   vers=2: con tres constantes de adaptación multiplicativa distintas
%           para los canales A, TLM/TML y D
%   vers=3: con dos constantes de adaptación multiplicativa distintas
%           para los canales A y D, sin adaptación multiplicativa en TLM/TML
%
%USO: [attd_lgn,atd_p]=xyz2attd(XYZ,XYZb,vers);
%
%Se utilizan las minimizaciones optimas de cada version. Se supone
%adaptacion del fondo incluso en el caso de fondo de luminancia nula.
%El modo es no incremental. Se hace uso de la formula de Guth para
%el paso a trolands. El valor del exponente en la no linealidad de
%los receptores es 0.7. Se dispone de una version mas abierta de esta
%funcion, con todos estos elementos modificables, en tri2attd.m.

%if vers==1
  %attd22.mat
%  param=[.0000259840 .0000265363 .00000511503 .0311050 3.49915 .819008 .634650 1.66308 -1.79336 -.757840 .925930 -.351651 -.00161163 1.42380 .0338705 .0181030 3.36181 4.19776 2.93349 3.34368 .356082 .650463 -1.18537 1 .111860 .233112 .539972 .626902 -.0454104 -.896447 1.24534];
%elseif vers==2
  %attd20.mat
%  param=[.0000192969 .0000188247 .00000652034 .0323175 3.38212 .931202 .717131 1.61001 -1.81107 -.663761 .854725 -.372965 0 1.06485 .767963 1.05860 1.39057 .0348526 .0152446 3.03773 4.06401 3.02753 2.94610 .352881 .678587 -.773648 .876158 .130222 .246388 .623024 .654674 -.0551864 -.948072 1.30454];
%elseif vers==3
  %attd21.mat
%  param=[.0000287354 .0000294626 .0000108187 .0716515 3.39953 .936467 .769940 1.75270 -1.94985 -.735032 .939250 -.439822 0 1.16732 .787982 1.43824 .0340928 .0246542 3.24298 4.23430 3.03531 3.15793 .372451 .704747 -.146870 1 .142027 .245093 .773356 .632366 -.0702531 -.911283 1.29855];
%end

  if vers==1 load('attd22.mat','paramopt');
  elseif vers==2 load('attd20.mat','paramopt');
  elseif vers==3 load('attd21.mat','paramopt');
  end
  param=paramopt;
[attd_lgn,atd_p]=tri2attd(XYZ,XYZb,[0 1],2,2,0.7,vers);
