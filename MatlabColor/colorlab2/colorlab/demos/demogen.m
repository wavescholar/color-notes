function 


% DEMOGEN Demo de generación de colores 
%
% USO: demogen


clc
disp(' Color Generation with the CRT')
disp(' ')
disp('  Here we check the performance of the CRT')
disp('  according to the calibration done with CALIBRAT')
disp('  We can use ANY tristimulus color representation to')
disp('  choose the color we want in ANY color basis')
disp(' ')
disp('  (Press any key to continue...)')
pause

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
figure(2);clf;set(2,'Position',[0.67*an 0.0533*al 0.3225*an 0.4733*al]);
figure(3);
figure(4);
figure(5);
figure(6);
delete(3);
delete(4);
delete(5);
delete(6);
%[f_igual,utri,Msx]=loadsysm('c:\matlab\toolbox\colorlab\colordat\systems\ciexyz');
%[coco,a,g]=loadmonm('c:\matlab\toolbox\colorlab\colordat\monitor\monito',Msx);

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

clc

%[M2X,M12,f_igual2,utri2,coco2]=defsysg(1,f_igual,utri,Msx,coco,1,1);
figure(1)
[M2X,M12,f_igual2,utri2,coco2]=defsys(1,f_igual,utri,Msx,coco);

Ymax=max(utri(1)*f_igual(:,2)+utri(2)*f_igual(:,3)+utri(3)*f_igual(:,4));
f_igualre=[f_igual2(:,1) 1.22*f_igual2(:,2:4)/Ymax];

rango1=maxi(f_igualre(:,1+1))-mini(f_igualre(:,1+1));
rango2=maxi(f_igualre(:,2+1))-mini(f_igualre(:,2+1));
rango3=maxi(f_igualre(:,3+1))-mini(f_igualre(:,3+1));

m1=mini(f_igualre(:,1+1))-0.05*rango1;
M1=maxi(f_igualre(:,1+1))+0.05*rango1;

m2=mini(f_igualre(:,2+1))-0.05*rango2;
M2=maxi(f_igualre(:,2+1))+0.05*rango2;

m3=mini(f_igualre(:,3+1))-0.05*rango3;
M3=maxi(f_igualre(:,3+1))+0.05*rango3;

k=0;
while k==0
      clc
      disp(' Choose the color!')
      disp(' ')
      disp('  opt=1........(T1,T2,T3)')
      disp('  opt=2........(t1,t2, Y)')
      disp('  opt=3........(lambd,Pe,Y)')
      disp('  opt=4........(lambd,Pc,Y)')
      disp('  (Press 0 to quit)')
      colorino=input('  Enter [color opt]   ');
      if colorino==0
         k=1; 
      else
         if (length(colorino)==4)
            [nmon,tp]=tour4(colorino(1:3),colorino(4),utri2,coco2,a,g,f_igualre,1,[m1 M1 m2 M2 m3 M3],[100 20],1);
            clear nmon tp rango1 rango2 rango3 modmax
         end 
      end
end