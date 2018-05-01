
% Selecciona el CIEXYZ!!

startcol

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    %
% (Achromatic) Simultaneous Contrast %
%                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

backgr=[0.33 0.33 5;0.33 0.33 10;0.33 0.33 20;0.33 0.33 40;0.33 0.33 80;0.33 .33 160];
stimulus=[0.33 0.33 60];

Tb=coor2tri(backgr,Yw);
Ts=coor2tri(stimulus,Yw);

[palb,saturat,Tn]=tri2val(Tb,Yw,tm,a,g,8);
[pals,saturat,Tn]=tri2val(Ts,Yw,tm,a,g,8);

imb=[1 1 1;1 0 1;1 1 1];
ims=[0 0 0;0 7 0;0 0 0];

figure(1),colormap([palb;pals])
subplot(161),image((imb+0).*imb+ims),axis('off')
subplot(162),image((imb+1).*imb+ims),axis('off')
subplot(163),image((imb+2).*imb+ims),axis('off')
subplot(164),image((imb+3).*imb+ims),axis('off')
subplot(165),image((imb+4).*imb+ims),axis('off')
subplot(166),image((imb+5).*imb+ims),axis('off')

perceps=xyz2lab(ones(6,1)*Ts,Tb);

figure(2),plot(backgr(:,3),perceps(:,1)),xlabel('Y(C_{bkg})'),ylabel('J_{Lab}(C)=L^*(C)')

% Reproduction of the Heinemann experiment using CIE Lab 
% (asimetric matching of a test on a increasing luminance background using a test
% on a fixed background)
% 
% The observer has to select the luminance of a test in a fixed bakground of 15 cd/m2
% to match the lightness of the test on a increasing luminance bkgr.


fixedbgr=[0.33 0.33 15]; 
Tfb=coor2tri(fixedbgr,Yw); 
[palfb,saturat1,Tn]=tri2val(Tfb,Yw,tm,a,g,8); 

% Solution:
% Corresponding pairs of the previous percepts (the perceptions on the variable backgr.)
% using a fixed background

Tc=lab2xyz(perceps,Tfb);
[palc,saturat,Tn]=tri2val(Tc,Yw,tm,a,g,8);

imb=7*[1 1 1;1 0 1;1 1 1];
ims=[0 0 0;0 1 0;0 0 0];

figure(3),colormap([palc;palfb])
subplot(161),image((ims+0).*ims+imb),axis('off')
subplot(162),image((ims+1).*ims+imb),axis('off')
subplot(163),image((ims+2).*ims+imb),axis('off')
subplot(164),image((ims+3).*ims+imb),axis('off')
subplot(165),image((ims+4).*ims+imb),axis('off')
subplot(166),image((ims+5).*ims+imb),axis('off')

figure(4),plot(backgr(:,3),Tc(:,2)),xlabel('Y(C_{bkg})'),ylabel('Y_C(C_{ref})')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   %
% (chromatic) Simultaneous Contrast %
%                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ld=575;
Pm=0.85;
Y=70;

midP=0.7;

