function [attd1,atd2]=tri2attd(XYZ,XYZf,pesos,modo,form,n,vers,param)

%tri2attd proporciona, para unos valores cualesquiera de los
%parametros del modelo ATTD, las respuestas attd1 del LGN y atd2
%perceptuales correspondientes a un test de valores triestimulo
%XYZ visto en un fondo de valores triestimulo XYZf.
%
%Las entradas que hay que especificar son:
%
%XYZ: valores triestimulo del test
%XYZf: valores triestimulo del fondo
%pesos=[pt pf]: pesos del test y el fondo en la adaptacion
%modo: 1 si el test se observa como incremento sobre el fondo
%   y 2 si se observa rodeado por el fondo
%form: tipo de formula empleada para el cambio a trolands: 1 si
%   se emplea la de Crawford y 2 si se emplea la de Guth
%n: valor del exponente en la no linealidad de los receptores;
%   el valor por defecto es 0.7
%vers: version del modelo ATTD utilizada, en funcion del tipo de
%   adaptación multiplicativa del LGN:
%   vers=1: sin KMO (minimizacion optima: attd22.mat)
%   vers=2: con tres KMO distintas (minimizacion optima: attd20.mat)
%   vers=3: con dos KMO distintas para A y D (minimizacion optima: attd21.mat)
%   Si se usan valores distintos a los óptimos, se pueden introducir en el 
%   parámetro opcional param:
%      vers=1: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];
%      vers=2: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KMA KMT KMD KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];
%      vers=3: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KMA KMD KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];
%
%USO: [attd1,atd2]=tri2attd(XYZ,XYZf,pesos,modo,form,n,vers,param);
%
%Se dispone de una version mas cerrada y sencilla de la funcion, con los
%inputs utilizados en el manuscrito de la tesis, en xyz2attd.m.


%paramopt: valores de los parametros del modelo ATTD:
%   vers=1: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];
%   vers=2: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KMA KMT KMD KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];
%   vers=3: param=[WL WM WS KM KR M111 M112 M121 M122 M131 M132 M141 M142 M143 KMA KMD KSM KO RA RLM RML RD M211 M212 M222 KSA KST KSD M322 M323 M332 M333];

global attdlin

if nargin<8
  
  if vers==1 load('attd22.mat','paramopt');
  elseif vers==2 load('attd20.mat','paramopt');
  elseif vers==3 load('attd21.mat','paramopt');
  end
end

param=paramopt;
WL=param(1);WM=param(2);WS=param(3);KM=param(4);KR=param(5);M111=param(6);M112=param(7);M121=param(8);M122=param(9);M131=param(10);M132=param(11);M141=param(12);M142=param(13);M143=param(14);
if vers==1
  KSM=param(15);KO=param(16);RA=param(17);RLM=param(18);RML=param(19);RD=param(20);M211=param(21);M212=param(22);M222=param(23);KSA=param(24);KST=param(25);KSD=param(26);M322=param(27);M323=param(28);M332=param(29);M333=param(30);
elseif vers==2
  KMA=param(15);KMT=param(16);KMD=param(17);KSM=param(18);KO=param(19);RA=param(20);RLM=param(21);RML=param(22);RD=param(23);M211=param(24);M212=param(25);M222=param(26);KSA=param(27);KST=param(28);KSD=param(29);M322=param(30);M323=param(31);M332=param(32);M333=param(33);
elseif vers==3
  KMA=param(15);KMD=param(16);KSM=param(17);KO=param(18);RA=param(19);RLM=param(20);RML=param(21);RD=param(22);M211=param(23);M212=param(24);M222=param(25);KSA=param(26);KST=param(27);KSD=param(28);M322=param(29);M323=param(30);M332=param(31);M333=param(32);
end

format long;
if pesos==0
  pesos=[0 0];
end
num=size(XYZ);
%Fondo
if XYZf==0
  XYZf=zeros(1,3);
end
numf=size(XYZf);
if numf(1)==1
  XYZf=repmat(XYZf,num(1),1);
end
%Test
if modo==1
  XYZ=XYZ+XYZf;
end
%Normalización de luminancias: eliminamos los estímulos
%con X, Y ó Z negativos, que son todos irreales (pero no
%ocurre a la inversa, ojo) y el resto los renormalizamos
%de manera que la Y ya no coincida con la luminancia en
%cd/m2 sino con la iluminación retiniana en td. De ese modo
%simulamos la variación del tamaño pupilar.
XYZ=XYZ.*(XYZ(:,[2 2 2])>0);
XYZ=xyzl2td(XYZ,form);
XYZf=XYZf.*(XYZf(:,[2 2 2])>0);
XYZf=xyzl2td(XYZf,form);

