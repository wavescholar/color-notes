% Carga sistema XYZ

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

% Define reflectancia e iluminante

refl=defrefl([380 770],1);
esp=defillu(200,1,10,f_igual,utri,2);

% Define el sistema de primarios

figure(3)
[M2X,M12,f_igual2,utri2,coco2]=defsys(1,f_igual,utri,Msx,coco);

% Veamos los primarios y las nuevas funciones de igualación

[n,saturat,Tn]=tri2val(50*[1 0 0;0 1 0;0 0 1;1 1 1],utri2,coco2,a,g,8);
figure(4),colormap(n),image([1;2;3;4]),axis('off')

figure(5),plot(f_igual2(:,1),f_igual2(:,2),'r-',f_igual2(:,1),f_igual2(:,3),'g-',f_igual2(:,1),f_igual2(:,4),'b-'),xlabel('Wavelenght (nm)'),ylabel('Color Matching Functions')
axis([380 750 -1.6 3])

% Veamos el estímulo en la base definida...

[T,RR]=spec2tri(2,f_igual2,10,refl,esp);

[n2,saturat,Tn]=tri2val(T,utri2,coco2,a,g,8); 
figure(6),colormap(n2),image(1),axis('off')
%figure(7),colorspc([T;50*[1 0 0;0 1 0;0 0 1;1 1 1]],1,f_igual2,utri2,coco2);

figure(7)
  symb='o';
  lim_axis=[-1 5 -1 4 -1 5];
  showvectors=1;
  show_lin=0;
  show_numb=1;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 1.5 8];
  
masimo=100;
  
%colorspc([0.9*masimo 0.9*masimo 0.9*masimo;50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
%colorspc(5*[50*[1 0 0;0 1 0;0 0 1;1 1 1];T]/160,1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
colorspc(5*[(160/5)*[1 0 0;0 1 0;0 0 1;1 1 1];T]/160,1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);


  %symb='o';
  %show_lin=0;
  %show_numb=1; 
  %showtriang=3;
  %linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  %linewidths=1.5*[1 1 1 1 1 1];
  %linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  %fontsizes=[14 14 4 8];
% 
%  figure(8),colordgm([50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,f_igual2,utri2,coco2,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
  
  symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 3 8];
 
  figure(8),colordgm([50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,f_igual2,utri2,coco2,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

%
% Vale, ahora definamos otra base
%

figure(9)
[M3X,M23,f_igual3,utri3,coco3]=defsys(1,f_igual2,utri2,M2X,coco2);

[n3,saturat,Tn]=tri2val(50*[1 0 0;0 1 0;0 0 1;1 1 1],utri3,coco3,a,g,8);
figure(10),colormap(n3),image([1;2;3;4]),axis('off')

figure(11),plot(f_igual3(:,1),f_igual3(:,2),'r-',f_igual3(:,1),f_igual3(:,3),'g-',f_igual3(:,1),f_igual3(:,4),'b-'),xlabel('Wavelenght (nm)'),ylabel('New Color Matching Functions')
axis([380 750 -1.6 3])

% Veamos el estímulo en la nueva base...

T3=newbasis(T,M23);

[n33,saturat,Tn]=tri2val(T3,utri3,coco3,a,g,8); 
%figure(12),colormap(n33),image(1),axis('off')
%figure(7),colorspc([T;50*[1 0 0;0 1 0;0 0 1;1 1 1]],1,f_igual2,utri2,coco2);

figure(12)
  symb='o';
  lim_axis=[-1 5 -1 4 -1 5];
  showvectors=1;
  show_lin=0;
  show_numb=1;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 1.5 8];
  
masimo=100;
  
%colorspc([0.9*masimo 0.9*masimo 0.9*masimo;50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
%colorspc(5*[50*[1 0 0;0 1 0;0 0 1;1 1 1];T]/160,1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
colorspc(5*[(160/5)*[1 0 0;0 1 0;0 0 1;1 1 1];T3]/160,1,f_igual3,utri3,coco3,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);


  %symb='o';
  %show_lin=0;
  %show_numb=1; 
  %showtriang=3;
  %linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  %linewidths=1.5*[1 1 1 1 1 1];
  %linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  %fontsizes=[14 14 4 8];
% 
%  figure(8),colordgm([50*[1 0 0;0 1 0;0 0 1;1 1 1];T],1,f_igual2,utri2,coco2,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
  
  symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 3 8];
 
  figure(13),colordgm([50*[1 0 0;0 1 0;0 0 1;1 1 1];T3],1,f_igual3,utri3,coco3,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
