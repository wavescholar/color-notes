function [T,Treal,n1]=mondrian(reflectancias,ilumin,Em,funig,utri,coor,a,g,b,fig)

% MONDRIAN representa un mondrian con 9 reflectancias 
% definidas por los espectros contenidos en las columnas de la matriz
% 'reflec') e iluminado mediante el espectro 'ilumin'.
%
% La rutina devuelve los valores triestimulo (en el sistema correspon-
% diente a las funciones de igualacion del color que se le hayan meti-
% do) de los colores resultantes y del iluminante.
% 
% El paso de valores triestimulo a niveles digitales se hace teniendo en
% cuenta las curvas de calibracion de los fosforos del monitor, mediante
% TRI2NIV2. Los colores no representables se modifican segun los criterios
% de esa funcion.
%
% USO: [T,Tposible]=mondrian(reflectancias,ilumin,Em,f_igual,utri,coor,a,g,fig);

ilumin=Em*ilumin/maxi(ilumin);
reflej=reflectancias.*(ilumin*ones(1,9));
reflej=[reflej ilumin];

T=esp2tri(funig,reflej,maxi(reflej))
[n1,n2,satur,Treal]=tri2niv2(coor,utri,a,g,T);

colorend(Treal,1,f_igual,utri,1,coor,1,1,fig);

hold on
text(.1,.99, 'Coordenadas de los colores del');
text(.1,.92, 'Mondrian (1-9) y del iluminante (10)');
hold off

figure(fig+1),axis([0 6 0 6]),axis('off')
colormap(n2(1:9,:));
hold on
patch([0 0.9 0.9 0],[4 4 5.9 5.9],1)
patch([1 2.9 2.9 1],[4 4 5.9 5.9],2)
patch([3 3.9 3.9 3],[4 4 5.9 5.9],3)
patch([4 5.9 5.9 4],[4 4 5.9 5.9],4)
patch([0 2.9 2.9 0],[1 1 3.9 3.9],5)
patch([3 3.9 3.9 3],[2 2 3.9 3.9],6)
patch([3 3.9 3.9 3],[1 1 1.9 1.9],6)
patch([4 5.9 5.9 4],[2 2 3.9 3.9],7)
patch([0 2.9 2.9 0],[0 0 0.9 0.9],8)
patch([3 3.9 3.9 3],[0 0 0.9 0.9],9)
patch([4 5.9 5.9 4],[0 0 1.9 1.9],3)
hold off