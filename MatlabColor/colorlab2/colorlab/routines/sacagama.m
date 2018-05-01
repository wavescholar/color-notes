function [a,ea,g,eg]=sacagama(n,Y,num,fig)

% SACAGAMA calcula las gammas de un monitor para los tres primarios
% Esto lo hace a partir de los datos experimentales de luminancias y niveles
% digitales, es decir, ajusta las funciones:
%  
%                       Y(Pi) = ai (ni)^gi
%
% SACAGAMA no considera los errores en la medida de luminancias.
%
% USO: [a,errores_a,g,errores_g]=sacagama([n1;n2;n3],[Y1;Y2;Y3],num_iterac,fig);
%

for i=1:size(n,1) 
    [p,Mcov,Pchi,coefcorr]=justa1([0.2 1.2],[n(i,:);Y(i,:)],'x(1)*p(1,:).^x(2)',0,1e-10,1e-10,num,0.001,[0 1],fig-1+i);
    a(i)=p(1);
    ea(i)=abs(sqrt(Mcov(1,1)));
    g(i)=p(2);
    eg(i)=abs(sqrt(Mcov(2,2)));
end