%Fundamentales de Smith y Pokorny normalizados a la unidad
%(trabajaremos en este espacio colorimétrico)
t2c=[0.2435 0.8524 -0.0516;-0.3954 1.1642 0.0837;0 0 0.6225];
%Reescalado de los receptores
t2c=[WL 0 0;0 WM 0;0 0 WS]*t2c;
lms=t2c*XYZ';
lmsf=t2c*XYZf';
%Estímulo de adaptación (es una combinación test-fondo)
lmsa=pesos(1)*lms+pesos(2)*lmsf;
%Adaptación multiplicativa de los receptores
lms=lms.*(KM./(lmsa+KM));
lmsf=lmsf.*(KM./(lmsf+KM));
%No linealidad de los receptores
lms=lms.^n./(lms.^n+KR^n);
lmsf=lmsf.^n./(lmsf.^n+KR^n);
%Esta terna lms es la señal correspondiente en el
%espacio de conos
%Transformación lineal de 1ª etapa oponente
M1=[M111 M112 0;M121 M122 0;M131 M132 0;M141 M142 M143];
attd1=M1*lms;
attdlin=attd1;
%Componentes de centro de TLM y TML para obtener Ap:
ttc1=[M121 0 0;0 M132 0]*lms;
attd1f=M1*lmsf;

%Adaptación multiplicativa
if vers==1
elseif vers==2
  attd1(1,:)=attd1(1,:).*(KMA./(abs(attd1f(1,:))+KMA));
  attd1(2:3,:)=attd1(2:3,:).*(KMT./(abs(attd1f(2:3,:))+KMT));
  attd1(4,:)=attd1(4,:).*(KMD./(abs(attd1f(4,:))+KMD));
  ttc1=ttc1.*(KMT./(abs(attd1f(2:3,:))+KMT));
  attd1f(1,:)=attd1f(1,:).*(KMA./(abs(attd1f(1,:))+KMA));
  attd1f(2:3,:)=attd1f(2:3,:).*(KMT./(abs(attd1f(2:3,:))+KMT));
  attd1f(4,:)=attd1f(4,:).*(KMD./(abs(attd1f(4,:))+KMD));
elseif vers==3
  attd1(1,:)=attd1(1,:).*(KMA./(abs(attd1f(1,:))+KMA));
  attd1(4,:)=attd1(4,:).*(KMD./(abs(attd1f(4,:))+KMD));
  attd1f(1,:)=attd1f(1,:).*(KMA./(abs(attd1f(1,:))+KMA));
  attd1f(4,:)=attd1f(4,:).*(KMD./(abs(attd1f(4,:))+KMD));
end

%Adaptación sustractiva del magno
attd1(1,:)=attd1(1,:)-KSM*attd1f(1,:);
attd1f(1,:)=attd1f(1,:)-KSM*attd1f(1,:);
%¿Estas cantidades no deberian hacerse cero si el termino substractivo
%supera al aditivo?
%No linealidad oponente
attd1=attd1./(abs(attd1)+KO);
ttc1=ttc1./(abs(ttc1)+KO);
attd1f=attd1f./(abs(attd1f)+KO);
%Reescalado de la fase oponente
attd1=[RA 0 0 0;0 RLM 0 0;0 0 RML 0;0 0 0 RD]*attd1;
ttc1=[RLM 0;0 RML]*ttc1;
attd1f=[RA 0 0 0;0 RLM 0 0;0 0 RML 0;0 0 0 RD]*attd1f;
%1ª transformación lineal de 2ª etapa oponente
M2=[M211 M212 0;1 M222 0;0 0 1];
atd2(1,:)=[M211 M212]*ttc1;
atd2(2:3,:)=M2(2:3,:)*attd1(2:4,:);
atd2f=M2*attd1f(2:4,:);
%Adaptación sustractiva del parvo
atd2(1,:)=atd2(1,:)-KSA*atd2f(1,:);
%¿atd2(1,:) no deberia hacerse cero si el termino substractivo
%supera al aditivo?

atd2(2,:)=atd2(2,:)-KST*atd2f(2,:);
atd2(3,:)=atd2(3,:)-KSD*atd2f(3,:);
%2ª transformación lineal de 2ª etapa oponente
M3=[1 0 0;0 M322 M323;0 M332 M333];
atd2=M3*atd2;
%Descriptores ATTD de primera etapa oponente (LGN y umbrales):
attd1=attd1';
%Descriptores ATD perceptuales:
atd2=atd2';
