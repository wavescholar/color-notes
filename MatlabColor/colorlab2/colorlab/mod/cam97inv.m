function xyY=cam97inv(test,rel,white,back,LA,surr,adap)


%CAM97INV inverts the CIECAM97 model.
%
% SYNTAX
% ----------------------------------------------------------------------------
% xyY=CIECAM97INV(TEST,REL,xyYW,xyYB,YA,VIEW,ADAP)
%
% TEST =  For N colours, Nx3 matrix containing the descriptors indicated by REL.
%
% REL  =  If REL=0, the tests are described by their brigthness (Q), their
%         colourfulness(M) and their hue quadrature (H). These descriptors
%         are valid both for related and unrelated colour:
%                  TEST=[Q1 M1 H1;Q2 M2 H2;Q3 M3 H3;...]
%         If REL=1, the descriptors of related stimuli must be used (i.e.,
%         lightness, J, chroma C and hue quadrature, H).
%                  TEST=[J1 C1 H1;J2 C2 H2;J3 C3 H3;...]
%
% xyYW =  Chromaticity coordinates and the luminance factor of the reference white.
%         Either a single white for all stimuli, or a different white for each
%         stimulus may be introduced.
%
% xyYB =  Chromaticity coordinates and the luminance factor of the background.
%         Either a single background for all stimuli, or a different background for
%         each stimulus may be introduced.
%
% YA   =  Luminances of the adapting fields. If the same value holds for all stimuli,
%         this variable is a single number. 
%         Normally, this value equals 20% of the luminance of the white in the adapting
%         field). 
%
% VIEW describes the viewing conditions, determining certain constants in the model:
%
%         VIEW=1  Average surround with samples > 4º.
%         VIEW=2  Average surround with samples < 4º.
%         VIEW=3  Dim surround.
%         VIEW=4  Dark surround.
%         VIEW=5  Cut-sheet transparencies.
%
%         A surround with luminance factor above 20% is considered 
%         "average". If the luminance factor is below 20% is dim,
%         and when near zero is dark.
%
% ADAP describes the degree of chromatic adaptation.
%
%         ADAP=1  There is no chromatic adaptation.
%         ADAP=2  Normal level of chromatic adaptation.
%         ADAP=3  Strong chromatic adaptation
%                 (the illuminant is partially discounted)
%         ADAP=4  Total chromatic adaptation
%                 (the illuminant is totally discounted)
%
%  xyY  =  Nx3 matrix with the chromaticity coordinates and
%         the luminance factor of the test stimuli.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% CIECAM97


%
%USO:  xyY=cam97inv(test,rel,white,back,LA,surr,adap);


%En primer lugar determinamos el número de casos que
%vamos a calcular de golpe, para "hinchar" los inputs
%que se repitan en todos los casos, y de ese modo basta
%con introducir estos inputs constantes una sola vez,
%el programa es el que se encarga de replicarlos en
%todas las filas (test, white, back) o columnas (LA,
%surr, adap) que haga falta:
sizetest=size(test);
tam(1)=sizetest(1);
sizewhit=size(white);
tam(2)=sizewhit(1);
sizeback=size(back);
tam(3)=sizeback(1);
sizeLA=size(LA);
tam(4)=sizeLA(2);
sizesurr=size(surr);
tam(5)=sizesurr(2);
sizeadap=size(adap);
tam(6)=sizeadap(2);
ncasos=max(tam);
%ncasos es el número de casos que tenemos que calcular.
if ncasos>1
  if sizetest(1)==1
    test=ones(ncasos,1)*test;
  end
  if sizewhit(1)==1
    white=ones(ncasos,1)*white;
  end
  if sizeback(1)==1
    back=ones(ncasos,1)*back;
  end
  if sizeLA(2)==1
    LA=ones(1,ncasos)*LA;
  end
  if sizesurr(2)==1
    surr=ones(1,ncasos)*surr;
  end
  if sizeadap(2)==1
    adap=ones(1,ncasos)*adap;
  end
end
xw=white(:,1);
yw=white(:,2);
Yw=white(:,3);
xb=back(:,1);
yb=back(:,2);
Yb=back(:,3);
%Las coordenadas del blanco de referencia visto en las
%condiciones de observación estándar son:
xwr=1/3;
ywr=1/3;
Ywr=100;

