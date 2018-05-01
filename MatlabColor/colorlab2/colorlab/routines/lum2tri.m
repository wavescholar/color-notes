function [T]=lum2tri(Y,coor,utri)

% LUM2TRI calcula los valores triestimulo del color generado
% mediante la suma aditiva de tres colores C1 C2 C3 de croma-
% ticidades coor=[ti(C1);ti(C2);ti(C3)] poniendo unas luminan-
% cias [Y(C1) Y(C2) Y(C3)] (que pueden ser negativas). 
%               
% El sistema de primarios en el que se obtiene el resultado es 
% aquel en el que expresamos las coordenadas y las unidades 
% tricromaticas.
%
% USO T=lum2tri(Y,coor,utri);


% OTRA POSIBILIDAD:

t3=1-coor(:,1)-coor(:,2);
coor=[coor t3];

d1=coor(1,:)*utri';
d2=coor(2,:)*utri';
d3=coor(3,:)*utri';

M=[coor(:,1)'./[d1 d2 d3];coor(:,2)'./[d1 d2 d3];coor(:,3)'./[d1 d2 d3]];

T=M*Y';
T=T';

% UNA POSIBILIDAD: PASAR TODO A VALORES TRIESTIMULO Y SUMAR
%
% T1=coor2tri([coor(1,:) Y(1)],utri);
% T2=coor2tri([coor(2,:) Y(2)],utri);
% T3=coor2tri([coor(3,:) Y(3)],utri);
% T=T1+T2+T3;