function [h,H,HCR,HCY,HCG,HCB,J,Q,s,C,M]=ciecam97(test,white,back,LA,surr,adap)

% CIECAM97 computes the hue (h), the hue quadrature (H), the contributions
% of red, yellow, green and blue to the hue, HC, the lightness,J, the brightness,
% Q, the saturation, s, the chroma, C and the colourfulness, M, of a set of stimuli
% with CIECAM97. The input may comprise different stimuli, each with its own
% observation conditions. The backgrounds (B) cover completely a 10deg-field around
% the test and is embedded in the surround. Both fields constitute the adapting
% field. Different adaptation degrees can be considered (ADAP).
%
% SYNTAX
% ----------------------------------------------------------------------------
% [h,H,HCR,HCY,HCG,HCB,J,Q,s,C,M]=CIECAM97(xyY,xyYW,xyYB,YA,VIEW,ADAP);
%
% xyY  =  Nx3 matrix with the chromaticity coordinates and
%         the luminance factor of the test stimuli.
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
% [h,H,HCR,HCY,HCG,HCB,J,Q,s,C,M] = CIECAM97 descriptors. See above.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% CAM97INV


%USO:  [h,H,HCR,HCY,HCG,HCB,J,Q,s,C,M]=ciecam97(test,white,back,LA,surr,adap);


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
x=test(:,1);
y=test(:,2);
Y=test(:,3);
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

%Determinamos el valor numérico de algunas de las
%constantes dependiendo del surround:
  for i=1:ncasos;
    if surr(i)==1     F(i)=1;c(i)=0.69;FLL(i)=0;Nc(i)=1;
    elseif surr(i)==2 F(i)=1;c(i)=0.69;FLL(i)=1;Nc(i)=1;
    elseif surr(i)==3 F(i)=0.9;c(i)=0.59;FLL(i)=1;Nc(i)=1.1;
    elseif surr(i)==4 F(i)=0.9;c(i)=0.525;FLL(i)=1;Nc(i)=0.8;
    elseif surr(i)==5 F(i)=0.9;c(i)=0.41;FLL(i)=1;Nc(i)=0.8;
    end;
  end;

%A partir de las coordenadas cromáticas calculamos los
%valores triestímulo normalizados:
oo=ones(ncasos,1);
X=x.*Y./y;
Z=(oo-x-y).*Y./y;
norm(:,1)=X./Y;
norm(:,2)=Y./Y;
norm(:,3)=Z./Y;
norm=norm';
%La matriz de cambio de base a RGB es:
MBFD=[.8951 .2664 -.1614;-.7502 1.7135 .0367;.0389 -.0685 1.0296];
RGB=MBFD*norm;
RGB=RGB';
R=RGB(:,1);
G=RGB(:,2);
B=RGB(:,3);
%Repetimos el proceso para la referencia, para el fondo
%y para la referencia observada en condiciones estándar:
Xw=xw.*Yw./yw;
Zw=(oo-xw-yw).*Yw./yw;
normw(:,1)=Xw./Yw;
normw(:,2)=Yw./Yw;
normw(:,3)=Zw./Yw;
normw=normw';
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

%Calculamos el grado de adaptación cromática D:
  for i=1:ncasos;
    if adap(i)==1     D(i)=0;
    elseif adap(i)==2 D(i)=F(i)-F(i)/(1+2*LA(i)^(1/4)+LA(i)^2/300);
    elseif adap(i)==3 D(i)=0.5*(1+F(i)-F(i)/(1+2*LA(i)^(1/4)+LA(i)^2/300));
    elseif adap(i)==4 D(i)=1;
    end;
%Calculamos los valores triestímulo correspondientes
%(Rc Gc Bc) para la muestra observada en las condiciones
%de referencia:
  p(i)=(Bw(i)/Bwr)^0.0834;
  Rc(i)=(D(i)*(Rwr/Rw(i))+1-D(i))*R(i);
  Gc(i)=(D(i)*(Gwr/Gw(i))+1-D(i))*G(i);
  Bc(i)=sign(B(i))*(D(i)*(Bwr/(Bw(i))^p(i))+1-D(i))*(sign(B(i))*B(i))^p(i);