%A partir de las coordenadas cromáticas calculamos los
%valores triestímulo normalizados para la referencia,
%para el fondo y para la referencia observada en
%condiciones estándar:
oo=ones(ncasos,1);
Xw=xw.*Yw./yw;
Zw=(oo-xw-yw).*Yw./yw;
normw(:,1)=Xw./Yw;
normw(:,2)=Yw./Yw;
normw(:,3)=Zw./Yw;
normw=normw';
MBFD=[.8951 .2664 -.1614;-.7502 1.7135 .0367;.0389 -.0685 1.0296];
RGBw=MBFD*normw;
RGBw=RGBw';
Rw=RGBw(:,1);
Gw=RGBw(:,2);
Bw=RGBw(:,3);
Xb=xb.*Yb./yb;
Zb=(oo-xb-yb).*Yb./yb;
normb(:,1)=Xb./Yb;
normb(:,2)=Yb./Yb;
normb(:,3)=Zb./Yb;
normb=normb';
RGBb=MBFD*normb;
RGBb=RGBb';
Rb=RGBb(:,1);
Gb=RGBb(:,2);
Bb=RGBb(:,3);
Xwr=xwr*Ywr/ywr;
Zwr=(1-xwr-ywr)*Ywr/ywr;
normwr(1,1)=Xwr/Ywr;
normwr(1,2)=Ywr/Ywr;
normwr(1,3)=Zwr/Ywr;
normwr=normwr';
RGBwr=MBFD*normwr;
Rwr=RGBwr(1,1);
Gwr=RGBwr(2,1);
Bwr=RGBwr(3,1);

%Los pasos no lineales se hacen con un bucle.
%Determinamos el valor numérico de algunas de las
%constantes dependiendo del surround:
for i=1:ncasos
  if surr(i)==1     F(i)=1;c(i)=0.69;FLL(i)=0;Nc(i)=1;
  elseif surr(i)==2 F(i)=1;c(i)=0.69;FLL(i)=1;Nc(i)=1;
  elseif surr(i)==3 F(i)=0.9;c(i)=0.59;FLL(i)=1;Nc(i)=1.1;
  elseif surr(i)==4 F(i)=0.9;c(i)=0.525;FLL(i)=1;Nc(i)=0.8;
  elseif surr(i)==5 F(i)=0.9;c(i)=0.41;FLL(i)=1;Nc(i)=0.8;
  end

%Calculamos el grado de adaptación cromática D:
  if adap(i)==1     D(i)=0;
  elseif adap(i)==2 D(i)=F(i)-F(i)/(1+2*LA(i)^(1/4)+LA(i)^2/300);
  elseif adap(i)==3 D(i)=0.5*(1+F(i)-F(i)/(1+2*LA(i)^(1/4)+LA(i)^2/300));
  elseif adap(i)==4 D(i)=1;
  end

%Calculamos los valores triestímulo correspondientes
%a la referencia y al fondo observados en las condiciones
%de referencia:
  p(i)=(Bw(i)/Bwr)^0.0834;
  Rwc(i)=(D(i)*(Rwr/Rw(i))+1-D(i))*Rw(i);
  Gwc(i)=(D(i)*(Gwr/Gw(i))+1-D(i))*Gw(i);
  Bwc(i)=sign(Bw(i))*(D(i)*(Bwr/(Bw(i))^p(i))+1-D(i))*(sign(Bw(i))*Bw(i))^p(i);
  Rbc(i)=(D(i)*(Rwr/Rw(i))+1-D(i))*Rb(i);
  Gbc(i)=(D(i)*(Gwr/Gw(i))+1-D(i))*Gb(i);
  Bbc(i)=sign(Bb(i))*(D(i)*(Bwr/(Bw(i))^p(i))+1-D(i))*(sign(Bb(i))*Bb(i))^p(i);
end

