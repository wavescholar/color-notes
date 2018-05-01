% REPMON representa los datos que caracterizan al monitor
% a partir de los resultados de CALIBRIN:
%
%       * Curvas         Y(Pi) = ai*ni^gi  
%
%       * Variacion de la cromaticidad de los primarios con
%         el nivel digital
%

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.3225*an 0.4*al]);
figure(2);clf;set(2,'Position',[0.3375*an 0.0533*al 0.3225*an 0.4*al]);
figure(3);clf;set(3,'Position',[0.67*an 0.0533*al 0.3225*an 0.4*al]);
figure(4);clf;set(4,'Position',[0.005*an 0.53*al 0.6538*an 0.4*al]);
figure(5);
figure(6);
delete(5)
delete(6)

%repmonit(a,g,coco,f_igual,1,1,1);
coco=tm;
s=size(coco);
N=coco(1,s(2));
colores=[[coco(2:3,:)' ones(s(2),1)];[coco(4:5,:)' ones(s(2),1)];[coco(6:7,:)' ones(s(2),1)]];

ni=linspace(0,N,40);
for i=1:3
    y=a(i)*ni.^g(i);
    figure(1+i-1),
    aaa=axes;
    plot(ni,y);
    set(aaa,'FontSize',8,'XLim',[0 1],'XLimMode','Manual');
    set(aaa,'YLim',[0 115],'YLimMode','Manual'),
    xlabel(['Digital value of gun ',int2str(i)],'FontSize',8),
    ylabel('Luminance (cd/m2)','FontSize',8)
    title(['Y_{',num2str(i),'}=a_{',num2str(i),'}*n_{',num2str(i),'}^{\gamma_{',num2str(i),'}}      a_{',num2str(i),'}=',num2str(a(i)),'    \gamma_{',num2str(i),'}=',num2str(g(i))])
end
%t=colorend(colores,2,f_igual,0,0,coco,0,1,1+3);
%title('Cromaticidades de los primarios','FontSize',8)

figure(4),colordgm(colores,2,T_l,[0 1 0]);
title('Chromaticities of the guns','FontSize',8)
