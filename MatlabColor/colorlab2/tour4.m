function [nmat,tp]=tour4(terna,tipo,utri,coco,a,g,figual,fig,limites,viu,lado)

% TOUR4 genera un color, lo situa en el diagrama cromatico y en el espacio triestimulo
%
% En el diagrama y el espacio, se representa el estimulo de referencia (1), el color
% deseado (2) y el color generable mas proximo (3).
% 
% El espacio triestimulo representado esta escalado para que el color generable mas
% luminoso (el blanco [63 63 63]) tenga un valor triestimulo maximo igual a la diago-
% nal de los ejes representados.
%
% El color puede estar definido por cualquiera de estas ternas:
% 
%   tipo=1 ......... Valores triestimulo [T1 T2 T3]
%
%   tipo=2 ......... Coordenadas cromaticas y luminancia [t1 t2 Y]
%
%   tipo=3 ......... Lambda dominante, Pe y luminancia [ld Pe Y]
%
%   tipo=4 ......... Lambda dominante, Pc y luminancia [ld Pc Y]
%
% TOUR4 necesita:
%
% * Los parametros de calibrado del monitor (ver CALIBRIN):
% 
%    . Coordenadas de los primarios del monitor en funcion del nivel digital.
%      (en el sistema que toque)
%
%    . Los parametros a g
%
% * Los datos del sistema de referencia:
% 
%    . Unidades tricromaticas
%    . Funciones de igualacion
%
% USO: [nmat,tp]=tour4([terna],tipo,[unid_tric],coord_mon,a,g,f_igual,fig,
%                   [limites ejes],[azimut elevac],lado);
% 

masimo=min([limites(2) limites(4) limites(6)]);

pantalla=get(0, 'ScreenSize');
alto=pantalla(4);
ancho=pantalla(3);
h1=figure(fig);
clf
set(h1,'Position',[0.005*ancho 0.53*alto 0.6538*ancho 0.4*alto]);
h2=figure(fig+1);
clf
set(h2,'Position',[0.005*ancho 0.053*alto 0.49*ancho 0.47*alto]);
h3=figure(fig+2);
clf
set(h3,'Position',[0.505*ancho 0.053*alto 0.49*ancho 0.47*alto]);

if tipo==1
   T=terna;
elseif tipo==2
   T=coor2tri(terna,utri);
elseif tipo==3
   t=lp2coor(terna,1,figual,utri);
   T=coor2tri(t,utri);
else
   t=lp2coor(terna,2,figual,utri);
   T=coor2tri(t,utri);
end

if nargin<12
   lado=1;
end

%[nmon,nmat,satur,Tposible]=tri2niv4(coco,utri,a,g,lado,T);
[nmat,satur,Tposible]=tri2val(T,utri,coco,a,g,8);

s=size(coco);
Nmax=coco(1,s(2));
coor=[coco(2:3,s(2))';coco(4:5,s(2))';coco(6:7,s(2))'];
MT=n2t([Nmax Nmax Nmax],a,g,coor,utri);
MT=max(MT);

tp=tri2coor(Tposible,utri);

T=masimo*T/MT;
Tposible=masimo*Tposible/MT;

%coo=niv2coor(nmon,coco,64);

%colorend([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,1,coco,1,col,fig+1);

figure(fig+1)

  symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  lincolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 4 8];
 
  %colordgm([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  colordgm([0.9*masimo*[1 0 0;0 1 0;0 0 1;1 1 1];T;Tposible],1,figual,utri,'symb','o','sizes',fontsizes,'showtriang',{3,coco},'linecolors',lincolors,'show_numb',1)
  
%colorene([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,1,figual,utri,coco,1,1,fig+2,col,limites,viu);

  figure(fig+2)
  symb='o';
  lim_axis=0;
  showvectors=1;
  show_lin=0;
  show_numb=1;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 1.5 8];
  
  
%colorspc([0.9*masimo 0.9*masimo 0.9*masimo;50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,figual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

colorspc([0.9*masimo*[1 0 0;0 1 0;0 0 1;1 1 1];T;Tposible],1,figual,utri,'show_numb',1,'showvectors',1,'symb','o','sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)

calibra(nmat,1,fig);