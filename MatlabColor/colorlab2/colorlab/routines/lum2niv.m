function [n]=lum2niv(Y,a,g);

% LUM2NIV calcula los niveles digitales necesarios para 
% generar las luminancias dadas segun las curvas Yi=f(ni)
%
% Las curvas de de relacion entre niveles digitales y luminancias
% son de la forma:
%
%                  Y(Pi)=ai*ni^gi  (si n>0)
%  
%                  Y(Pi)=ni        (si n<=0 no escandalizarse!)      
%
% USO: [n]=lum2niv(Y,a,g);


n=[0 0 0];
if any(Y<=0)
   for i=1:3
       if Y(i)<=0
          n(i)=0.000001;
       else
          n(i)=exp(log(Y(i)/a(i))/g(i));
       end
   end
else
   n=exp(log(Y./a)./g);
end