%Los pasos siguientes son lineales, y por tanto se
%pueden hacer mediante productos de matrices, sin
%necesidad de bucles for.
%La matriz inversa de MBFD es:
MBFDi=[.98699 -.14705 .15996;.43231 .51836 .04929;-.00853 .04004 .96849];
Rwc=Rwc';
Gwc=Gwc';
Bwc=Bwc';
normiw(:,1)=Rwc.*Yw;
normiw(:,2)=Gwc.*Yw;
normiw(:,3)=Bwc.*Yw;
normiw=normiw';
XYZwc=MBFDi*normiw;
Xwc=XYZwc(1,:);
Ywc=XYZwc(2,:);
Zwc=XYZwc(3,:);
MH=[.38971 .68898 -.07868; -.22981 1.18340 .04641; 0 0 1];
rogabew=MH*XYZwc;
rogabew=rogabew';
row=rogabew(:,1);
gaw=rogabew(:,2);
bew=rogabew(:,3);

for i=1:ncasos
  Ybc(i)=(0.43231*Rbc(i)+0.51836*Gbc(i)+0.04929*Bbc(i))*Yb(i);
  Ywc(i)=(0.43231*Rwc(i)+0.51836*Gwc(i)+0.04929*Bwc(i))*Yw(i);
  n(i)=Ybc(i)/Ywc(i);
  k(i)=1/(5*LA(i)+1);
  FL(i)=0.2*(k(i)^4)*5*LA(i)+0.1*(1-(k(i)^4))^2*(5*LA(i))^(1/3);
  I1w(i)=sign(row(i))*FL(i)*row(i)/100;
  I2w(i)=sign(gaw(i))*FL(i)*gaw(i)/100;
  I3w(i)=sign(bew(i))*FL(i)*bew(i)/100;
  roaw(i)=(sign(row(i))*40*I1w(i)^0.73/(I1w(i)^0.73+2))+1;
  gaaw(i)=(sign(gaw(i))*40*I2w(i)^0.73/(I2w(i)^0.73+2))+1;
  beaw(i)=(sign(bew(i))*40*I3w(i)^0.73/(I3w(i)^0.73+2))+1;
  Nbb(i)=0.725/n(i)^0.2;
  Ncb(i)=0.725/n(i)^0.2;
  z(i)=1+FLL(i)*n(i)^(1/2);
  Aw(i)=(2*roaw(i)+gaaw(i)+beaw(i)/20-2.05)*Nbb(i);
end

%Partiendo de QMH o JCH aplicamos a la inversa los pasos
%del modelo para obtener xyY:
H=test(:,3);
if rel==0
  Q=test(:,1);
  M=test(:,2);
  for i=1:ncasos
    J(i)=100*(Q(i)*c(i)/1.24)^(1/0.67)/(Aw(i)+3)^(0.9/0.67);
    C(i)=M(i)/FL(i)^0.15;
  end
elseif rel==1
  J=test(:,1);
  C=test(:,2);
end
for i=1:ncasos
  A(i)=(J(i)/100)^(1/(c(i)*z(i)))*Aw(i);
%Los valores asociados a los tonos únicos son:
  hR=20.14;hY=90.00;hG=164.25;hB=237.53;
  eR=0.8;eY=0.7;eG=1.0;eB=1.2; 
%Dependiendo de la cuadratura de tono averiguaremos en
%cuál de las cuatro zonas se encuentra nuestro estímulo.
  if 0<=H(i) & H(i)<100       h1(i)=hR;h2(i)=hY;e1(i)=eR;e2(i)=eY;H1(i)=0;
  elseif 100<=H(i) & H(i)<200 h1(i)=hY;h2(i)=hG;e1(i)=eY;e2(i)=eG;H1(i)=100;
  elseif 200<=H(i) & H(i)<300 h1(i)=hG;h2(i)=hB;e1(i)=eG;e2(i)=eB;H1(i)=200;
  else                        h1(i)=hB;h2(i)=hR+360;e1(i)=eB;e2(i)=eR;H1(i)=300;
  end
  h(i)=((H(i)-H1(i))*(h1(i)/e1(i)-h2(i)/e2(i))-100*h1(i)/e1(i))/((H(i)-H1(i))*(1/e1(i)-1/e2(i))-100/e1(i));
  e(i)=e1(i)+(e2(i)-e1(i))*(h(i)-h1(i))/(h2(i)-h1(i));
%Calculamos la saturación:
  s(i)=C(i)^(1/0.69)/(2.44*(J(i)/100)^(0.67*n(i))*(1.64-0.29^n(i)))^(1/0.69);
