function [palr]=tri2refl(palt,paso,R,S,f_igual,utri)

% TRI2REFL asigna reflectancias a un conjunto de vectores triestímulo.
%
% Lo que hace TRI2REFL es calcular los valores triestimulo de un conjunto
% de reflectancias dadas, R, iluminadas con un iluminante, S, y compa-
% rar las cromaticidades resultantes con las del vector triestimulo
% requerido.
% A cada vector triestímulo se le asigna la reflectancia mas próxima
% en el diagrama cromatico. 
% La reflectancia elegida se escala para igualar luminancia del color. 
%
% De esta manera, la paleta de reflectancias elegidas, PR, iluminadas
% mediante el iluminante dado sera aproximadamente metámera de la 
% paleta de vectores triestimulo requerida.
%
% El iluminante se introduce en valor absoluto (Watt).
% Si la energia iluminante elegido es baja, la exigencia de igualdad
% de luminancias puede dar lugar a reflectancias superiores a 1...
% (De ahi es de donde viene la imposibilidad de generar ciertos colores
% mediante muestras reflectantes...)
% En fin, aunque esto no tiene mucho sentido fisico, el programa puede
% devolver reflectancias con valores superiores a 1. 
% Si queremos ser puristas, podemos aplicar una condicion a la paleta de
% salida. Algo asi como:
%
%  PR(:,2:N+1) = PR(:,2:N+1).*(PR(:,2:N+1)<=1) + 1.*(PR(:,2:N+1)>1);
%
% Donde N es el numero de colores requerido, y en la primera columna de 
% PR van las longitudes de onda donde estan definidas las reflectancias 
% dadas (el formato usual para espectros en COLORLAB).
% El rango de reflectancias coincidira con el rango en el que esten definidas
% las funciones de igualación que se introduzcan, y el paso de muestreo 
% sera de 1nm.
%
% El conjunto de colores requerido se mete mediante una matriz N*3, formato
% usual para paletas en COLORLAB, y las reflectancias de partida y el iluminante
% tambien en la forma estandard.
%
% USO: PR=tri2refl(T,paso(nm),R,S,f_igual,unid_tricrom);
% 

[Tref,RR]=spec2tri(f_igual,paso,R,S);
tref=tri2coor(Tref,utri);
tpal=tri2coor(palt,utri);
sp=size(palt);
sr=size(R);
palr=zeros(sr(1),sp(1)+1);
palr(:,1)=R(:,1);
for i=2:sp(1)+1
    pos=ganadora(tref(:,1:2),tpal(i-1,1:2));
    fac=tpal(i-1,3)/tref(pos,3);
    palr(:,i)=fac*R(:,pos+1);
end

