function Dvvf=derivad2(f,x,p,v1,v2,t)

% DERIVAD2 calcula la derivada 2ª de la funcion f(x,p): Rn->Rm en k puntos Xo respecto de
% las direcciones V1 y V2 mediante la expresion:
%
%                           f(xo+tv1+tv2,p) - f(xo+tv2,p) - f(xo+tv1,p) + f(xo,p)
%            Dv1v2f(xo) = --------------------------------------------------------
%                                                t^2  
%
% 
% Notese que si V1 esta en la direccion del eje i y V2 en la del eje j, tenemos la derivada
% 2ª respecto de las coordenadas i y j.
%
% USO: Dvf(x)=derivad2('f(x,p)',x,p,v1,v2,t);
%
% DERIVAD2 calcula la derivada 2ª en k puntos: el parametro x puede ser una matriz
% de dimensiones k*n conteniendo en cada fila un punto del dominio N-dimensional donde que-
% ramos calcular la derivada.
%
% El resultado Dvvf(x) sera una matriz k*m tal que en cada fila contiene la derivada Dvvf(x)
% para cada punto xk.
% 
% Ten cuidado de definir la funcion de forma que su resultado sea un vector fila!


s=size(x);
for i=1:s(1)
    Dvvf(i,:)=(funcion(x(i,:)+t*v1+t*v2,p,f)-funcion(x(i,:)+t*v2,p,f)-funcion(x(i,:)+t*v1,p,f)+funcion(x(i,:),p,f))/(t^2);
end
