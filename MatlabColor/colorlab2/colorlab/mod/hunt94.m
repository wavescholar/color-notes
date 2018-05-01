function [H,HCR,HCY,HCG,HCB,M,s,Q,J,C,QWB,hss]=hunt94(test,white,back,prox,LA,LAS,Stw,Sbw,surr,p)

%hunt94 proporciona los descriptores de colores relacio-
%nados del modelo de apariencia de Hunt de 1994
%para una entrada que puede constar de varios tests
%con sus correspondientes condiciones de observación.
%
%INPUTS
%
%test: coordenadas cromáticas (x,y) y factor de luminan-
%cia en tantos por ciento (Y=100*L/Lwr) de los estímulos
%cromáticos cuya apariencia se quiere medir. Lwr es la
%luminancia del difusor perfecto en cd/m2, que se obtie-
%ne dividiendo por pi la iluminancia en lux.
%
%white: coordenadas cromáticas (xw,yw) y factor de lumi-
%nancia (Yw=100*Lw/Lwr) de los blancos de referencia
%bajo las mismas condiciones de observación que sus co-
%rrespondientes tests. Si se introduce [] como entrada
%se considera un blanco equienergético de Yw=100%.
%
%back: coordenadas cromáticas (xb,yb) y factor de lumi-
%nancia (Yb=100*Lb/Lwr) de los fondos (backgrounds) bajo
%las mismas condiciones de observación que sus corres-
%pondientes tests. Si se introduce [] como entrada se
%considera un fondo acromático con el factor de luminancia
%típico de Yb=20%.
%
%prox: coordenadas cromáticas y factor de luminancia de
%los campos próximos bajo las mismas condiciones de ob-
%servación que sus correspondientes tests. El campo
%próximo rodea al test unos 2º en todas direcciones, y
%el fondo rodea al campo próximo unos 10º. Si se introduce
%[] se considera un campo próximo igual al fondo.
%
%LA: Luminancia absoluta del campo adaptativo, medida
%en cd/m2. Se considera como campo adaptativo al conjun-
%to de campo próximo, fondo y alrededor. Un valor típico
%es el de LA=Lw/5.
%
%LAS: Luminancia escotópica absoluta del campo adapta-
%tivo en cd/m2 escotópicas. Una buena aproximación de
%LAS a partir de LA y de la temperatura de color T del
%iluminante viene dada por la expresión:
%    LAS=2.26*LA*((T/4000)-0.4)^(1/3)
%Para un iluminante equienergético (T=5555K) se cumple:
%    LAS=2.26*LA
%Éste es el valor introducido por defecto al teclear [].
%
%Stw: Luminancia escotópica del test relativa al blanco
%de referencia, S/Sw. Una buena aproximación en caso de
%no disponer de este valor viene dada por Y/Yw, que es
%el valor introducido por defecto al teclear [].
%
%Sbw: Luminancia escotópica del fondo relativa al blanco
%de referencia, Sb/Sw. Una buena aproximación es Yb/Yw,
%que es el valor introducido por defecto al teclear [].
%
%surr: Tipo de alrededor (surround) que rodea al fondo.
% surr=1 Tests pequeños en fondos y alrededores lumino-
%        sos uniformes.
% surr=2 Escenas normales (muestras reflectantes, colo-
%        res de superficie)
% surr=3 Televisión o dispositivos VDU con alrededores
%        tenues
% surr=4 Fotografías proyectadas sobre alrededores os-
%        curos
% surr=5 Distribución de colores adyacentes en alrededo-
%        res oscuros.
%
%p: Coeficiente que modeliza la influencia del campo
%próximo en la percepción del test, cuyo valor puede os-
%cilar en un rango contínuo entre -1, para contraste si-
%multáneo, y +1, para asimilación. Si el campo próximo
%es igual al fondo, p toma el valor 0.
%
%  test=[x1 y1 Y1;x2 y2 Y2;...;xn yn Yn]
%  white=[xw1 yw1 Yw1;xw2 yw2 Yw2;...;xwn ywn Ywn]
%  back=[xb1 yb1 Yb1;xb2 yb2 Yb2;...;xbn ybn Ybn]
%  prox=[xp1 yp1 Yp1;xp2 yp2 Yp2;...;xpn ypn Ypn]
%  LA=[LA1 LA2...LAn]
%  LAS=[LAS1 LAS2...LASn]
%  Stw=[Stw1 Stw2...Stwn]
%  Sbw=[Sbw1 Sbw2...Sbwn]
%  surr=[surr1 surr2...surrn]
%  p=[p1 p2...pn]
%
%Si se trabaja con entradas múltiples (n>1) y alguna de
%las condiciones de observación se repite en todos los
%casos, basta con escribirla una vez y el programa la re-
%plica automáticamente.
%
%OUTPUTS
%
%  H: Cuadratura de tono
%  HCR/HCY/HCG/HCB: Contribuciones de rojo, amarillo,
%                   verde y azul al tono
%  M: Colorido (fórmula mejorada de 1994)
%  s: Saturación
%  Q: Luminosidad
%  J: Claridad
%  C: Croma (fórmula mejorada de 1994)
%  QWB: Whiteness-Blackness
%
%USO: [H,HCR,HCY,HCG,HCB,M,s,Q,J,C,QWB]=hunt94(test,white,back,prox,LA,LAS,Stw,Sbw,surr,p);