%h se mide en grados, pero vamos a pasarla a radianes
%multiplicando por pi/180 para poder usar las funciones
%trigonométricas de matlab:
  a(i)=s(i)*(A(i)/Nbb(i)+2.05)/(sign(cos(pi*h(i)/180))*(1+(tan(pi*h(i)/180))^2)^(1/2)*(50000*e(i)*Nc(i)*Ncb(i)/13)+s(i)*((11/23)+(108/23)*(tan(pi*h(i)/180))));
  b(i)=a(i)*tan(pi*h(i)/180);
%a(i) se puede asociar al contenido de rojo-verde.
%b(i) se puede asociar al contenido de amarillo-azul.
  roa(i)=(20/61)*(A(i)/Nbb(i)+2.05)+(41/61)*(11/23)*a(i)+(288/61)*(1/23)*b(i);
  gaa(i)=(20/61)*(A(i)/Nbb(i)+2.05)-(81/61)*(11/23)*a(i)-(261/61)*(1/23)*b(i);
  bea(i)=(20/61)*(A(i)/Nbb(i)+2.05)-(20/61)*(11/23)*a(i)-(20/61)*(315/23)*b(i);
  if roa(i)<1 ro(i)=-100*((2-2*roa(i))/(39+roa(i)))^(1/0.73)/FL(i);
  else        ro(i)=100*((2*roa(i)-2)/(41-roa(i)))^(1/0.73)/FL(i);
  end
  if gaa(i)<1 ga(i)=-100*((2-2*gaa(i))/(39+gaa(i)))^(1/0.73)/FL(i);
  else        ga(i)=100*((2*gaa(i)-2)/(41-gaa(i)))^(1/0.73)/FL(i);
  end
  if bea(i)<1 be(i)=-100*((2-2*bea(i))/(39+bea(i)))^(1/0.73)/FL(i);
  else        be(i)=100*((2*bea(i)-2)/(41-bea(i)))^(1/0.73)/FL(i);
  end
end

MHi=[1.91019 -1.11214 .20195;.37095 .62905 0;0 0 1];
rogabe(1,:)=ro;
rogabe(2,:)=ga;
rogabe(3,:)=be;
RGBcY=MBFD*MHi*rogabe;
Yc=[.43231 .51836 .04929]*RGBcY;
RGBcY=RGBcY';
Yc=Yc';
RcY=RGBcY(:,1);
GcY=RGBcY(:,2);
BcY=RGBcY(:,3);

for i=1:ncasos
  YYcR(i)=RcY(i)/(Yc(i)*(D(i)*Rwr/Rw(i)+1-D(i)));
  YYcG(i)=GcY(i)/(Yc(i)*(D(i)*Gwr/Gw(i)+1-D(i)));
  YYcpB(i)=sign(BcY(i)/Yc(i))*(sign(BcY(i))*BcY(i))^(1/p(i))/((sign(Yc(i))*Yc(i))^(1/p(i))*(D(i)*Bwr/Bw(i)^p(i)+1-D(i))^(1/p(i)));
  Yp(i)=0.43231*YYcR(i)*Yc(i)+0.51836*YYcG(i)*Yc(i)+0.04929*YYcpB(i)*Yc(i);
%Yp (Y prima) difiere de Y en una cantidad pequeña,
%pero en primera aproximación se puede considerar que
%son iguales.
  fac(i)=(Yp(i)/Yc(i))^(1/p(i)-1);
  fact(i)=YYcpB(i)/fac(i);
end

mat(1,:)=YYcR;
mat(2,:)=YYcG;
mat(3,:)=fact;
MBFDi=[.98699 -.14705 .15996;.43231 .51836 .04929;-.00853 .04004 .96849];
XYZspYc=MBFDi*mat;
XspYc=(XYZspYc(1,:))';
YspYc=(XYZspYc(2,:))';
ZspYc=(XYZspYc(3,:))';
Xsp=XspYc.*Yc;
Ysp=YspYc.*Yc;
Zsp=ZspYc.*Yc;
%Los X,Y,Z segunda prima son, con buena aproximación,
%iguales a los valores triestímulo que buscamos.
XYZsp(:,1)=Xsp;
XYZsp(:,2)=Ysp;
XYZsp(:,3)=Zsp;
%Finalmente calculamos las coordenadas cromáticas:
xyY=tri2coor(XYZsp,[0 1 0]);
ans=xyY;
