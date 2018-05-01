function [xyY,t]=loadcal(fichero)

%Lee los valores triestímulo medidos con el
%Pritchard y guardados en un archivo de texto
%con TERMINAL.EXE
%
%USO: xyY=loadcal(fichero)
%
%En FICHERO debe ser una cadena que contenga la dirección exacta del archivo
%donde estén guardados los datos. El fichero debe ser el guardado 
%por TERMINAL.EXE, SIN MÁS MODIFICACIÓN QUE, COMO MÁXIMO, LA ELIMINACIÓN
%COMPLETA DE UNA MEDIDA.


fid=fopen(fichero,'r');
f=fread(fid);
s=setstr(f');
fclose(fid);

mi(1,:)=findstr(s,'cd/m2');
mi(2,:)=findstr(s,'x=');
mi(3,:)=findstr(s,'y=');
mi(4,:)=findstr(s,'ms');

%mi
for i=1:length(mi(1,:))
   if mi(1,i)<=4;resta=3;else resta=4;end
      pb(i,:)=[str2num(s(mi(1,i)-resta:mi(1,i)-1)) str2num(s(mi(2,i)+2:mi(2,i)+5)) str2num(s(mi(3,i)+2:mi(3,i)+5))];
end
xyY=pb(:,[2 3 1]);

%Esto lee el tiempo de integración, pero no es una salida útil, en
%principio
for i=1:length(mi(4,:))
   tope=max(find(isspace(s(mi(3,i):mi(4,i)))));
   t(i)=str2num(s(mi(3,i)+tope:mi(4,i)-1));
end