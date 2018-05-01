function [S,pale]=redcrom(fs,N,V,C,f,o,fas,parqua)

% REDCROM genera una red cromatica con el formato (imagen_index,paleta)
% resultante de superponer tres redes cualesquiera en tres canales 
% cualesquiera.
% Las tres redes (red1 red2 red3) estan definidas en el mismo dominio
% discreto dado por la frecuencia de muestreo fs (cl/deg) y el numero
% de puntos N.
%
% Cada una de las redes esta definida mediante su valor medio Vi su 
% amplitud Ai, su frecuencia fi (cl/deg), su orientacion oi (deg) y su
% fase fasi (rad), es decir:
%
%      redi=Vi+Ai*sin(2*pi*(fi*cos(oi)*x+fi*sin(oi)*y)+fasi);
%
% Para pasar de tres matrices triestimulo a una representacion con
% paleta hay que cuantizar la nube de colores que resulta de las tres 
% matrices. Hay que indicar el metodo de cuantizacion deseado mediante 
% el parametro parqua (ver tri2palt). 
% 
% USO: [red,paleta]=redcrom(fs,N,[V1 V2 V3],[A1 A2 A3],
%       [f1 f2 f3],[o1 o2 o3], [fas1 fas2 fas3],parqua);

S1=V(1)+C(1)*seno(fs,N,f(1),o(1),fas(1));
S2=V(2)+C(2)*seno(fs,N,f(2),o(2),fas(2));
S3=V(3)+C(3)*seno(fs,N,f(3),o(3),fas(3));

[S,pale]=tri2palt(S1,S2,S3,parqua);