%En primer lugar asignamos los valores por defecto
%independientes del número de caso:

if size(white)==[0 0]
  white=[1/3 1/3 100];
end
if size(back)==[0 0]
  back=[1/3 1/3 20];
end

%En segundo lugar determinamos el número de casos que
%vamos a calcular de golpe, para "hinchar" los inputs
%que se repitan en todos los casos, y de ese modo basta
%con introducir estos inputs constantes una sola vez,
%el programa es el que se encarga de replicarlos en
%todas las filas (test,white,back,prox) o columnas
%(LA,LAS,Stw,Sbw,surr,p) que haga falta:

sizetest=size(test);
tam(1)=sizetest(1);
sizewhit=size(white);
tam(2)=sizewhit(1);
sizeback=size(back);
tam(3)=sizeback(1);
sizeprox=size(prox);
tam(4)=sizeprox(1);
sizeLA=size(LA);
tam(5)=sizeLA(2);
sizeLAS=size(LAS);
tam(6)=sizeLAS(2);
sizeStw=size(Stw);
tam(7)=sizeStw(2);
sizeSbw=size(Sbw);
tam(8)=sizeSbw(2);
sizesurr=size(surr);
tam(9)=sizesurr(2);
sizep=size(p);
tam(10)=sizep(2);
ncasos=max(tam);

%ncasos es el número de casos que tenemos que calcular.
%A la vez que hinchamos asignamos los valores por de-
%fecto dependientes del número de caso:

if sizetest(1)==1
  test=ones(ncasos,1)*test;
end
if sizewhit(1)==1
  white=ones(ncasos,1)*white;
end
if sizeback(1)==1
  back=ones(ncasos,1)*back;
end
if sizeprox(1)==1
  prox=ones(ncasos,1)*prox;
elseif sizeprox(1)==0
  prox=back;
end
if sizeLA(2)==1
  LA=ones(1,ncasos)*LA;
end
if sizeLAS(2)==1
  LAS=ones(1,ncasos)*LAS;
elseif sizeLAS(2)==0
  LAS=2.26*LA;
end
if sizeStw(2)==1
  Stw=ones(1,ncasos)*Stw;
elseif sizeStw(2)==0
  Stw=test(:,3)./white(:,3);
  Stw=Stw';
end
if sizeSbw(2)==1
  Sbw=ones(1,ncasos)*Sbw;
elseif sizeSbw(2)==0
  Sbw=back(:,3)./white(:,3);
  Sbw=Sbw';
end
if sizesurr(2)==1
  surr=ones(1,ncasos)*surr;
end
if sizep(2)==1
  p=ones(1,ncasos)*p;
end

x=test(:,1);
y=test(:,2);
Y=test(:,3);
xw=white(:,1);
yw=white(:,2);
Yw=white(:,3);
xb=back(:,1);
yb=back(:,2);
Yb=back(:,3);
xp=prox(:,1);
yp=prox(:,2);
Yp=prox(:,3);
X=x.*Y./y;
Z=(1-x-y).*Y./y;
XYZ(:,1)=X;
XYZ(:,2)=Y;
XYZ(:,3)=Z;
XYZ=XYZ';
Xw=xw.*Yw./yw;
Zw=(1-xw-yw).*Yw./yw;
XYZw(:,1)=Xw;
XYZw(:,2)=Yw;
XYZw(:,3)=Zw;
XYZw=XYZw';
Xb=xb.*Yb./yb;
Zb=(1-xb-yb).*Yb./yb;
XYZb(:,1)=Xb;
XYZb(:,2)=Yb;
XYZb(:,3)=Zb;
XYZb=XYZb';
Xp=xp.*Yp./yp;
Zp=(1-xp-yp).*Yp./yp;
XYZp(:,1)=Xp;
XYZp(:,2)=Yp;
XYZp(:,3)=Zp;
XYZp=XYZp';

