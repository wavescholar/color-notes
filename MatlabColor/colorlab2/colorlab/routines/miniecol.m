function [nm,em]=miniecol(n0,Td,l,a,g,coco,utri)

% MINIECOL obtiene (por busqueda exhaustiva en un entorno de N0) la terna de niveles digitales
% que minimizan el error euclideo entre el color generado y el deseado.
% Podemos controlar el tamaño del area de busqueda mediante el parametro 'lado' que fija el
% lado del cubo de ternas de niveles digitales entorno a N0.
% 
% Si en un primer bucle el minimo se obtiene en un extremo del area de busqueda, se realiza
% otra busqueda centrada en este nuevo punto.
%
% El proceso se detiene cuando el mínimo se encuentra en el interior del area de busqueda o
% cuando se llega a un extremo del area total de busqueda (cubo [0,0,0]-[Nmax,Nmax,Nmax])
%
% [nn,en]=miniecol(n0,T,lado,a,g,coco,utri)
%
% REQUIRED FUNCTIONS
% --------------------------------------------------------------------------------------------
%   errcol.m  ganadora.m
% niv2coor.m

s=size(coco);
Nmax=coco(1,s(2));

em=errcol(Td,n0,a,g,coco,utri);
nm=n0;

%l=ceil(l/2); Quito esto porque ahora el lado del volumen de busqueda viene dado por 
%             la resolucion en bits, y es un numero real.

cond=0;

kkk=0;
while cond==0
    kkk=kkk+1;
    if kkk>2000
       cond=1;
    end 
    for i=1:3
        if n0(i)-l<0
           m(i)=0;
        else
           m(i)=n0(i)-l;
        end
        if n0(i)+l>Nmax
           M(i)=Nmax;
        else
           M(i)=n0(i)+l;
        end
    end 
%    [m;M]
%    pause
    for ii=m(1):(M(1)-m(1))/2:M(1)
        for jj=m(2):(M(2)-m(2))/2:M(2)
            for kk=m(3):(M(3)-m(3))/2:M(3)
                n=[ii jj kk];
                  coor=niv2coor(n,coco);
                  Y=a.*n.^g;
                  t3=1-coor(:,1)-coor(:,2);
                  coor=[coor t3];
                  d1=coor(1,:)*utri';
                  d2=coor(2,:)*utri';
                  d3=coor(3,:)*utri';
                  MM=[coor(:,1)'./[d1 d2 d3];coor(:,2)'./[d1 d2 d3];coor(:,3)'./[d1 d2 d3]];
                  Tg=MM*Y';
                  Tg=Tg';
                  e=(Td-Tg)*(Td-Tg)';
                if e<em
                   nm=n;
                   em=e;
                end
            end
        end
    end
    for i=1:3
        if (nm(i)==0)|(nm(i)==Nmax)
           c(i)=1;
        else
           c(i)=+((nm(i)>m(i))&(nm(i)<M(i))); 
        end
    end
    if prod(c)==1
       cond=1;
    else 
       n0=nm;
    end
end