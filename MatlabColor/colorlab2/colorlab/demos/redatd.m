function [red,ATDc,ATDg,XYZc,XYZg,ni,Ag,Tg,Dg]=redatd(fs,N,V,C,f,o,fas,parqua,modelo,XYZa,pesos,modo,Ma,sigma,fig);

% REDATD genera una red cromatica ATD con el formato (imagen_index,paleta)
% resultante de superponer tres redes A,T,D cualesquiera en alguno de
% los espacios ATD disponibles (Boynton, Guth80, Guth90 y Guth 95, ver XYZ2ATD).
%
% Las tres redes (A,T,D) estan definidas en el mismo dominio espacial
% discreto dado por la frecuencia de muestreo fs (cl/deg) y el numero
% de puntos N.
%
% Hay que tener en cuenta que el modelo de Boynton permite tan solo
% calcular variaciones de ATD sobre un fondo dado. Por tanto, si 
% pretendemos obtener variaciones sinusoidales sobre un fondo V, 
% deberemos tomar Vi=0 y dar la información del fondo en el estímulo
% de adaptación. 
%
% Cada una de las redes esta definida mediante su valor medio Vi su 
% amplitud Am_i, su frecuencia fi (cl/deg), su orientacion oi (deg) y su
% fase fasi (rad).
%
% Para pasar de tres matrices triestimulo a una representacion con
% paleta hay que cuantizar la nube de colores que resulta de las tres 
% matrices. Hay que indicar el metodo de cuantizacion deseado mediante 
% el parametro parqua (ver tri2palt).
%
% Para representar la red necesitamos los datos del calibrado del monitor y
% las funciones de igualacion del color, hay que decirle los ficheros donde estan
% almacenados esos datos (variables 'traym' y 'trayf'). 
%
% El programa devuelve:
%
%    * La imagen indexada: red
%    * Diferentes paletas:
%           - La paleta ATD obtenida de la cuantizacion: ATDc
%           - La paleta ATD generable en el monitor:     ATDg
%           - La paleta XYZ obtenida de la cuantizacion: XYZc
%           - La paleta XYZ generable en el monitor:     XYZg
%           - La paleta de niveles digitales:             ni
%
% El programa representa (a partir de la figura que se le de):
%
%    * La red cromatica 
%    * La paleta ATDc en el espacio ATD
%    * La paleta ATDg en el espacio ATD
%    * La paleta XYZc en el diagrama xy 
%    * La paleta XYZg en el diagrama xy 
%    * El espectro de la componente A de la red original
%    * El espectro de la componente A finalmente generada 
%
% USO: [red,ATDc,ATDg,XYZc,XYZg,ni,Ac,Ag]=redatd(fs,N,[VA VT VD],[Am_A Am_T Am_D],[fA fT fD],[oA oT oD],[fasA fasT fasD],parqua,
%                                               modelo(1-6),XYZa(1,3-6),[p_test p_fondo](3-6),modo(3-6),Ma(2),sigma(3-6),'traym','trayf',fig);
%

[red,ATDc]=redcrom(fs,N,V,C,f,o,fas,parqua);

XYZc=atd2xyz(ATDc,2,modelo,XYZa,pesos,modo,Ma,sigma);

if modelo==1
   if length(XYZa)==1
      XYZa=[0 0 0];
   end
   XYZc=[XYZc(:,1)+XYZa(1) XYZc(:,2)+XYZa(2) XYZc(:,3)+XYZa(3)];
end

inicio
[ni,nmatlab,satur,XYZg]=tri2niv4(coco,[0 1 0],a,g,1,XYZc);

[ATDf,ATDg]=xyz2atd(XYZg,modelo,XYZa,pesos,modo,Ma,sigma);

figure(fig),colormap(nmatlab),image(red),ax,axis('off')
colorend(XYZc,1,f_igual,[0 1 0],1,coco,0,1,fig+1);
colorend(XYZg,1,f_igual,[0 1 0],1,coco,0,1,fig+2);

Ymax=utri*f_igual(555-379,2:4)';
f_igualre=130*f_igual(:,2:4)/Ymax;
f_igualre=[f_igual(:,1) f_igualre];

[ATDf,f_igualre]=xyz2atd(f_igualre(:,2:4),modelo,XYZa,pesos,modo,Ma,sigma);

rango1=maxi(f_igualre(:,1))-mini(f_igualre(:,1));
rango2=maxi(f_igualre(:,2))-mini(f_igualre(:,2));
rango3=maxi(f_igualre(:,3))-mini(f_igualre(:,3));
m1=mini(f_igualre(:,1))-0.05*rango1;
M1=maxi(f_igualre(:,1))+0.05*rango1;
m2=mini(f_igualre(:,2))-0.05*rango2;
M2=maxi(f_igualre(:,2))+0.05*rango2;
m3=mini(f_igualre(:,3))-0.05*rango3;
M3=maxi(f_igualre(:,3))+0.05*rango3;
colorene([ATDc;f_igualre],1,0,[f_igual(:,1) f_igualre],utri,coco,0,0,fig+3,1,[m1 M1 m2 M2 m3 M3],[100 30]);
colorene([ATDg;f_igualre],1,0,[f_igual(:,1) f_igualre],utri,coco,0,0,fig+4,1,[m1 M1 m2 M2 m3 M3],[100 30]);

A=V(1)+C(1)*seno(fs,N,f(1),o(1),fas(1));
T=V(2)+C(2)*seno(fs,N,f(2),o(2),fas(2));
D=V(3)+C(3)*seno(fs,N,f(3),o(3),fas(3));

A=fftshift(abs(fft2(A)));
T=fftshift(abs(fft2(T)));
D=fftshift(abs(fft2(D)));

[Ag,Tg,Dg]=palt2tri(red,ATDg);

tfAg=fftshift(abs(fft2(Ag)));
tfTg=fftshift(abs(fft2(Tg)));
tfDg=fftshift(abs(fft2(Dg)));

ma(1)=maxi(A);
ma(2)=maxi(T);
ma(3)=maxi(D);

[ma,pos]=max(ma);

co=(pos-2)*(pos-3)*(A<ma)+(pos-1)*(pos-3)*(T<ma)+(pos-1)*(pos-2)*(D<ma);
co=co>0;

figure(fig+5),contour(flipud(A.*co))
figure(fig+6),contour(flipud(tfAg.*co))

figure(fig+7),contour(flipud(T.*co))
figure(fig+8),contour(flipud(tfTg.*co))

figure(fig+9),contour(flipud(D.*co))
figure(fig+10),contour(flipud(tfDg.*co))