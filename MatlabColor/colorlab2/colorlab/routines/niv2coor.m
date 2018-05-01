function [coor]=niv2coor(n,coco)

% NIV2COOR calcula las coordenadas cromaticas de los 
% primarios del monitor para unos valores de los niveles
% digitales a partir de la matriz experimental de variacion
% de las coordenadas con el nivel digital:
%
% La variacion de las coordenadas cromaticas con el nivel
% digital se introduce mediante la matriz 'coco', que contiene en cada columna las coor-
% denadas de cada primario en un conjunto de niveles digitales (que incluyen 0 y Nm) dados 
% por la primera fila de dicha matriz:
%
%              /    0     ......     Nmax     \
%              | t1(P1(0)) ...... t1(P1(Nmax)) |
%              | t2(P1(0)) ...... t2(P1(Nmax)) |  
%              | t1(P2(0)) ...... t1(P2(Nmax)) |  
%       coco = | t2(P2(0)) ...... t2(P2(Nmax)) |  
%              | t1(P3(0)) ...... t1(P3(Nmax)) |  
%              \ t2(P3(0)) ...... t2(P3(Nmax)) / 
%
%
% Lo que se hace es interpolacion lineal.
%
% USO: coor=niv2coor(n,coco);
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------
% ganadora.m
% 


s=size(coco);
s=s(2);
nn=coco(1,:)';
Nmax=nn(length(nn));
coco=coco(2:7,:);

for i=1:3
    if (n(i)<Nmax)&(n(i)>0)
       pos=ganadora([nn nn],[n(i) n(i)]); 
       if nn(pos)>n(i)
          coor(i,1)=coco(2*i-1,pos-1)+((coco(2*i-1,pos)-coco(2*i-1,pos-1))/(nn(pos)-nn(pos-1)))*(n(i)-nn(pos-1));
          coor(i,2)=coco(2*i,pos-1)+((coco(2*i,pos)-coco(2*i,pos-1))/(nn(pos)-nn(pos-1)))*(n(i)-nn(pos-1));
       else
          coor(i,1)=coco(2*i-1,pos)+((coco(2*i-1,pos+1)-coco(2*i-1,pos))/(nn(pos+1)-nn(pos)))*(n(i)-nn(pos));
          coor(i,2)=coco(2*i,pos)+((coco(2*i,pos+1)-coco(2*i,pos))/(nn(pos+1)-nn(pos)))*(n(i)-nn(pos));
       end
    elseif n(i)>=Nmax  
       coor(i,:)=[coco(2*i-1,s) coco(2*i,s)];
    else
       coor(i,:)=[coco(2*i-1,1) coco(2*i,1)];
    end
end