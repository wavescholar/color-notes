function e=errcol(Td,n,a,g,coco,utri)

% ERRCOL calcula la diferencia (euclidea) entre el color deseado y el generable
% a partir de una terna de niveles digitales. Esta es la funcion objetivo a minimizar
% en el algoritmo para generar en pantalla un determinado color.
% El resultado obtenido sera mas o menos optimo perceptualmente en funcion de cual
% sea el espacio de representacion, claro...
%
% USO: e=errcol(Tdeseado,n,a,g,coco,utri);
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------
% niv2coor.m   ganadora.m   n2t.m
% 

coor=niv2coor(n,coco);
Tg=n2t(n,a,g,coor,utri);
e=(Td-Tg)*(Td-Tg)';
