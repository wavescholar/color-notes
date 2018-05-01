function replocus(f_igual,coco,limits,mostra,colores,grosores,tipos,tamanyos)

% REPLOCUS represents the spectral colors in the current chromatic diagram. 
% 
% REPLOCUS may also plot two convenient 'all positive' triangles: 
% - The limits of colors with positive tristimulus values in the current basis.
% - The limits of the color gammut reproducible in the current monitor (given by 
%   the chromaticities of the guns with maximum saturation).
% 
% REPLOCUS is the basis for the higher-level functions COLORDGM.M and COLORD_C.M.
% REPLOCUS is not intended to be used independently but to be called from these
% other functions.
%
% REPLOCUS allows you to choose many parameters of the plot: the color and width 
% of the lines and the font size in the axis and labels. 
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% replocus(T_l,tm,extra_limits,showtriang,linecolors,linewidths,linestyles,fontsizes)
%              
% T_l        = Color Matching Functions in the current basis (N*4 spectral-like matrix).
%
% tm         = Chromaticities of the monitor. 7*N matrix with the calibration data.
%              (see CALIBRAT.M or LOADMON.M).
%
% extra_limits = [min_t1 max_t1 min_t2 max_t2]
%                If you want to plot colors outside the locus of real colors you may 
%                want to extend the limits of the plot (otherwise computed from the 
%                locus). In this case you need to include these extra limits by hand. 
%
% showtriang = Parameter to enable/disable the plot of the 'all positive' triangles 
%              if showtriang = 0 
%                  REPLOCUS doesnt plot any triangle at all 
%              if showtriang = 1 
%                  It ONLY plots the triangle of the colors with all positive  
%                  tristimulus values. 
%              if showtriang = 2 
%                  It ONLY plots the triangle of generable colors. 
%              if showtriang = 3 
%                  It plots BOTH triangles. 
% 
% linecolors = 5*3 matrix containing the colors of the following lines
%              - Axis of the bounding box
%              - Locus of spectral colors
%              - Axis of the plot
%              - Triangle of primaries of the system
%              - Triangle of 'primaries' of the monitor
%
% linewidths = 1*5 vector containing the widths of the previous lines 
%              (in the order given above). 
%
% linestyles = 5*2 matrix containing the strings that define the style of 
%              the lines (in the order given above) according to the convention
%              used in plot.m.
%              
% fontsizes  = 1*2 vector containing the sizes of the numbers in the axis and
%              the labels of the axes respectively.
%
% If you dont want to waste your time thinking on aesthetics, here you have an 
% example you can use to begin with (cut, paste and explore!):
%
% showtriang=3;
% linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0];
% linewidths=[0.5 0.5 0.5 0.5 0.5];
% linestyles=['- ';'- ';'- ';'- ';': '];
% fontsizes=[10 12];
%
% replocus(T_l,tm,showtriang,linecolors,linewidths,linestyles,fontsizes);
%
% This means that it will plot the locus and both triangles, the bounding box will be
% black, the locus will be blue, the axis will be dark blue, the triangle of primaries
% will be dark green and the monitor triangle will be dark red.
% All the lines will be solid but the monitor line and all of them will be 0.5 width.
% The numbers of the axis will be size 10 and the labels size 12.
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% mini.m
% maxi.m
% niv2coor.m, ganadora.m
% 

global angulos poscero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
% Interpolacion de las funciones de igualacion del color a 5nm  %  
%                                                               %	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xm=mini(f_igual(:,1));
xM=maxi(f_igual(:,1));

xx=xm:1:xM;

