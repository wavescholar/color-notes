function [Y]=niv2lum(n,a,g)

% NIV2LUM calcula las luminancias de los primarios a partir 
% de unos niveles digitales dadas unas curvas Yi=f(ni).
%
% Las curvas de de relacion entre niveles digitales y luminancias
% son de la forma:
%
%                  Y(Pi)=ai*ni^gi  (si n>0)
%  
%                  Y(Pi)=ni        (si n<0 no escandalizarse!)      
%
%
% USO: [Y]=niv2lum(n,a,g);
%

Y=[0 0 0];
if any(n<=0)
   for i=1:3
       if n(i)<=0
          Y(i)=0.001;
       else
          Y(i)=a(i)*n(i)^g(i);
       end
   end
else
   Y=a.*n.^g;
end
