function replocus(f_igual,mostra,coco,fig,col)

% REPLOCUS representa el diagrama cromatico en cualquier sistema de primarios
% (respecto del que esta expresado el locus que se le introduce).
% Si se desea, muestra el triangulo de cromaticidades generables con los
% primarios de dicho sistema (en verde) y el triangulo limite de cromatici-
% dades generables con los primarios del monitor (en rojo).
% Para añadir cosas sobre esta figura ejecutar a continuacion un HOLD ON
%
% Seleccionando color_lin=0 todo aparece en negro y asi se puede exportar bien a
% Word
%
% USO: replocus(f_igual,muestra_limites?(0/1),coco,fig,color_lin?(1/0))
%

locus=f_igual./[sum(f_igual')' sum(f_igual')' sum(f_igual')'];
locus=locus(:,1:2);
s=size(coco);
Nmax=coco(1,s(2));
coor=niv2coor(Nmax*[1 1 1],coco);

mint1=min(locus(:,1));
mint2=min(locus(:,2));
maxt1=max(locus(:,1));
maxt2=max(locus(:,2));
if maxt1<1
   maxt1=1;
end
if maxt2<1
   maxt2=1;
end

lt1=maxt1-mint1;
lt2=maxt2-mint2;
inc1=0.05*lt1;
inc2=0.05*lt2;
mint1=mint1-inc1;
mint2=mint2-inc2;
maxt1=maxt1+inc1;
maxt2=maxt2+inc2;
l=length(locus(:,1));
if col==1
   figure(fig),clg,plot(locus(:,1),locus(:,2),'y-'),
   hold on
   plot([locus(1,1) locus(l,1)],[locus(1,2) locus(l,2)],'y-')
   axis([mint1 maxt1 mint2 maxt2])
   axis('equal'),ax
   a=axes;set(a,'FontSize',8);
   axis(axis);   
   
   plot([mint1;maxt1],[0;0],'b');
   plot([0;0],[mint2;maxt2],'b');
   
   if mostra==1
       plot([0 1],[0 0],'g');
       plot([0 0],[0 1],'g');
       plot([1 0],[0 1],'g');
       plot([coor(1,1) coor(2,1)],[coor(1,2) coor(2,2)],'r');
       plot([coor(2,1) coor(3,1)],[coor(2,2) coor(3,2)],'r');
       plot([coor(3,1) coor(1,1)],[coor(3,2) coor(1,2)],'r');
   end
   
   %plot([1 maxt1],[0 0],'b');
   %plot([0 0],[1 maxt2],'b');

   xlabel('t1','FontSize',8),ylabel('t2','FontSize',8)
   hold off
else   
   figure(fig),clg,plot(locus(:,1),locus(:,2),'k-')
   hold on
   plot([locus(1,1) locus(l,1)],[locus(1,2) locus(l,2)],'k-')
   axis([mint1 maxt1 mint2 maxt2])
   axis('equal'),ax
   
   plot([mint1;maxt1],[0;0],'k:');
   plot([0;0],[mint2;maxt2],'k:');
   
   if mostra==1
       plot([0 1],[0 0],'b');
       plot([0 0],[0 1],'b');
       plot([1 0],[0 1],'b');
       plot([coor(1,1) coor(2,1)],[coor(1,2) coor(2,2)],'b');
       plot([coor(2,1) coor(3,1)],[coor(2,2) coor(3,2)],'b');
       plot([coor(3,1) coor(1,1)],[coor(3,2) coor(1,2)],'b');
   end
   
   %plot([1 maxt1],[0 0],'b');
   %plot([0 0],[1 maxt2],'b');
   a=axes;set(a,'FontSize',8);
   axis(axis);   
   xlabel('t1','FontSize',8),ylabel('t2','FontSize',8)
   hold off
end    
        