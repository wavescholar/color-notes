function calibra(n,l,fig)

% CALIBRA  genera los test para medir las curvas Y(Pi)=fi(ni) y obtener la gamma del monitor
% 
% Lo que hace es aplicar correccion lineal (ninguna correccion) y generar (en la figura fig)
% un cuadrado de lado l (entre 0 y 1) de colores (n1,n2,n3) con ni entre 0 y 1.
%
% USO: calibra([n1 n2 n3],l,fig);


% cmgamma
figure(fig);
clf
patch([0.5-l/2 0.5+l/2 0.5+l/2 0.5-l/2],[0.5-l/2 0.5-l/2 0.5+l/2 0.5+l/2],1);
colormap(n);
axis([0 1 0 1]),ax,axis('off')


