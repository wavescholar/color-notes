function t=colornd(C,cara,f_igual,utri,pintatri,coor,sionu,color,fig)

% COLOREND representa un conjunto de colores en el diagrama cromatico
% definido por el locus que se introduce.
%
% Puede introducirse cualquier caracterizacion del color indicandolo 
% mediante la variable 'caracteriz':
%
%     caracteriz = 1  ->   Valores triestimulo
%
%     caracteriz = 2  ->   Coordenadas cromaticas y luminancia
%
%     caracteriz = 3  ->   Longitud de onda dominante, pureza de excit. y luminancia
% 
%     caracteriz = 4  ->   Longitud de onda dominante, pureza colorimetric. y luminancia
% 
% USO: t=colorend([color],caracteriz,f_igual,[Y(Pi)w],pintatri?,coco,numeros?(0/1),color?,fig) 
% 


if cara==1
    t=tri2coor(C,utri); 
    t=t(:,1:2);
elseif cara==2
    t=C(:,1:2);
elseif cara==3
    t=lp2coor(C,1,utri,f_igual); 
    t=t(:,1:2);
else
    t=lp2coor(C,2,utri,f_igual);
    t=t(:,1:2);
end

replocd(f_igual,pintatri,coor,fig,color),axis(axis);hold on,

   plot(t(:,1),t(:,2),'w.'),hold off

if sionu==1
   l=size(C);
   l=l(1);
   for i=1:l
       text(t(i,1)+0.01,t(i,2)+0.01,int2str(i),'FontSize',8);
   end    
end