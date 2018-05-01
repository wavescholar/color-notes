function demored

% DEMORED calcula red ATD (Guth 80) oscilando respecto de 
% un color [x y Y] con amplitudes segun porcentajes de ATD
%
% demored(frecuencia,orientacion,[x y Y],[%A %T %D])

disp('  GENERACION DE REDES CROMATICAS EN')
disp('  EL ESPACIO ATD (Guth 95)')
disp(' ')
disp('  Podemos elegir la frecuencia (en cycl/deg),')
disp('  la orientación (en deg) el color promedio:')
disp('  color respecto del que se oscila ([x y Y]),')
disp('  y las amplitudes de la oscilación en cada canal')
disp('  en porcentajes respecto de los valores ATD del')
disp('  promedio.')
disp('  ')
disp('  Pulsa cualquier tecla...')
pause
clc
disp(' ')
disp(' ')
disp('    Introduce los datos de la red:')     
disp('    [frecuencia orientacion x y Y %A %T %D]')
disp(' ')
datos=input('    ');

%fondo en ATD
XYZ=coor2tri(datos(3:5),[0 1 0]);
[atd1,atd2]=xyz2atd(XYZ,6,[0 0 0],[1 0],2,0,300);

%calculo de la red ATD
[red,ATDc,ATDg,XYZc,XYZg,ni,Ac,Ag]=redatd(64,256,atd2,atd2.*datos(6:8)/100,datos(1)*[1 1 1],datos(2)*[1 1 1],[0 0 0],256,6,[0 0 0],[1 0],2,0,300,1);

close(6)
close(7)
close(8)
close(9)
close(10)
close(11)

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);

close(1)
figure(1);set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
figure(1),colormap(ni/64),image(red),ax,axis('off')
figure(3);set(3,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
figure(5);set(5,'Position',[0.67*an 0.0533*al 0.3225*an 0.4*al]);
figure(2);set(2,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
figure(4);set(4,'Position',[0.67*an 0.0533*al 0.3225*an 0.4*al]);
