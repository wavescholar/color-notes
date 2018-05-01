startcol

% MOTIVATING THE STUDY OF RELATED COLORS 
% 
% In this demo we see a couple of things:
%   
%   (1)- the ability of HVS to recognize object properties
%        (for instance, reflectances) only occurs in complex 
%        backgrounds (when seeing related colors and 
%        induction takes place). 
%
%   (2)- The difference between Brightness, Q, 
%        (absolute judgement of perceived light) 
%        and Lightness, J (relative judgement of perceived
%        light) 
% 
% We show samples of different reflectances under different 
% illuminations in two ways: 
% 
%  - Single sample image (unrelated colors)
%  - Multiple sample image (related colors)
% 
% The samples are selected in such a way that limitations 
% of tristimulus colorimetry are emphasized, i.e. we see 
% that: 
% 
% - Despite two samples have the same vector T
%   (so they give rise to the same perception 
%    -Q, h, M-, when seen as unrelated colors),
%   their perception may differ when seen as related
%   colors in different backgrounds 
%   (Q, J, h, M, C change).
%
% - Despite two samples have different vectors T
%   (so they give rise to different perceptions when 
%   seen as unrelated colors), their perception
%   is similar (different Q) when 
%
% Besides we see the difference between J and Q:
% Increasing the illumination level we increase the brightness
% but lightness remains unchanged. 
% 
% In particular, we generate 2 stimuli that only differ in 
% luminance factor (a factor scale in their reflectance). 
% Therefore, any change in the illuminant will only generate  
% a luminance (and brightness) difference between them. 
% 
% The effects are general but we do it with a brown sample
% (low reflectance) and an orange sample (high reflectance)
% because the name we assign to these colors is different and 
% hence the effect is more spectacular.
%
% Load white, orange and brown reflectances choosen from the Munsell 
% using chromatic coordinates and luminace after beign illuminated 
% with an equienergetic illuminant.
% 
% Then load a set of reflectances whose hues cover the whole range of 
% hues. These samples will be used as complex background.

disp(' LOAD MUNSELL '),pause
R=loadrefl;

disp(' LOAD RAINBOW '),pause
R2=loadrefl;

disp(' DEFINE YOUR ILLUMINANT '),pause
esp=defillu(100,1,10,T_l,Yw,1);
espw=[esp(:,1) ones(length(esp(:,1)),1)];

% Select the reflectances from Munsell for white brown and orange
% illuminating with equienergetic
t=lp2coor([600 0.35 7;600 0.35 50;500 0 100],1,T_l,Yw);
T=coor2tri(t,Yw);
RT=tri2spec(T,R,espw,100,T_l,Yw);

% Add the rainbow-like reflectances
RR=[R2 RT(:,2:4)];

% Generate the images with the brown and orange samples in a white 
% proximal field a rainbow background
im1=[1 2 3 4 5;7 12 12 12 6;6 12 10 12 7;5 12 12 12 8;4 3 2 1 9];
im2=[1 2 3 4 5;7 12 12 12 6;6 12 11 12 7;5 12 12 12 8;4 3 2 1 9];

% Select the luminances 
Y1=150;
Y2=150*7/50;
[T1,lala]=spec2tri(3,T_l,10,RR,espw,Y1,Yw);
[T2,lala]=spec2tri(3,T_l,10,RR,espw,Y2,Yw);

[T3,lala]=spec2tri(3,T_l,10,RR,esp,Y1,Yw);
[T4,lala]=spec2tri(3,T_l,10,RR,esp,Y2,Yw);

[n1,saturat,Tn]=tri2val(T1,Yw,tm,a,g,8);
[n2,saturat,Tn]=tri2val(T2,Yw,tm,a,g,8);
[n3,saturat,Tn]=tri2val(T3,Yw,tm,a,g,8);
[n4,saturat,Tn]=tri2val(T4,Yw,tm,a,g,8);

whitebg('k')
figure(1),
set(1,'Color',[0.15 0.15 0.15])
subplot(221),imm1=pal2true(im1,n1),image(imm1),ax,axis('off'),title('well illuminated brown')
subplot(222),imm2=pal2true(im1,n2),image(imm2),ax,axis('off'),title('under illuminated brown')
subplot(223),imm3=pal2true(im2,n1),image(imm3),ax,axis('off'),title('well illuminated orange')
subplot(224),imm4=pal2true(im2,n2),image(imm4),ax,axis('off'),title('under illuminated orange')

disp(' Note that the under illuminated orange and')
disp(' the well illuminated brown actually have the same radiance')
disp(' (so they have the same tristimulus vector!)')

m=0.15;
n1g=m*ones(12,3);
n1g(10:11,:)=n1(10:11,:);

n2g=m*ones(12,3);
n2g(10:11,:)=n2(10:11,:);

figure(2),
set(2,'Color',[0.15 0.15 0.15])
subplot(221),imm1=pal2true(im1,n1g),image(imm1),ax,axis('off'),title('well illuminated brown')
subplot(222),imm2=pal2true(im1,n2g),image(imm2),ax,axis('off'),title('under illuminated brown')
subplot(223),imm3=pal2true(im2,n1g),image(imm3),ax,axis('off'),title('well illuminated orange')
subplot(224),imm4=pal2true(im2,n2g),image(imm4),ax,axis('off'),title('under illuminated orange')

print -f1 -dtiff c:\imag1.tif
print -f2 -dtiff c:\imag2.tif


figure(1),colormap(n1),image(im1),ax
figure(2),colormap(n2),image(im1),ax
figure(3),colormap(n1),image(im2),ax
figure(4),colormap(n2),image(im2),ax

figure(5),colormap(n3),image(im1),ax
figure(6),colormap(n4),image(im1),ax
figure(7),colormap(n3),image(im2),ax
figure(8),colormap(n4),image(im2),ax

figure(5),axis('off')
figure(6),axis('off')
figure(7),axis('off')
figure(8),axis('off')

print -f5 -dtiff c:\latex\emtex\texinput\proyecto\mar2c.tif
print -f6 -dtiff c:\latex\emtex\texinput\proyecto\mar2o.tif
print -f7 -dtiff c:\latex\emtex\texinput\proyecto\nar2c.tif
print -f8 -dtiff c:\latex\emtex\texinput\proyecto\nar2o.tif