%Lo mismo para la referencia y el fondo:
  Rwc(i)=(D(i)*(Rwr/Rw(i))+1-D(i))*Rw(i);
  Gwc(i)=(D(i)*(Gwr/Gw(i))+1-D(i))*Gw(i);
  Bwc(i)=sign(Bw(i))*(D(i)*(Bwr/(Bw(i))^p(i))+1-D(i))*(sign(Bw(i))*Bw(i))^p(i);
  Rbc(i)=(D(i)*(Rwr/Rw(i))+1-D(i))*Rb(i);
  Gbc(i)=(D(i)*(Gwr/Gw(i))+1-D(i))*Gb(i);
  Bbc(i)=sign(Bb(i))*(D(i)*(Bwr/(Bw(i))^p(i))+1-D(i))*(sign(Bb(i))*Bb(i))^p(i);
  end;

%Los pasos siguientes son lineales, y por tanto se
%pueden hacer mediante productos de matrices, sin
%necesidad de bucles for.
%Ahora hacemos la transformación inversa para obtener
%(Xc Yc Zc):
Rc=Rc';
Gc=Gc';
Bc=Bc';
normi(:,1)=Rc.*Y;
normi(:,2)=Gc.*Y;
normi(:,3)=Bc.*Y;
normi=normi';
%La matriz inversa de MBFD es:
MBFDi=[.98699 -.14705 .15996;.43231 .51836 .04929;-.00853 .04004 .96849];
XYZc=MBFDi*normi;
Xc=XYZc(1,:);
Yc=XYZc(2,:);
Zc=XYZc(3,:);
%Lo mismo para la referencia:
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

rogabe=[.38971 .68898 -.07868; -.22981 1.18340 .04641; 0 0 1]*XYZc;
rogabew=[.38971 .68898 -.07868; -.22981 1.18340 .04641; 0 0 1]*XYZwc;
rogabe=rogabe';rogabew=rogabew';
ro=rogabe(:,1);
ga=rogabe(:,2);
be=rogabe(:,3);
row=rogabew(:,1);
gaw=rogabew(:,2);
bew=rogabew(:,3);

%los pasos no lineales se hacen con un bucle:
  for i=1:ncasos;
  Ybc(i)=(0.43231*Rbc(i)+0.51836*Gbc(i)+0.04929*Bbc(i))*Yb(i);
  Ywc(i)=(0.43231*Rwc(i)+0.51836*Gwc(i)+0.04929*Bwc(i))*Yw(i);
  n(i)=Ybc(i)/Ywc(i);
  Nbb(i)=0.725/n(i)^0.2;
  Ncb(i)=0.725/n(i)^0.2;
  k(i)=1/(5*LA(i)+1);
  FL(i)=0.2*(k(i)^4)*5*LA(i)+0.1*(1-(k(i)^4))^2*(5*LA(i))^(1/3);
  I1(i)=sign(ro(i))*FL(i)*ro(i)/100;
  I2(i)=sign(ga(i))*FL(i)*ga(i)/100;
  I3(i)=sign(be(i))*FL(i)*be(i)/100;
  roa(i)=(sign(ro(i))*40*I1(i)^0.73/(I1(i)^0.73+2))+1;
  gaa(i)=(sign(ga(i))*40*I2(i)^0.73/(I2(i)^0.73+2))+1;
  bea(i)=(sign(be(i))*40*I3(i)^0.73/(I3(i)^0.73+2))+1;
  I1w(i)=sign(row(i))*FL(i)*row(i)/100;
  I2w(i)=sign(gaw(i))*FL(i)*gaw(i)/100;
  I3w(i)=sign(bew(i))*FL(i)*bew(i)/100;
  roaw(i)=(sign(row(i))*40*I1w(i)^0.73/(I1w(i)^0.73+2))+1;
  gaaw(i)=(sign(gaw(i))*40*I2w(i)^0.73/(I2w(i)^0.73+2))+1;
  beaw(i)=(sign(bew(i))*40*I3w(i)^0.73/(I3w(i)^0.73+2))+1;
  C1(i)=roa(i)-gaa(i);
  C2(i)=gaa(i)-bea(i);
  C3(i)=bea(i)-roa(i);
  b(i)=0.5*(C2(i)-C3(i))/4.5;
  a(i)=C1(i)-(C2(i)/11);
