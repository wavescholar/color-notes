function [lpy,Ymax0,s_lum,s_pur,txtlum2,txtpur2,im]=demosat()

% DEMOSAT Demo de variación de la luminancia
% y la saturación.
%
% USO: [lpy,Ymax0,s_lum,s_pur,txtlum2,txtpur2,im]=demosat;

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
figure(2);clf;set(2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
figure(3);
figure(4);
figure(5);
delete(3);
delete(4);
delete(5);

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

clc
clc
disp(' ')
disp(' EDITING THE LUMINANCE AND THE')
disp(' PURITY OF A COLOR IMAGE')
disp(' ')
disp('  In this demo you can change the luminance and')
disp('  the purity of a color image.')
disp('  You will see the effect of the luminance on the')
disp('  lenght of the tristimulus vectors and')
disp('  the perceptual effect of chromatic purity.')
disp(' ')
disp('  (Press any key to select the image...)')
pause
clc


cd([path_data,'images\images'])
[fich,tray]=uigetfile('*.*','Load *.jpg or *.tif images');
[im,pal]=imread([tray,fich]);

if isempty(pal)
   [im,pal]=true2pal(im,40);
elseif length(pal(:,1))>40
   im=pal2true(im,pal);
   [im,pal]=true2pal(im,40);
end

Tx=val2tri(pal,utri,coco,a,g);

lpy=coor2lp(tri2coor(Tx,utri),2,f_igual,utri);

figure(1);clf;set(1,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
figure(2);clf;set(2,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
figure(3);clf;set(3,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
figure(4);clf;set(4,'Position',[0.005*an 0.0533*al 0.49*an 0.4*al]);
figure(5);clf;set(5,'Position',[0.505*an 0.0533*al 0.49*an 0.4*al]);
figure(6);clf;set(6,'Position',[0.005*an 0.0533*al 0.49*an 0.4*al]);
figure(7);clf;set(7,'Position',[0.505*an 0.0533*al 0.49*an 0.4*al]);

%[paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri,a,g,coco,Tx,0,0,0,f_igual,0,0,0,1);

figure(1),colormap(pal),image(im)
figure(4),colordgm(Tx,1,f_igual,utri,coco);
%figure(5),colorspc(Tx/20,1,f_igual,utri,coco);

%   symb='o';
%   lim_axis=0;
%   showvectors=0;
%   show_lin=0;
%   show_numb=0;
%   showdiag=1;
%   showtriang=3;
%   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
%   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
%   linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
%   fontsizes=[10 12 1.5 8];
 
Ymax0=max(Tx(:,2));

figure(5),%colorspc(Tx/50,1,f_igual,utri,coco,symb,[0 Ymax0 0 Ymax0 0 Ymax0]/50,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

  symb='o';
  lim_axis=0;
  showvectors=1;
  show_lin=0;
  show_numb=1;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 1.5 8];
  
  
%colorspc([0.9*masimo 0.9*masimo 0.9*masimo;50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,figual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

colorspc(Tx/50,1,f_igual,utri,'symb','o','lim_axis',[0 Ymax0 0 Ymax0 0 Ymax0]/50,'sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)


Pmed=mean(lpy(:,2));
% colorene(2.2*Tx/Ymax0,1,1,f_igual,utri,coco,0,0,5,1,[0 2.5 0 2.5 0 2.5],[100 30]);

Ymax=Ymax0;
lum=Ymax0;
pur=Pmed;
aann=0.3225*an;
aall=0.4*al;
txtlum1=uicontrol(3,'Style','text','Position',[(1/9)*aann 0.42*aall (1-(2/9))*aann 0.15*aall],'String','    Maximum Luminance    ');
txtpur1=uicontrol(3,'Style','text','Position',[(1/9)*aann 0.76*aall (1-(2/9))*aann 0.15*aall],'String',' Average Chromatic Purity');
s_lum=uicontrol(3,'Style','slider','Position',[(1/9)*aann 0.25*aall (1-(2/9))*aann 0.09*aall],'Min',5,'Max',200,'Value',Ymax);
s_pur=uicontrol(3,'Style','slider','Position',[(1/9)*aann 0.59*aall (1-(2/9))*aann 0.09*aall],'Min',0.01,'Max',1,'Value',Pmed);
sl=[num2str(get(s_lum,'Val')),' (cd/m2)'];
sp=num2str(get(s_pur,'Val'));
txtlum2=uicontrol(3,'Style','text','Position',[(1/9)*aann 0.35*aall (1-(2/9))*aann 0.15*aall],'String',sl);
txtpur2=uicontrol(3,'Style','text','Position',[(1/9)*aann 0.69*aall (1-(2/9))*aann 0.15*aall],'String',sp);
h1=uicontrol(3,'Style','push','Position',[(1/9)*aann 0.065*aall (2/6)*aann 0.15*aall],'String','Apply','Callback',['lpy=aplica(im,lpy,Ymax0,s_lum,s_pur,txtlum2,txtpur2);']);
h2=uicontrol(3,'Style','push','Position',[(0.5+1/9)*aann 0.065*aall (2/6)*aann 0.15*aall],'String','Quit','Callback','clear;close(3)');