ff_igual(:,1)=xx';
ff_igual(:,2)=interp1(f_igual(:,1),f_igual(:,2),xx','linear');
ff_igual(:,3)=interp1(f_igual(:,1),f_igual(:,3),xx','linear');
ff_igual(:,4)=interp1(f_igual(:,1),f_igual(:,4),xx','linear');

f_igual=ff_igual;
clear ff_igual;

locus=f_igual(:,2:4)./[sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')' sum(f_igual(:,2:4)')'];
locus=locus(:,1:2);


long_loc=size(locus);
long_loc=long_loc(1);

vloc=locus-(1/3)*ones(long_loc,2);
angulos=atan2(vloc(:,2),vloc(:,1));

% Eliminacion del salto del angulo al pasar de 2*pi
% (aqui se podria haber utilizado unwrap.m, pero...)
%
% Ademas rotamos el locus haciendo que el angulo 
% minimo (extremo rojo o azul) sea cero.
%

  angulos=angulos.*(+(angulos>=0))+(angulos+2*pi).*(+(angulos<0));

  anm1=angulos(2:length(angulos));
  an=angulos(1:length(angulos)-1);
  incan=anm1-an;
%  size(angulos)
  poscero=find(abs(incan)>0.9*2*pi);
%  cuanan=length(angulos);
  
 
 if not(isempty(poscero))
 %   for que=1:length(poscero)
  %     if que==length(poscero)
  %      angulos=[angulos(1:poscero(que)) angulos(min(poscero(que)+1,end):end)-sign(incan(poscero(que)))*2*pi];
  
  %     else
   %     angulos=[angulos(1:poscero(que)) angulos(poscero(que)+1:poscero(que+1))-sign(incan(poscero(que)))*2*pi];
    %   end   
    %    end
   angulos=[angulos(1:poscero);angulos(poscero+1:length(angulos))-sign(incan(poscero))*2*pi];

  end 

  incre=-min(angulos); 
  angulos=angulos+incre;

  angul1=angulos(1:floor(length(angulos)/2));
  angul2=angulos(floor(length(angulos)/2)+1:length(angulos));

  locus1=locus(1:floor(length(angulos)/2),:);
  locus1=locus1(length(angul1):-1:1,:);
  locus2=locus(floor(length(angulos)/2)+1:length(angulos),:);

  f_igual1=f_igual(1:floor(length(angulos)/2),:);
  f_igual1=f_igual1(length(angul1):-1:1,:);
  f_igual2=f_igual(floor(length(angulos)/2)+1:length(angulos),:);

% Eliminacion de los extremos rojo y azul del locus a partir de las lambdas de retorno
% (en principio solo debe ocurrir retorno en el extremo rojo, pero si los datos son
%  ruidosos y el sistema es critico -p.e. UVW- tambien puede haber confusion en los angulos
%  en el extremo azul)
%
% El retorno se detectara como un cambio de signo en la derivada del angulo
%

% Extremo rojo  

  anm12=angul2(2:length(angul2));
  an2=angul2(1:length(angul2)-1);
  incan2=anm12-an2;

  s12=sign(incan2(1));
  signos2=(sign(incan2)==s12);
  m2=min(find(signos2==0));

   
% Extremo azul

  angul1=angul1(length(angul1):-1:1);

  anm11=angul1(2:length(angul1));
  an1=angul1(1:length(angul1)-1);
  incan1=anm11-an1;

  s11=sign(incan1(1));
  signos1=(sign(incan1)==s11);
  m1=min(find(signos1==0));

% Definimos ahora los nuevos locus en la region bien comportada en angulos.

if length(m1)~=0
   angul1=angul1(1:m1);
   locus1=locus1(1:m1,:);
   f_igual1=f_igual1(1:m1,:);
   angul1=angul1(length(angul1):-1:1);
   locus1=locus1(length(angul1):-1:1,:);
   f_igual1=f_igual1(length(angul1):-1:1,:);
else
   angul1=angul1(length(angul1):-1:1);
   locus1=locus1(length(angul1):-1:1,:);
   f_igual1=f_igual1(length(angul1):-1:1,:);
end
   
if length(m2)~=0
   angul2=angul2(1:m2);
   locus2=locus2(1:m2,:);
   f_igual2=f_igual2(1:m2,:);
end
   
angulos=[angul1;angul2];
incre=-min(angulos); 
angulos=angulos+incre;
     
locus=[locus1;locus2];
f_igual=[f_igual1;f_igual2];



if mostra~=0 & mostra ~=1
  s=size(coco);
  Nmax=coco(1,s(2));
  coor=niv2coor(Nmax*[1 1 1],coco);
end

mint1=min([0;locus(:,1);limits(1)]);
mint2=min([0;locus(:,2);limits(3)]);
maxt1=max([1;locus(:,1);limits(2)]);
maxt2=max([1;locus(:,2);limits(4)]);
%if maxt1<1
%   maxt1=1;
%end
%if maxt2<1
%   maxt2=1;
%end

lt1=maxt1-mint1;
lt2=maxt2-mint2;
inc1=0.05*lt1;
inc2=0.05*lt2;
mint1=mint1-inc1;
mint2=mint2-inc2;
maxt1=maxt1+inc1;
maxt2=maxt2+inc2;
l=length(locus(:,1));

%clf
%colordef white

%if col==1
   
   % Locus
   
   h1=plot(locus(:,1),locus(:,2));
   hp=get(h1,'Parent');
   hold on
   h2=plot([locus(1,1) locus(l,1)],[locus(1,2) locus(l,2)]);
   set(hp,'XColor',colores(1,:),'YColor',colores(1,:),'LineWidth',grosores(1),'FontSize',tamanyos(1),'LineStyle',tipos(1,:));
   set(h1,'Color',colores(2,:),'LineWidth',grosores(2),'LineStyle',tipos(2,:));
   set(h2,'Color',colores(2,:),'LineWidth',grosores(2),'LineStyle',tipos(2,:));
   
   % Ejes
   
   axis('equal')
   axis([mint1 maxt1 mint2 maxt2])
   h1=plot([mint1;maxt1],[0;0]);
   h2=plot([0;0],[mint2;maxt2]);
   set(h1,'Color',colores(3,:),'LineWidth',grosores(3),'LineStyle',tipos(3,:));
   set(h2,'Color',colores(3,:),'LineWidth',grosores(3),'LineStyle',tipos(3,:));
   
   % Triangulos
   
   if mostra==1
       h1=plot([0 1],[0 0]);
       h2=plot([0 0],[0 1]);
       h3=plot([1 0],[0 1]);
       set(h1,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       set(h2,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       set(h3,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       
      
   elseif mostra==2    
       
       h1=plot([coor(1,1) coor(2,1)],[coor(1,2) coor(2,2)]);
       h2=plot([coor(2,1) coor(3,1)],[coor(2,2) coor(3,2)]);
       h3=plot([coor(3,1) coor(1,1)],[coor(3,2) coor(1,2)]);
       set(h1,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       set(h2,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       set(h3,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       
   elseif mostra==3    
       
       h1=plot([0 1],[0 0]);
       h2=plot([0 0],[0 1]);
       h3=plot([1 0],[0 1]);
       set(h1,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       set(h2,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       set(h3,'Color',colores(4,:),'LineWidth',grosores(4),'LineStyle',tipos(4,:));
       
       h1=plot([coor(1,1) coor(2,1)],[coor(1,2) coor(2,2)]);
       h2=plot([coor(2,1) coor(3,1)],[coor(2,2) coor(3,2)]);
       h3=plot([coor(3,1) coor(1,1)],[coor(3,2) coor(1,2)]);
       set(h1,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       set(h2,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       set(h3,'Color',colores(5,:),'LineWidth',grosores(5),'LineStyle',tipos(5,:));
       
   end
   
   %Leyendas
   
   h1=xlabel('\it t_1');
   h2=ylabel('\it t_2');
   pos=get(h2,'Position');
      hp=get(h2,'Parent');
      xlim=get(hp,'XLim');
      xlongit_dec=(xlim(2)-xlim(1))/30;
   pos=[pos(1)-xlongit_dec pos(2) pos(3)];   
   
   set(h1,'Color',colores(1,:),'FontSize',tamanyos(2));
   set(h2,'Color',colores(1,:),'FontSize',tamanyos(2),'Rotation',0,'Position',pos);
   
   hold off
   
%else
%   figure(fig),clf,plot(locus(:,1),locus(:,2),'k-')
%   hold on
%   plot([locus(1,1) locus(l,1)],[locus(1,2) locus(l,2)],'k-')
%   axis('equal')
%   axis([mint1 maxt1 mint2 maxt2])
%   plot([mint1;maxt1],[0;0],'k:');
%   plot([0;0],[mint2;maxt2],'k:');
%   
%   if mostra==1
%       plot([0 1],[0 0],'b');
%       plot([0 0],[0 1],'b');
%       plot([1 0],[0 1],'b');
%       plot([coor(1,1) coor(2,1)],[coor(1,2) coor(2,2)],'b');
%       plot([coor(2,1) coor(3,1)],[coor(2,2) coor(3,2)],'b');
%       plot([coor(3,1) coor(1,1)],[coor(3,2) coor(1,2)],'b');
%   end
%   
%   %plot([1 maxt1],[0 0],'b');
%   %plot([0 0],[1 maxt2],'b');
%   
%   xlabel('\it t_1'),ylabel('\it t_2')
%   hold off
%end