%éste es un paso lineal del proceso, y por tanto
%se puede hacer mediante productos de matrices, sin
%necesidad de bucles for.

marogabe=[0.38971 0.68898 -0.07868; -0.22981 1.18340 0.04641; 0 0 1];
rogabe=marogabe*XYZ;
rogabe=rogabe';
ro=rogabe(:,1);
ga=rogabe(:,2);
be=rogabe(:,3);
rogabew=marogabe*XYZw;
rogabew=rogabew';
row=rogabew(:,1);
gaw=rogabew(:,2);
bew=rogabew(:,3);
rogabeb=marogabe*XYZb;
rogabeb=rogabeb';
rob=rogabeb(:,1);
gab=rogabeb(:,2);
beb=rogabeb(:,3);
rogabep=marogabe*XYZp;
rogabep=rogabep';
rop=rogabep(:,1);
gap=rogabep(:,2);
bep=rogabep(:,3);

hR=20.14;hY=90.00;hG=164.25;hB=237.53;
eR=0.8;eY=0.7;eG=1.0;eB=1.2;

%los pasos no lineales se hacen con un bucle:

for i=1:ncasos;
  row(i)=row(i)*((1-p(i))*(rop(i)/rob(i))+(1+p(i))/(rop(i)/rob(i)))^(1/2)/((1+p(i))*(rop(i)/rob(i))+(1-p(i))/(rop(i)/rob(i)))^(1/2);
  gaw(i)=gaw(i)*((1-p(i))*(gap(i)/gab(i))+(1+p(i))/(gap(i)/gab(i)))^(1/2)/((1+p(i))*(gap(i)/gab(i))+(1-p(i))/(gap(i)/gab(i)))^(1/2);
  bew(i)=bew(i)*((1-p(i))*(bep(i)/beb(i))+(1+p(i))/(bep(i)/beb(i)))^(1/2)/((1+p(i))*(bep(i)/beb(i))+(1-p(i))/(bep(i)/beb(i)))^(1/2);
  k(i)=1/(5*LA(i)+1);
  FL(i)=0.2*(k(i)^4)*5*LA(i)+0.1*(1-(k(i)^4))^2*(5*LA(i))^(1/3);
  hro(i)=3*row(i)/(row(i)+gaw(i)+bew(i));
  hga(i)=3*gaw(i)/(row(i)+gaw(i)+bew(i));
  hbe(i)=3*bew(i)/(row(i)+gaw(i)+bew(i));
  Fro(i)=(1+(LA(i))^(1/3)+hro(i))/(1+(LA(i))^(1/3)+(1/hro(i)));
  Fga(i)=(1+(LA(i))^(1/3)+hga(i))/(1+(LA(i))^(1/3)+(1/hga(i)));
  Fbe(i)=(1+(LA(i))^(1/3)+hbe(i))/(1+(LA(i))^(1/3)+(1/hbe(i)));
  I1(i)=FL(i)*Fro(i)*Yb(i)/Yw(i);
  I2(i)=FL(i)*Fga(i)*Yb(i)/Yw(i);
  I3(i)=FL(i)*Fbe(i)*Yb(i)/Yw(i);
  fn1(i)=40*I1(i)^0.73/(I1(i)^0.73+2);
  fn2(i)=40*I2(i)^0.73/(I2(i)^0.73+2);
  fn3(i)=40*I3(i)^0.73/(I3(i)^0.73+2);
  roD(i)=fn2(i)-fn1(i);
  gaD(i)=0;
  beD(i)=fn2(i)-fn3(i);
  Bro(i)=1e7/(1e7+5*LA(i)*(row(i)/100));
  Bga(i)=1e7/(1e7+5*LA(i)*(gaw(i)/100));
  Bbe(i)=1e7/(1e7+5*LA(i)*(bew(i)/100));
  I4(i)=FL(i)*Fro(i)*ro(i)/row(i);
  I5(i)=FL(i)*Fga(i)*ga(i)/gaw(i);
  I6(i)=FL(i)*Fbe(i)*be(i)/bew(i);
  fn4(i)=40*I4(i)^0.73/(I4(i)^0.73+2);
  fn5(i)=40*I5(i)^0.73/(I5(i)^0.73+2);
  fn6(i)=40*I6(i)^0.73/(I6(i)^0.73+2);
  roa(i)=Bro(i)*(fn4(i)+roD(i))+1;
  gaa(i)=Bga(i)*(fn5(i)+gaD(i))+1;
  bea(i)=Bbe(i)*(fn6(i)+beD(i))+1;
  Aa(i)=2*roa(i)+gaa(i)+bea(i)/20-3.05+1;
  C1(i)=roa(i)-gaa(i);
  C2(i)=gaa(i)-bea(i);
  C3(i)=bea(i)-roa(i);
  t(i)=0.5*(C2(i)-C3(i))/4.5;
  tp(i)=C1(i)-(C2(i)/11);

