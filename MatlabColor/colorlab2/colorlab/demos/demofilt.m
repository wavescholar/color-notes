function [radios]=demofilt

% DEMOFILT Demo de filtrado espacial
% (pasa baja) de los canales cromáticos.
%
% USO: [radios]=demofilt;

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
figure(2);clf;set(2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

clc
clc

disp(' SPATIAL FILTERING OF CHROMATIC CHANNELS')
disp(' ')
disp('  Here we analyze the effect of channel-selective')
disp('  bandwidth reduction in a particular chromatic basis')
disp(' ')
disp('  Press any key to contunue...')
pause
clc
cd([path_data,'images\images'])
[fich,tray]=uigetfile('*.*','Load *.jpg or *.tif images');
[im,pal]=imread([tray,fich]);

if isempty(pal)
   [im,pal]=true2pal(im,100);
elseif length(pal(:,1))>100
   im=pal2true(im,pal);
   [im,pal]=true2pal(im,100);
end
clc

kk=1;
while kk==1
      clc  

      demofi(im,pal,f_igual,utri,Msx,coco,a,g,an,al);
      %[nmatlab,imi,M12,fi,radios,portot]=demofi(im,pal,f_igual,utri,Msx,coco,a,g,an,al);

      clear all 
      
      p=which('ciergb.mat');
      path_data=p(1:end-18);
 
      load([path_data,'caca'])
      fi=get(0,'Children'); 
      fi=max(fi)+1;
      figure(fi),colormap(nmatlab),image(imi),ax,axis('off');title(['Filtered Image (',num2str(portot),'% of the coeffics.)'],'FontSize',8)
      set(fi,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
      kk=menu('¿Try again with the same image?','Yes','No (Return to the main menu)');
      clear MENU_VARIABLE
      if kk==1
         for i=1:fi
             figure(fi)
         end
         set(8,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
         set(14,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
         clear M12
      end
end
dos(['del ',path_data,'caca.mat'])