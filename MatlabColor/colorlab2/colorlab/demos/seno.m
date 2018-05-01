function [s]=seno(fs,N,f,ang,fase)

% 'SENO' genera una funcion sinusoidal 2D de frcuencia 'f' y 
%  fase 'fas' (en radianes) y tal que el vector k forma un angulo
% 'ang' (en grados) con el eje x
%
%  USO: [s]=seno(fs,N,f,ang,fas);
%

fx=f*cos(ang*pi/180);
fy=f*sin(ang*pi/180);

Xm=(N-1)/fs;
x=linspace(0,Xm,N);
b=ones(N,1);
X=b*x;
Y=rot90(X,3);

s=sin(2*pi*(fx*X+fy*Y)+fase);

