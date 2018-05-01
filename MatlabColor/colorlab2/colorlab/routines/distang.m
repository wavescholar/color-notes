function d=distang(dir1,dir2)

% DISTANG calcula el arco esxitente entre dos direcciones 
% definidas en coordenadas polares (en radianes)
%
%
% USO: arco=distang([theta1 phi1],[theta2 phi2])
%

p1=[1 dir1];
p2=[1 dir2];

px1=[sin(p1(2))*cos(p1(3)) sin(p1(2))*sin(p1(3)) cos(p1(2))];
px2=[sin(p2(2))*cos(p2(3)) sin(p2(2))*sin(p2(3)) cos(p2(2))];

alfa=p1(3);
beta=-p1(2);  % Ese signo menos es la causa de que no funcionase lo de las elipses 3D!! El puto sentido de los angulos!

Rz=[cos(alfa) sin(alfa) 0;-sin(alfa) cos(alfa) 0;0 0 1];
Ry=[cos(beta) 0 sin(beta);0 1 0;-sin(beta) 0 cos(beta)];

px2=Ry*Rz*px2';
px1=Ry*Rz*px1';

r2=sqrt(px2'*px2);
d=acos(px2(3)/r2);