backgr1=[ld*ones(6,1) linspace(0.07,Pm,6)' Y*ones(6,1)];
stimulus=[ld 0 Y];

backgr=lp2coor(backgr1,1,T_l,Yw);
stimulus=lp2coor(stimulus,1,T_l,Yw);

Tb=coor2tri(backgr,Yw);
Ts=coor2tri(stimulus,Yw);

[palb,saturat,Tnb]=tri2val(Tb,Yw,tm,a,g,8);
[pals,saturat,Tn]=tri2val(Ts,Yw,tm,a,g,8);

imb=[1 1 1;1 0 1;1 1 1];
ims=[0 0 0;0 7 0;0 0 0];

figure(5),colormap([palb;pals])
subplot(161),image((imb+0).*imb+ims),axis('off')
subplot(162),image((imb+1).*imb+ims),axis('off')
subplot(163),image((imb+2).*imb+ims),axis('off')
subplot(164),image((imb+3).*imb+ims),axis('off')
subplot(165),image((imb+4).*imb+ims),axis('off')
subplot(166),image((imb+5).*imb+ims),axis('off')

perceps=xyz2lab(ones(6,1)*Ts,Tb);
perceps2=lab2perc(perceps);

  symb='o';
  show_lin=1;
  show_numb=0; 
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 2 8];
  figure(6),colordgm(Tnb,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);hold on
  symb='^';
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0 0 .6;0 0 0.6;0.5 0.4 0];
  fontsizes=[10 12 3 8];
  colordgm(Ts,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

figure(7),plot(backgr1(:,2),perceps2(:,3)),xlabel('P(C_{bkg})'),ylabel('Croma_{Lab}(C)  =  ({a^*(C)}^2+{b^*(C)}^2)^{1/2}')

% Reproduction of the (chromatic) Heinemann experiment using CIE Lab 
% (asimetric matching of a test on a increasing (yellow) purity background using a test
% on a fixed yellow background of mid-purity)
% 
% The observer has to select the chromaticity of a test in a fixed bakground of mid-purity
% yellow to match the lightness of the test on a increasing purity bkgr.


fixedbgr1=[ld midP Y]; 
fixedbgr=lp2coor(fixedbgr1,1,T_l,Yw);
Tfb=coor2tri(fixedbgr,Yw); 
[palfb,saturat1,Tn]=tri2val(Tfb,Yw,tm,a,g,8); 

% Solution:
% Corresponding pairs of the previous percepts (the perceptions on the variable backgr.)
% using a fixed background

Tc=lab2xyz(perceps,Tfb);
[palc,saturat,Tn]=tri2val(Tc,Yw,tm,a,g,8);

imb=7*[1 1 1;1 0 1;1 1 1];
ims=[0 0 0;0 1 0;0 0 0];

figure(8),colormap([palc;palfb])
subplot(161),image((ims+0).*ims+imb),axis('off')
subplot(162),image((ims+1).*ims+imb),axis('off')
subplot(163),image((ims+2).*ims+imb),axis('off')
subplot(164),image((ims+3).*ims+imb),axis('off')
subplot(165),image((ims+4).*ims+imb),axis('off')
subplot(166),image((ims+5).*ims+imb),axis('off')

  symb='o';
  show_lin=1;
  show_numb=0; 
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 2 8];
  figure(9),colordgm(Tfb,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);hold on
  symb='^';
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0 0 0.6;0 0 0.6;0.5 0.4 0];
  fontsizes=[10 12 3 8];
  colordgm(Tn,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
% (Acromatic) Crispening effect %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ld=575;
Pm=0.85;

Y1=36;
Y2=45;
Y=[5 10 20 39.5 80 160]';

stimul1=[ld 0 Y1];
stimul2=[ld 0 Y2];
backgrd=[ld*ones(6,1) 0*ones(6,1) Y];

stim=lp2coor([stimul1;stimul2],1,T_l,Yw);
bgrd=lp2coor(backgrd,1,T_l,Yw);

Tb=coor2tri(bgrd,Yw);
Ts=coor2tri(stim,Yw);

[palb,saturat,Tnb]=tri2val(Tb,Yw,tm,a,g,8);
[pals,saturat,Tns]=tri2val(Ts,Yw,tm,a,g,8);

imb=[1 1 1 1 1;1 0 1 0 1;1 1 1 1 1];
ims=[0 0 0 0 0;0 7 0 8 0;0 0 0 0 0];

figure(10),colormap([palb;pals])
subplot(161),image((imb+0).*imb+ims),axis('off')
subplot(162),image((imb+1).*imb+ims),axis('off')
subplot(163),image((imb+2).*imb+ims),axis('off')
subplot(164),image((imb+3).*imb+ims),axis('off')
subplot(165),image((imb+4).*imb+ims),axis('off')
subplot(166),image((imb+5).*imb+ims),axis('off')

perceps=xyz2lab([Tns;Tns;Tns;Tns;Tns;Tns],[Tnb(1,:);Tnb(1,:);Tnb(2,:);Tnb(2,:);Tnb(3,:);Tnb(3,:);Tnb(4,:);Tnb(4,:);Tnb(5,:);Tnb(5,:);Tnb(6,:);Tnb(6,:)]);

difsY=Y-Y1;
difsP=[perceps(1,1)-perceps(2,1) perceps(3,1)-perceps(4,1) perceps(5,1)-perceps(6,1) perceps(7,1)-perceps(8,1) perceps(9,1)-perceps(10,1) perceps(11,1)-perceps(12,1)];

figure(11),plot(difsY,difsP),xlabel('Y_{bkgrd}-Y_{test}'),ylabel('\Delta L^*')



%%%%%%%%%%%%%%%%%%%%%%%
%                     %
% Stevens - Bartleson %
%                     %
%%%%%%%%%%%%%%%%%%%%%%%

ld=575;
Pm=0.85;

Y1=10;
Y2=70;
Y=[5 60 120]';

stimul1=[ld 0 Y1];
stimul2=[ld 0 Y2];
backgrd=[ld*ones(3,1) 0*ones(3,1) Y];

stim=lp2coor([stimul1;stimul2],1,T_l,Yw);
bgrd=lp2coor(backgrd,1,T_l,Yw);

Tb=coor2tri(bgrd,Yw);
Ts=coor2tri(stim,Yw);

[palb,saturat,Tnb]=tri2val(Tb,Yw,tm,a,g,8);
[pals,saturat,Tns]=tri2val(Ts,Yw,tm,a,g,8);

imb=[1 1 1 1 1;1 0 1 0 1;1 1 1 1 1];
ims=[0 0 0 0 0;0 4 0 5 0;0 0 0 0 0];

figure(12),colormap([palb;pals])
subplot(131),image((imb+0).*imb+ims),axis('off')
subplot(132),image((imb+1).*imb+ims),axis('off')
subplot(133),image((imb+2).*imb+ims),axis('off')
%subplot(164),image((imb+3).*imb+ims),axis('off')
%subplot(165),image((imb+4).*imb+ims),axis('off')
%subplot(166),image((imb+5).*imb+ims),axis('off')

perceps=xyz2lab([Tns;Tns;Tns;Tns;Tns;Tns],[Tnb(1,:);Tnb(1,:);Tnb(2,:);Tnb(2,:);Tnb(3,:);Tnb(3,:);Tnb(4,:);Tnb(4,:);Tnb(5,:);Tnb(5,:);Tnb(6,:);Tnb(6,:)]);

difsY=Y-Y1;
difsP=[perceps(1,1)-perceps(2,1) perceps(3,1)-perceps(4,1) perceps(5,1)-perceps(6,1) perceps(7,1)-perceps(8,1) perceps(9,1)-perceps(10,1) perceps(11,1)-perceps(12,1)];

figure(11),plot(difsY,difsP),xlabel('Y_{bkgrd}-Y_{test}'),ylabel('\Delta L^*')

