function [XYZ,rad]=loadprit(fichero)

%Lee los valores triestímulo y la radiancia espectral obtenidas con el
%Pritchard.
%
%USO: [XYZ,rad]=loadprit(fichero)
%
% XYZ= Matrix Nx3 con los valores triestímulos de los N estímulos medidos
% rad= Matrix Mx2kN, con las reflectancias de los N estímulos medidos.
%En FICHERO debe ser una cadena que contenga la dirección exacta del archivo
%donde estén guardados los datos. El fichero puede contener varias medidas
%hechas con el PRITCHARD, pero sin modificar el texto que aparece por
%defecto.

fid=fopen(fichero,'r');
f=fread(fid);
s=setstr(f');
fclose(fid);

mi{1}=findstr(s,'X = ');ma{1}=findstr(s,'x = ');
mi{2}=findstr(s,'Y = ');ma{2}=findstr(s,'y = ');
mi{3}=findstr(s,'Z = ');ma{3}=findstr(s,'z = ');
cuan=length('X = ');
for i=1:3
    for j=1:length(mi{i})
       sT=s((mi{i}(j)+cuan):(ma{i}(j)-1));
       plusT=find(sT==']');
       minusT=find(sT=='\');
       if not(isempty(plusT)) sT(plusT)='+';end
       if not(isempty(minusT)) sT(minusT)='-';end
       XYZ(j,i)=str2num(sT);
   end
end


minif=findstr(s,' Corrected Spectral Radiance (w/sr/m2/nm)');
cuanf=length(' Corrected Spectral Radiance (w/sr/m2/nm)');
maxif0=findstr(s,'PHOTO RESEARCH \ The Light Measurement People');

for j=1:length(minif)
  if j+1<=length(maxif0)
     if minif(j)<maxif0(j+1)-1  
         maxif=maxif0(j+1)-1;
     else maxif=length(s);
     end
  else
    maxif=length(s);
  end
  minif(j)=minif(j)+cuanf+2;
  sref=s(minif(j):maxif);
  sref=strtrim(sref);
  plusr=find(sref==']');
  minusr=find(sref=='\');
  if not(isempty(plusr)) sref(plusr)='+';end
  if not(isempty(minusr)) sref(minusr)='-';end
  espacios=find(isspace(sref));
  numeros=find(not(isspace(sref)));
  cuales=find(not((espacios(2:end)-espacios(1:end-1))==1));
  espacios=espacios([cuales end]);
  todos=sort([numeros espacios]);
  sref=sref(todos);
  espacios=find(isspace(sref));
  valor=1;
  k=1;
  for i=1:(length(espacios));
     if valor>espacios(i)-1;final=length(sref);else final=espacios(i)-1;end
     n(k)=str2num(sref(valor:final));
     valor=espacios(i)+1;
     k=k+1;
  end
  n(k)=str2num(sref(valor:end));
 
  rad(:,1,j)=n(1:2:length(n))';
  rad(:,2,j)=n(2:2:length(n))';
  [a,b]=sort(rad(:,1,j));
  rad(:,:,j)=rad(b,:,j);
end



