function [Y]=tri2lum(T,coor,utri);

% Dadas las cromaticidades de unos determinados primarios
% TRI2LUM calcula cuales son las luminancias de estos primarios
% necesarias para generar un color con unos determinados 
% valores triestimulo (estas luminancias en principio pueden
% ser negativas). 
%
% USO: [Y]=tri2lum(T,coor,utri);

t3=1-coor(:,1)-coor(:,2);
coor=[coor t3];

d1=coor(1,:)*utri';
d2=coor(2,:)*utri';
d3=coor(3,:)*utri';

M=[coor(:,1)'./[d1 d2 d3];coor(:,2)'./[d1 d2 d3];coor(:,3)'./[d1 d2 d3]];

Y=inv(M)*T';
Y=Y';