%t(i) y tp(i) (la p es de prima) son respectivamente
%las coordenadas y, x del punto asociado a nuestro
%estímulo cromático. Queremos calcular el ángulo que
%forma respecto del eje positivo de las abscisas:

  hs(i)=atan2(t(i),tp(i));

%pasamos los radianes a grados:

  hs(i)=180*hs(i)/pi;
  hss(i)=hs(i)+360*(hs(i)<0);
%y a continuación tomamos nuestro intervalo de ángulos 
%no entre -180 y 180, sino desde el rojo único (20.14
%grados) hasta dar una vuelta completa:

  hs(i)=hs(i)+360*(hs(i)<20.14);

%tanto la HP como la es de nuestros estímulos las
%calcularemos interpolando entre los valores
%asociados a los tonos únicos. Dependiendo de la zona
%en la que nos encontremos, tendremos cuatro casos
%posibles.
%Los subíndices 1 y 2 indican cuáles son los extremos
%entre los que se interpola linealmente:

  if hR<=hs(i) & hs(i)<hY     h1(i)=hR;h2(i)=hY;e1(i)=eR;e2(i)=eY;H1(i)=0;
                              HP(i)=100*((hs(i)-h1(i))/e1(i))/((hs(i)-h1(i))/e1(i)+(h2(i)-hs(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=100-HP(i);HCY(i)=HP(i);HCG(i)=0;HCB(i)=0;
  elseif hY<=hs(i) & hs(i)<hG h1(i)=hY;h2(i)=hG;e1(i)=eY;e2(i)=eG;H1(i)=100;
                              HP(i)=100*((hs(i)-h1(i))/e1(i))/((hs(i)-h1(i))/e1(i)+(h2(i)-hs(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=0;HCY(i)=100-HP(i);HCG(i)=HP(i);HCB(i)=0;
  elseif hG<=hs(i) & hs(i)<hB h1(i)=hG;h2(i)=hB;e1(i)=eG;e2(i)=eB;H1(i)=200;
                              HP(i)=100*((hs(i)-h1(i))/e1(i))/((hs(i)-h1(i))/e1(i)+(h2(i)-hs(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=0;HCY(i)=0;HCG(i)=100-HP(i);HCB(i)=HP(i);
  else                        h1(i)=hB;h2(i)=hR+360;e1(i)=eB;e2(i)=eR;H1(i)=300;
                              HP(i)=100*((hs(i)-h1(i))/e1(i))/((hs(i)-h1(i))/e1(i)+(h2(i)-hs(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=HP(i);HCY(i)=0;HCG(i)=0;HCB(i)=100-HP(i);
  end
  es(i)=e1(i)+(e2(i)-e1(i))*(hs(i)-h1(i))/(h2(i)-h1(i));
  Ft(i)=LA(i)/(LA(i)+0.1);

%Factores de inducción del fondo:
%Nbb: de luminosidad
%Ncb: cromático

  Nbb(i)=0.725*(Yw(i)/Yb(i))^0.2;
  Ncb(i)=Nbb(i);

%Factores de inducción del alrededor:
%Nb: de luminosidad
%Nc: cromático

  if surr(i)==1 Nc(i)=1;Nb(i)=300;
  elseif surr(i)==2 Nc(i)=1;Nb(i)=75;
  elseif surr(i)==3 Nc(i)=.95;Nb(i)=25;
  elseif surr(i)==4 Nc(i)=.9;Nb(i)=10;
  elseif surr(i)==5 Nc(i)=.75;Nb(i)=5;
  end

  MYB(i)=100*t(i)*es(i)*(10/13)*Nc(i)*Ncb(i)*Ft(i);
  MRG(i)=100*tp(i)*es(i)*(10/13)*Nc(i)*Ncb(i);

%El colorido de hunt91 pasa a llamarse ahora respuesta
%cromática:

  M91(i)=sqrt(MYB(i)^2+MRG(i)^2);
  mYB(i)=MYB(i)/(roa(i)+gaa(i)+bea(i));
  mRG(i)=MRG(i)/(roa(i)+gaa(i)+bea(i));
  s(i)=50*M91(i)/(roa(i)+gaa(i)+bea(i));
  j(i)=0.00001/((5*LAS(i)/2.26)+0.00001);
  FLS(i)=3800*j(i)^2*(5*LAS(i)/2.26)+0.2*(1-j(i)^2)^4*(5*LAS(i)/2.26)^(1/6);
  BS(i)=0.5/(1+0.3*((5*LAS(i)/2.26)*Stw(i))^(0.3))+0.5/(1+5*(5*LAS(i)/2.26));
  I7(i)=FLS(i)*Stw(i);
  fn7(i)=40*I7(i)^0.73/(I7(i)^0.73+2);
  As(i)=BS(i)*3.05*fn7(i)+0.3;
%  A(i)=Nbb(i)*(Aa(i)-1+As(i)-0.3+(1^2+0.3^2)^(1/2));
  A(i)=Nbb(i)*(Aa(i)+As(i)-0.256);

%Calculamos Aw, que es la A para el blanco:

  I4w(i)=FL(i)*Fro(i);
  I5w(i)=FL(i)*Fga(i);
  I6w(i)=FL(i)*Fbe(i);
  fn4w(i)=40*I4w(i)^0.73/(I4w(i)^0.73+2);
  fn5w(i)=40*I5w(i)^0.73/(I5w(i)^0.73+2);
  fn6w(i)=40*I6w(i)^0.73/(I6w(i)^0.73+2);
  roaw(i)=Bro(i)*(fn4w(i)+roD(i))+1;
  gaaw(i)=Bga(i)*(fn5w(i)+gaD(i))+1;
  beaw(i)=Bbe(i)*(fn6w(i)+beD(i))+1;
  Aaw(i)=2*roaw(i)+gaaw(i)+beaw(i)/20-3.05+1;
  C1w(i)=roaw(i)-gaaw(i);
  C2w(i)=gaaw(i)-beaw(i);
  C3w(i)=beaw(i)-roaw(i);
  tw(i)=0.5*(C2w(i)-C3w(i))/4.5;
  tpw(i)=C1w(i)-(C2w(i)/11);
  hsw(i)=atan2(tw(i),tpw(i));
  hsw(i)=180*hsw(i)/pi;
  hsw(i)=hsw(i)+360*(hsw(i)<20.14);
  if hR<=hsw(i) & hsw(i)<hY h1w(i)=hR;h2w(i)=hY;e1w(i)=eR;e2w(i)=eY;
  elseif hY<=hsw(i) & hsw(i)<hG h1w(i)=hY;h2w(i)=hG;e1w(i)=eY;e2w(i)=eG;
  elseif hG<=hsw(i) & hsw(i)<hB h1w(i)=hG;h2w(i)=hB;e1w(i)=eG;e2w(i)=eB;
  else h1w(i)=hB;h2w(i)=hR+360;e1w(i)=eB;e2w(i)=eR;
  end
  esw(i)=e1w(i)+(e2w(i)-e1w(i))*(hsw(i)-h1w(i))/(h2w(i)-h1w(i));
  MYBw(i)=100*tw(i)*esw(i)*(10/13)*Nc(i)*Ncb(i)*Ft(i);
  MRGw(i)=100*tpw(i)*esw(i)*(10/13)*Nc(i)*Ncb(i);
  M91w(i)=sqrt(MYBw(i)^2+MRGw(i)^2);
  BSw(i)=0.5/(1+0.3*(5*LAS(i)/2.26)^(0.3))+0.5/(1+5*(5*LAS(i)/2.26));
  fn7w(i)=40*FLS(i)^0.73/(FLS(i)^0.73+2);
  Asw(i)=BSw(i)*3.05*fn7w(i)+0.3;
  Aw(i)=Nbb(i)*(Aaw(i)+Asw(i)-0.256);

%Calculamos Q

  N1(i)=(7*Aw(i))^0.5/(5.33*Nb(i)^0.13);
  N2(i)=7*Aw(i)*Nb(i)^0.362/200;
  Q(i)=(7*(A(i)+M91(i)/100))^0.6*N1(i)-N2(i);
  Qw(i)=(7*(Aw(i)+M91w(i)/100))^0.6*N1(i)-N2(i);
  z(i)=1+(Yb(i)/Yw(i))^(1/2);
  J(i)=100*(Q(i)/Qw(i))^z(i);

%Fórmula mejorada para el croma de 1994:

  C(i)=2.44*s(i)^0.69*(Q(i)/Qw(i))^(Yb(i)/Yw(i))*(1.64-0.29^(Yb(i)/Yw(i)));

%Fórmula mejorada para el colorido de 1994:

  M(i)=FL(i)^0.15*C(i);

%Calculamos Qb

  I4b(i)=FL(i)*Fro(i)*rob(i)/row(i);
  I5b(i)=FL(i)*Fga(i)*gab(i)/gaw(i);
  I6b(i)=FL(i)*Fbe(i)*beb(i)/bew(i);
  fn4b(i)=40*I4b(i)^0.73/(I4b(i)^0.73+2);
  fn5b(i)=40*I5b(i)^0.73/(I5b(i)^0.73+2);
  fn6b(i)=40*I6b(i)^0.73/(I6b(i)^0.73+2);
  roab(i)=Bro(i)*(fn4b(i)+roD(i))+1;
  gaab(i)=Bga(i)*(fn5b(i)+gaD(i))+1;
  beab(i)=Bbe(i)*(fn6b(i)+beD(i))+1;
  Aab(i)=2*roab(i)+gaab(i)+beab(i)/20-3.05+1;
  C1b(i)=roab(i)-gaab(i);
  C2b(i)=gaab(i)-beab(i);
  C3b(i)=beab(i)-roab(i);
  tb(i)=0.5*(C2b(i)-C3b(i))/4.5;
  tpb(i)=C1b(i)-(C2b(i)/11);
  hsb(i)=atan2(tb(i),tpb(i));
  hsb(i)=180*hsb(i)/pi;
  hsb(i)=hsb(i)+360*(hsb(i)<20.14);
  if hR<=hsb(i) & hsb(i)<hY h1b(i)=hR;h2b(i)=hY;e1b(i)=eR;e2b(i)=eY;
  elseif hY<=hsb(i) & hsb(i)<hG h1b(i)=hY;h2b(i)=hG;e1b(i)=eY;e2b(i)=eG;
  elseif hG<=hsb(i) & hsb(i)<hB h1b(i)=hG;h2b(i)=hB;e1b(i)=eG;e2b(i)=eB;
  else h1b(i)=hB;h2b(i)=hR+360;e1b(i)=eB;e2b(i)=eR;
  end
  esb(i)=e1b(i)+(e2b(i)-e1b(i))*(hsb(i)-h1b(i))/(h2b(i)-h1b(i));
  MYBb(i)=100*tb(i)*esb(i)*(10/13)*Nc(i)*Ncb(i)*Ft(i);
  MRGb(i)=100*tpb(i)*esb(i)*(10/13)*Nc(i)*Ncb(i);
  M91b(i)=sqrt(MYBb(i)^2+MRGb(i)^2);
  BSb(i)=0.5/(1+0.3*((5*LAS(i)/2.26)*Sbw(i))^(0.3))+0.5/(1+5*(5*LAS(i)/2.26));
  I7b(i)=FLS(i)*Sbw(i);
  fn7b(i)=40*I7b(i)^0.73/(I7b(i)^0.73+2);
  Asb(i)=BSb(i)*3.05*fn7b(i)+0.3;
  Ab(i)=Nbb(i)*(Aab(i)+Asb(i)-0.256);
  Qb(i)=(7*(Ab(i)+M91b(i)/100))^0.6*N1(i)-N2(i);

%Calculamos QWB

  QWB(i)=20*(Q(i)^0.7-Qb(i)^0.7);
end

H=H';
HCR=HCR';
HCY=HCY';
HCG=HCG';
HCB=HCB';
M=M';
s=s';
Q=Q';
J=J';
C=C';
QWB=QWB';
