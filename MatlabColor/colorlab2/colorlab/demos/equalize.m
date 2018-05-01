
% Here we are going to change the appearance of a poorly scanned 
% color image in 2 ways:
% 
% (1) We want to increase the luminance of dark colors and increase
%     the saturation of the scene
% 
%     We will use a simple approach:
%     - Express the palette in Dominant Wavelength, Purity and Luminance
%     - Equalize the luminance (using an exponential non-linearity)
%     - Equalize the saturation (using an exponential non-linearity)
% 
% (2) Now we want to change the hue of the background
%     - We will change the dominant wavelength of the colors in the blue
%       region (adding some constant to the values in the region [380-500]nm)

% Load system data and monitor data to start working with Colorlab
%
% (In particular we are going to choose the CIE XYZ system)

startcol

% Load the image

im=imread('c:\matlab\toolbox\colorlab\colordat\images\images\matisse.jpg');

% Compute a palette of 50 colors (in digital values)

[imi,palette]=true2pal(im,50);

% Obtain the tristimulus vectors

T=val2tri(palette,Yw,tm,a,g); 

% Display the image and plot the colors

figure(1),imshow(imi,palette),title('Original Image')
figure(2),colordgm(T,1,T_l,Yw,tm);title('Original Colors')

symb='o';
lim_axis=[-0.3 4.5 -0.3 4.5 -0.3 4.5];
showvectors=0;
show_lin=0;
show_numb=0;
showdiag=1;
showtriang=3;
linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
sizes=[10 12 2 8];
figure(3)  
colorspc(5*T/110,1,T_l,Yw,tm,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
title('Original Colors')

%figure(3),colorspc(T,1,T_l,Yw,tm);title('Original Colors')

% Transform to dominant wavelength, purity and luminance

tY=tri2coor(T,Yw);
lpY=coor2lp(tY,1,T_l,Yw);

% Parameters for color processing

  % exponent for luminance equalization
    ex=0.65;
  % exponent for purity equalization
    pf=0.6;    

% Equalize the luminance

lpY2=lpY;
lpY2(:,3)=max(lpY(:,3))*(lpY(:,3).^ex)/(max(lpY(:,3)).^ex);

% Increase the purity

lpY2(:,2)=0.7*max(lpY(:,2))*(lpY(:,2).^pf)/(max(lpY(:,2)).^pf);

% Obtain the new palette

tY2=lp2coor(lpY2,1,T_l,Yw);
T2=coor2tri(tY2,Yw);
palette2=tri2val(T2,Yw,tm,a,g,8);

% Display the new image and colors

figure(4),imshow(imi,palette2),title('Equalized Image')

 % symb='o';
 % show_lin=0;
 % show_numb=0; 
 % showtriang=3;
 % linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
 % linewidths=1.5*[1 1 1 1 1 1];
 % linestyles=['- ';'- ';'- ';'- ';': ';'- '];
 % fontsizes=[14 14 4 8];
 %
 % figure(5),colordgm(T2,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
 
 figure(5),colordgm(T,1,T_l,Yw,tm);title('Equalized Colors')
  
  symb='o';
  lim_axis=[-0.3 4.5 -0.3 4.5 -0.3 4.5];
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 2 8];
  figure(6)
  colorspc(5*T2/110,1,T_l,Yw,tm,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
  title('Equalized Colors')
  
  % figure(6),clf;colorspc(T2,1,T_l,Yw,tm);title('New Colors')

% Turn blues into greens:

inc_l=80;

lpY3=lpY2;
lpY3(:,1)=inc_l.*((lpY2(:,1)>380)&(lpY2(:,1)<500))+lpY2(:,1);

% Obtain the new palette

tY3=lp2coor(lpY3,1,T_l,Yw);
T3=coor2tri(tY3,Yw);
palette3=tri2val(T3,Yw,tm,a,g,8);

% Display the new image and colors

figure(7),imshow(imi,palette3),title('New Image (changed hue)')

 % symb='o';
 % show_lin=0;
 % show_numb=0; 
 % showtriang=3;
 % linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
 % linewidths=1.5*[1 1 1 1 1 1];
 % linestyles=['- ';'- ';'- ';'- ';': ';'- '];
 % fontsizes=[14 14 4 8];
 %
 % figure(8),colordgm(T3,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
 figure(8),colordgm(T3,1,T_l,Yw,tm);title('New Colors (changed hue)')


  %figure(8),colordgm(T3,1,T_l,Yw,tm);%title('New Colors (changed hue)')
  %figure(9),clf;colorspc(T3,1,T_l,Yw,tm);%title('New Colors (changed hue)')
  
  symb='o';
  lim_axis=[-0.3 4.5 -0.3 4.5 -0.3 4.5];
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=1;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  sizes=[10 12 2 8];
  figure(9)
  colorspc(5*T3/110,1,T_l,Yw,tm,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
  title('New Colors (changed hue)')
  
  print -f1 -dtiff c:\colorlab\imo.tif
  print -f2 -dtiff c:\colorlab\diago.tif
  print -f3 -dtiff c:\colorlab\spaceo.tif
  print -f4 -dtiff c:\colorlab\ime.tif
  print -f5 -dtiff c:\colorlab\diage.tif
  print -f6 -dtiff c:\colorlab\spacee.tif
  print -f7 -dtiff c:\colorlab\imh.tif
  print -f8 -dtiff c:\colorlab\diagh.tif
  print -f9 -dtiff c:\colorlab\spaceh.tif
  
  
%%%%%%%%%%%%%%%%%%%%%%%%
% Now lets take Marilyn and change the hue of the sheet

im2=imread('d:\usuarios_p\jesus\art\pictures\marilyn.jpg');
% Compute the palette (in digital values)

[imm,pal]=true2pal(im2,100);

% Obtain the tristimulus vectors

Tm=val2tri(pal,Yw,tm,a,g); 

% Display the image and plot the colors

figure(10),imshow(imm,pal),title('Original Image')
figure(11),colordgm(Tm,1,T_l,Yw,tm);title('Original Colors')
figure(12),colorspc(Tm,1,T_l,Yw,tm);title('Original Colors')

% Transform to dominant wavelength, purity and luminance

tYm=tri2coor(Tm,Yw);
lpYm=coor2lp(tYm,1,T_l,Yw);

% Turn saturated reds into browns:

inc_l=-20;

lpYm2=lpYm;
lpYm2(:,1)=inc_l.*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm(:,1);
lpYm2(:,2)=0.7*lpYm2(:,2).*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm2(:,2).*(((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))==0);
lpYm2(:,3)=1*lpYm2(:,3).*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm2(:,3).*(((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))==0);

% Obtain the new palette

tYm2=lp2coor(lpYm2,1,T_l,Yw);
Tm2=coor2tri(tYm2,Yw);
palettem2=tri2val(Tm2,Yw,tm,a,g,8);

% Display the new image and colors

figure(13),imshow(imm,palettem2),title('New Image (changed hue)')
figure(14),colordgm(Tm2,1,T_l,Yw,tm);title('New Colors (changed hue)')
figure(15),clf;colorspc(Tm2,1,T_l,Yw,tm);title('New Colors (changed hue)')


% Turn saturated reds into blueish-greens:

inc_l=-100;

lpYm2=lpYm;
lpYm2(:,1)=inc_l.*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm(:,1);
lpYm2(:,2)=0.35*lpYm2(:,2).*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm2(:,2).*(((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))==0);
lpYm2(:,3)=1.2*lpYm2(:,3).*((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))+lpYm2(:,3).*(((lpYm(:,1)>595)&(lpYm(:,1)<700)&(lpYm(:,2)>0.68))==0);

% Obtain the new palette

tYm2=lp2coor(lpYm2,1,T_l,Yw);
Tm2=coor2tri(tYm2,Yw);
palettem2=tri2val(Tm2,Yw,tm,a,g,8);

% Display the new image and colors

figure(16),imshow(imm,palettem2),title('New Image (changed hue)')
figure(17),colordgm(Tm2,1,T_l,Yw,tm);title('New Colors (changed hue)')
figure(18),clf;colorspc(Tm2,1,T_l,Yw,tm);title('New Colors (changed hue)')
