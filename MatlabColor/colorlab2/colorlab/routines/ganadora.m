function pos=ganadora(v,d);

%'GANADORA' calcula cual es la neurona que gana al compararar los 
% vectores almacenados con el dato de entrenamiento (o dato problema)
%
% USO: pos=ganadora(vectores_correspondientes a las neuronas,dato);
%
% OJO, los N vectores de dimension D deben entrarse almacenados en una 
% matriz N*D. El dato de entrenamiento (o dato problema) debe ser un vec-
% tor fila de longitud D. 


s=size(v);
s=s(1);
distancia=sqrt(sum(((v-(ones(s,1)*d)).^2)'));
[minimo,pos]=min(distancia);

