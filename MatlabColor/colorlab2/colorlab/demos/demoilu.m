function demoilu

% DEMOILU Demo de cambio de iluminación
% y luminancia.
%
% USO: demoilu

clc

%      [f_igual,utri,Msx]=loadsysm('c:\matlab\toolbox\colorlab\colordat\systems\ciexyz');
%      [coco,a,g]=loadmonm('c:\matlab\toolbox\colorlab\colordat\monitor\monito',Msx);
      
p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

eval(['load ',path_data,'\reflec\munsell'])

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
figure(3);clf;set(3,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
figure(4);clf;set(4,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
figure(5);clf;set(5,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
figure(1)
figure(2)

disp(' CHANGING THE ILLUMINANT')
disp(' ')
disp('  Here we transform an image into a mosaic')
disp('  where each pixel has a particular reflectance')
disp('  We can choose the relative spectrum of the illuminant')
disp('  and its luminance in (cd/m2)')
disp(' ')
disp('  (Press any key to continue...)')
pause
clc
k=0;

cd([path_data,'images\images'])
[fich,tray]=uigetfile('*.*','Load *.jpg or *.tif images');
[im,pal]=imread([tray,fich]);

if isempty(pal)
   [im,pal]=true2pal(im,40);
elseif length(pal(:,1))>40
   im=pal2true(im,pal);
   [im,pal]=true2pal(im,40);
end

T=val2tri(pal,utri,coco,a,g);
figure(4),colormap(pal),image(im)
figure(5)
%   symb='o';
%   show_lin=0;
%   show_numb=0; 
%   showtriang=3;
%   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
%   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
%   linestyles=['- ';'- ';'- ';'- ';': ';'- '];
%   fontsizes=[10 12 1.4 8];
%  
%   colordgm(T,1,f_igual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);


    symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  lincolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 4 8];
 
  %colordgm([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  colordgm(T,1,f_igual,utri,'symb','o','sizes',fontsizes,'showtriang',{3,coco},'linecolors',lincolors,'show_numb',0)

  
  
RT=tri2spec(T,reflec,[reflec(:,1) ones(length(reflec(:,1)),1)],200,f_igual,utri);

% [im,pal,im1,im2,im3,palre,ilumin]=carga(1,f_igual,utri,Msx,1,coco,a,g);
% [paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri,a,g,coco,pal,0,0,0,f_igual,1,0,1,4);

while k==0
   clc
   co=0;
   while co==0
         disp('')
         disp(' Luminance of the illuminant (cd/m2)') 
         disp(' (Press 0 to quit)  ')
         lum=input(' ');
         if isempty(lum)
            co=0;
         else
            co=1;
         end
   end
   if lum~=0
      clc
      figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
      figure(2);clf;set(2,'Position',[0.67*an 0.0533*al 0.3225*an 0.4733*al]);
      espec=defillu(lum,1,10,f_igual,utri,1);      
      figure(1);set(1,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
      figure(2);clf;set(2,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
      
      %[T2,RR]=spec2tri(3,f_igual,10,RT,espec,lum,utri);
      
      [T2,RR]=spec2tri(f_igual,10,RT,espec,lum,utri);
      
      [n,saturat,Tn]=tri2val(T2,utri,coco,a,g,8);
      figure(2),colormap(n),image(im)
      
      figure(3)
%   symb='o';
%   show_lin=0;
%   show_numb=0; 
%   showtriang=3;
%   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
%   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
%   linestyles=['- ';'- ';'- ';'- ';': ';'- '];
%   fontsizes=[10 12 1.4 8];
%  
%   colordgm(T2,1,f_igual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

    symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  lincolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 4 8];
 
  %colordgm([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  colordgm(T2,1,f_igual,utri,'symb','o','sizes',fontsizes,'showtriang',{3,coco},'linecolors',lincolors,'show_numb',0)
  
  
      
      % [paltreq,paltpos,imind,nmat,sat]=pincol4(3,im,0,0,0,utri,a,g,coco,palre,0,espec,lum,f_igual,1,0,1,2);
      
   else
      k=1;
   end
end