%a(i) se puede asociar al contenido de rojo-verde.
%b(i) se puede asociar al contenido de amarillo-azul.
%b(i) y a(i) son respectivamente las 
%coordenadas y, x del punto asociado a nuestro estímulo 
%cromático. Queremos calcular el ángulo que forma
%respecto del eje positivo de las abscisas:
  h(i)=atan2(b(i),a(i));
%pasamos los radianes a grados:
  h(i)=180*h(i)/pi;
%y a continuación tomamos nuestro intervalo de ángulos 
%no entre -180 y 180, sino desde el rojo único
%(20.14 grados) hasta dar una vuelta completa:
  h(i)=h(i)+360*(+(h(i)<20.14));
  hR=20.14;hY=90.00;hG=164.25;hB=237.53;
  eR=0.8;eY=0.7;eG=1.0;eB=1.2;
%tanto la HP como la e de nuestros estímulos las
%calcularemos interpolando entre estos valores asociados
%a los tonos únicos. Dependiendo de la zona en la que
%nos encontremos, tendremos cuatro casos posibles. Los
%subíndices 1 y 2 indican cuáles son los extremos entre
%los que se interpola linealmente:

    if hR<=h(i) & h(i)<hY     h1(i)=hR;h2(i)=hY;e1(i)=eR;e2(i)=eY;H1(i)=0;
                              HP(i)=100*((h(i)-h1(i))/e1(i))/((h(i)-h1(i))/e1(i)+(h2(i)-h(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=100-HP(i);HCY(i)=HP(i);HCG(i)=0;HCB(i)=0;
    elseif hY<=h(i) & h(i)<hG h1(i)=hY;h2(i)=hG;e1(i)=eY;e2(i)=eG;H1(i)=100;
                              HP(i)=100*((h(i)-h1(i))/e1(i))/((h(i)-h1(i))/e1(i)+(h2(i)-h(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=0;HCY(i)=100-HP(i);HCG(i)=HP(i);HCB(i)=0;
    elseif hG<=h(i) & h(i)<hB h1(i)=hG;h2(i)=hB;e1(i)=eG;e2(i)=eB;H1(i)=200;
                              HP(i)=100*((h(i)-h1(i))/e1(i))/((h(i)-h1(i))/e1(i)+(h2(i)-h(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=0;HCY(i)=0;HCG(i)=100-HP(i);HCB(i)=HP(i);
    else                      h1(i)=hB;h2(i)=hR+360;e1(i)=eB;e2(i)=eR;H1(i)=300;
                              HP(i)=100*((h(i)-h1(i))/e1(i))/((h(i)-h1(i))/e1(i)+(h2(i)-h(i))/e2(i));
                              H(i)=H1(i)+HP(i);HCR(i)=HP(i);HCY(i)=0;HCG(i)=0;HCB(i)=100-HP(i);
    end;

  e(i)=e1(i)+(e2(i)-e1(i))*(h(i)-h1(i))/(h2(i)-h1(i));
%Ahora redefinimos el ángulo de tono para que nos quede 
%entre 0 y 360 grados:
  h(i)=h(i)+360*(+(h(i)<0));
  h(i)=h(i)-360*(+(h(i)>=0));
  A(i)=(2*roa(i)+gaa(i)+bea(i)/20-2.05)*Nbb(i);
  Aw(i)=(2*roaw(i)+gaaw(i)+beaw(i)/20-2.05)*Nbb(i);
  z(i)=1+(FLL(i)*(n(i)^(1/2)));
%Ahora ya estamos en condiciones de calcular los valores
%de los parámetros perceptuales restantes:
  J(i)=100*((A(i)/Aw(i))^(c(i)*z(i)));
  Q(i)=(1.24/c(i))*((J(i)/100)^0.67)*((Aw(i)+3)^0.9);
  s(i)=(50*(a(i)^2+b(i)^2)^(1/2)*100*e(i)*(10/13)*Nc(i)*Ncb(i))/(roa(i)+gaa(i)+(21/20)*bea(i));
  C(i)=2.44*s(i)^0.69*(J(i)/100)^(0.67*n(i))*(1.64-0.29^(n(i)));
  M(i)=C(i)*FL(i)^0.15;
  end

ans=[h;H;HCR;HCY;HCG;HCB;J;Q;s;C;M];
%queremos que la respuesta aparezca en forma de matriz
%o tabla con once columnas, así que trasponemos:
ans=ans';