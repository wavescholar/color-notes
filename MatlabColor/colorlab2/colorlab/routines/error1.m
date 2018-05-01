function e=error1(x,p,funci)

% ERROR1 da cual es el error cuadratico que resulta al suponer 
% unos determinados parametros p de una funcion f(x,p) para ajustar
% unos datos experimentales y_exp cuando no se conocen las desviaciones 
% de las abscisas y las ordenadas.
%
% Es decir, dados los valores experimentales (y), y las abscisas para
% las que se obtuvieron (x), ERROR1 calcula esto:
%
%                  error=sum((y-f(x,p)).^2)
%
% Esta funcion esta pensada para utilizarse como funcion objetivo para
% la rutina FMINS, y asi calcular ajustes de funciones por minimos 
% cuadrados.
%
% NOTA: El error es una funcion de los parametros, no una funcion de x.
%
% USO: e=error1(p,x,y_exp,'funcion(x,p(i))');


eval(['e=sum((p(2,:)-(',funci,')).^2);'])
