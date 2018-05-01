function demovq

% DEMOVQ Color quantization demo
%
% USE: demovq;

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
figure(2);clf;set(2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
   %   [f_igual,utri,Msx]=loadsysm('c:\matlab\toolbox\colorlab\colordat\systems\ciexyz');
   %   [coco,a,g]=loadmonm('c:\matlab\toolbox\colorlab\colordat\monitor\monito',Msx);
      
      p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);


      
      
clc   
disp(' ')
disp(' COLOR SPACE QUANTIZATION')
disp(' ')
disp('  Reducing the number of different colors in an image')
disp('  may be useful to increase the efficiency of color ')
disp('  processing algorithms.')
disp('  The problem is what colors to choose in order to ')
disp('  minimize the distortion of the image: this is the')
disp('  *palette selection problem*.')
disp(' ')
disp('  This problem is a vector quantization one:')
disp('  you have to describe a continuous (or dense) set')
disp('  using a restricted number of discrete vectors ')
disp('  (finite codebook)')
disp(' ')
disp('  (Press any key to continue...)')
pause 
clc   
disp(' ')
disp(' COLOR SPACE QUANTIZATION')
disp(' ')
disp('  The color space quantization consists of two different')
disp('  problems:')
disp('  - Choosing the vectors (colors) of the codebook. ')
disp('  - Defining the boundaries between the quantization') 
disp('    regions corresponding to each color of the codebook.')
disp('   ')
disp('  The solution to each problem needs an appropriate ')
disp('  distance measure in the color space or an appropriate')
disp('  euclidean space.')
disp(' ')
disp('  (Press any key to continue...)')
pause
clc
disp(' COLOR SPACE QUANTIZATION')
disp(' ')
disp('  In this demo we see the effect of different ')
disp('  (uniform and non-uniform) techniques to solve ')
disp('  the problem using euclidean measures in different ')
disp('  color spaces.')
disp(' ')
disp('  Press any key to LOAD THE IMAGE...')
pause
clc

cd([path_data,'images\images'])
[fich,tray]=uigetfile('*.*','Load *.jpg or *.tif images');
[im,pal]=imread([tray,fich]);

if isempty(pal)
   [im,pal]=true2pal(im,256);
elseif length(pal(:,1))>256
   im=pal2true(im,pal);
   [im,pal]=true2pal(im,256);
end

Tx=val2tri(pal,utri,coco,a,g);


kk=1;
while kk==1
      %[f_igual,utri,Msx]=loadsysm('c:\matlab\toolbox\colorlab\colordat\systems\ciexyz');
      %[coco,a,g]=loadmonm('c:\matlab\toolbox\colorlab\colordat\monitor\monito',Msx);
      %Tx=val2tri(pal,utri,coco,a,g);
      clc  
      M12=menu('Color space to select the vectors','Graphic definition of the basis','Numeric definition of the basis');
      if M12==1
        clc
        figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
        figure(2);clf;set(2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
        [M2X,M12,f_igual2,utri2,coco2]=defsys(1,f_igual,utri,Msx,coco);
                    p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
        sis1=0;
      else
        clc
        sis1=menu('Choose the representation:','Manual','YIQ','YUV','UVW','CIE L*a*b*','CIE L*u*v*','CIE RGB','CIE XYZ','NTSC RGB','Guth ATD');
        if sis1==1
           clc
           disp(' ')
           disp(' ')
           disp(' ')
           disp('    Introduce the *change-of-basis* matrix:')     
           disp('    [a11 a12 a13;a21 a22 a23;a31 a32 a33]') 
           M12=input('    ');
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
        elseif sis1==2
           M12=[0 1 0;1.407 -0.832 -0.45;0.9 -1.189 0.233];
          [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==3
           Myuvxyz=[0.967 0.235 0.591;1 0 0;1.173 2.244 -0.020];
           M12=inv(Myuvxyz);
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==4
           M12=[0.667 0 0;0 1 0;-0.5 1.5 0.5];
           
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==5
           TT=xyz2lab(Tx,[150 150 150]);
        elseif sis1==6
           TT=xyz2luv(Tx,[150 150 150]);
        elseif sis1==7
           M12=[2.365 -0.897 -0.468;-0.515 1.426 0.089;0.005 -0.014 1.009];
           
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==8
           M12=[1 0 0;0 1 0;0 0 1];
           
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==9
           M12=[1.910 -0.532 -0.288;-0.985 2 -0.028;0.058 -0.118 0.898];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);

        elseif sis1==10
           %[atd1,TT]=xyz2atd(Tx,6,[0 0 0],[1 0.5],2,0,300);
           [atd1,TT]=xyz2atd(Tx,11);
           
           [atd1,f_igual2]=xyz2atd(120*f_igual(:,2:4),11);
           f_igual2=[f_igual(:,1) f_igual2];
           M12=10;

           
        end
      end

      figure(1);clf;set(1,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
      figure(2);clf;set(2,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
      figure(3);clf;set(3,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
      figure(4);clf;set(4,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
      figure(5);clf;set(5,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
      figure(1),image(im),colormap(pal),ax,axis('off');
      figure(2),colordgm(Tx,1,f_igual,utri,coco);
      ncol=size(Tx);
      ncol=ncol(1);
      title(['Initial palette: ',num2str(ncol),' colors'],'FontSize',8)
      if (sis1~=5)&(sis1~=6)&(sis1~=10)
         
         TT=val2tri(pal,utri2,coco2,a,g);

         Ymax=max(utri2(1)*f_igual2(:,2)+utri2(2)*f_igual2(:,3)+utri2(3)*f_igual2(:,4));
         f_igualre=150*f_igual2(:,2:4)/Ymax;
         rango1=maxi(f_igualre(:,1))-mini(f_igualre(:,1));
         rango2=maxi(f_igualre(:,2))-mini(f_igualre(:,2));
         rango3=maxi(f_igualre(:,3))-mini(f_igualre(:,3));
         m1=mini(f_igualre(:,1))-0.05*rango1;
         M1=maxi(f_igualre(:,1))+0.05*rango1;
         m2=mini(f_igualre(:,2))-0.05*rango2;
         M2=maxi(f_igualre(:,2))+0.05*rango2;
         m3=mini(f_igualre(:,3))-0.05*rango3;
         M3=maxi(f_igualre(:,3))+0.05*rango3;
         %colorene([TT;f_igualre],1,0,f_igual2,utri2,coco2,0,0,3,1,[m1 M1 m2 M2 m3 M3],[100 30]);
         
  symb='o';
  lim_axis=0;
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=0;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  fontsizes=[10 12 1.5 8];
 
Ymax0=max(Tx(:,2));

figure(3),%colorspc([TT;f_igualre],1,f_igual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

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

colorspc([TT;f_igualre],1,f_igual,utri,'symb','o','sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)
         
         title(['Initial palette: ',num2str(ncol),' colors'],'FontSize',8)
      else
         Ymax=max(utri(1)*f_igual(:,2)+utri(2)*f_igual(:,3)+utri(3)*f_igual(:,4));
         f_igualre=150*f_igual(:,2:4)/Ymax;
         if sis1==5
            f_igualre=xyz2lab(f_igualre,[150 150 150]);
         elseif sis1==6
            f_igualre=xyz2luv(f_igualre,[150 150 150]);
         else
            %[atd1,f_igualre]=xyz2atd(f_igualre,6,[0 0 0],[1 0.5],2,0,300);
            [atd1,f_igualre]=xyz2atd(f_igualre,11);

         end 
         rango1=maxi(f_igualre(:,1))-mini(f_igualre(:,1));
         rango2=maxi(f_igualre(:,2))-mini(f_igualre(:,2));
         rango3=maxi(f_igualre(:,3))-mini(f_igualre(:,3));
         m1=mini(f_igualre(:,1))-0.05*rango1;
         M1=maxi(f_igualre(:,1))+0.05*rango1;
         m2=mini(f_igualre(:,2))-0.05*rango2;
         M2=maxi(f_igualre(:,2))+0.05*rango2;
         m3=mini(f_igualre(:,3))-0.05*rango3;
         M3=maxi(f_igualre(:,3))+0.05*rango3;
         
             symb='o';
  lim_axis=0;
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=0;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  fontsizes=[10 12 1.5 8];
 
Ymax0=max(Tx(:,2));

figure(3),%colorspc([TT;f_igualre],1,f_igual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

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

colorspc([TT;f_igualre],1,f_igual,utri,'symb','o','sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)


title(['Initial palette: ',num2str(ncol),' colors'],'FontSize',8)
      end
      %[im1,im2,im3]=palt2tri(im,TT);
      im3=pal2true(im,TT);
      clc 

      met=menu('Codebook design method:','Uniform scalar quantization','Minimum variance method');

      if met==1
         tt=0;
         while tt==0
               clc 
               disp('  UNIFORM SCALAR QUANTIZATION')
               disp(' ')
               disp('  Here you can select the density of the uniform')
               disp('  grid of codevectors using the number of samples')
               disp('  per dimension.')
               disp(' ')
               disp('    Introduce the number of samples per dimension');
               disp('    (Warning!: the final number of colors may be as ');
               disp('    large as N^3, so, in order to actually reduce the ');
               disp('    palette (and save CPU!), please choose N between');
               disp('    3 y 9');
               param=input('    Introduce N:   ');
               if isempty(param)
                  tt=0;
               else  
                  if (param>=2)&(param<=9)
                      param=1/(param-1);
                      tt=1;
                  else
                      tt=0;
                  end
               end
         end  
      else
         tt=0;
         while tt==0
               clc
               disp('  MINIMUM VARIANCE METHOD')
               disp(' ')
               disp('  Here the codebook is selected to minimize the')
               disp('  error (variance) of the training set using an euclidean')
               disp('  assignation and distance computation.')
               disp('  It is something like an LGB algorithm.')
               disp('  ')
               disp('  Introduce the number of colors you want')
               param=input('  (0 < N < 50):       ');
               if isempty(param)
                  tt=0;
               else
                  if (param>=1)&(param<=80)
                      param=param;
                      tt=1;
                  else
                      tt=0;
                  end
               end
         end
      end
      
      [imi,palt]=true2pal(im3,param);     
      clear im3
      if (sis1~=5)&(sis1~=6)&(sis1~=10)
         % paltx=cambibas(palt,inv(M12));
         paltx=newbasis(palt,inv(M12));
      elseif sis1==5
         paltx=lab2xyz(palt,[150 150 150]);
      elseif sis1==6
         paltx=luv2xyz(palt,[150 150 150]);
      else
         %paltx=atd2xyz(palt,2,6,[0 0 0],[1 0.5],2,0,300);
         paltx=atd2xyz(palt,2,11);
      end
      
      figure(4),colordgm(paltx,1,f_igual,utri,coco);

      ncol=size(paltx);
      ncol=ncol(1);
      title(['Reduced palette: ',num2str(ncol),' colors'],'FontSize',8)
      %colorene([palt;f_igualre],1,0,f_igual,utri,coco,0,0,5,1,[m1 M1 m2 M2 m3 M3],[100 30]);
      
        lim_axis=0;
  showvectors=0;
  show_lin=0;
  show_numb=0;
  showdiag=0;
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
  fontsizes=[10 12 1.5 8];
 
Ymax0=max(Tx(:,2));

figure(5),%colorspc([palt;f_igualre],1,f_igual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

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

colorspc([palt;f_igualre],1,f_igual,utri,'symb','o','sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)




      title(['Reduced palette: ',num2str(ncol),' colors'],'FontSize',8)

      repres=menu('Representation for asignation:','The same as before','Other repres.');

      if repres==1
         paltu=newbasis(paltx,[0.667 0 0;0 1 0;-0.5 1.5 0.5]);
         [f_igual3,utri3,M3X]=newconst([0.667 0 0;0 1 0;-0.5 1.5 0.5],f_igual,utri,[1 0 0;0 1 0;0 0 1]);
            p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);
                  
         fi=get(0,'Children');
         fi=max(fi)+1;
         figure(fi);clf;set(fi,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
         
         [nmat,satur,Tpos]=tri2val(paltu,utri3,coco3,a,g,8);
         figure(fi),colormap(nmat),image(imi),ax,axis('off')
      else
         clc
         M13=menu('Representation for asignation:','Graphic definition of the basis','Numeric definition of the basis');
         if M13==1
            clc
            figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
            figure(2);clf;set(2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
            [M3X,M13,f_igual3,utri3,coco3]=defsys(1,f_igual,utri,Msx,coco);
            p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

                    TT=val2tri(pal,utri3,coco3,a,g);
              TTr=newbasis(paltx,M13);
         
            im3=pal2true(im,TT);
            [imi,TTr]=true2pal(im3,TTr);

             fi=get(0,'Children');
             fi=max(fi)+1;
            [nmat,satur,Tpos]=tri2val(TTr,utri3,coco3,a,g,8);
            figure(fi),colormap(nmat),image(imi),ax,axis('off'),

           
         else
            sis1=menu('Choose representation:','Manual','YIQ','YUV','UVW','CIE L*a*b*','CIE L*u*v*','CIE RGB','CIE XYZ','NTSC RGB','Guth ATD');
            if sis1==1
               clc
               disp(' ')
               disp(' ')
               disp(' ')
               disp('    Introduce the *change-of-basis* matrix:')     
               disp('    [a11 a12 a13;a21 a22 a23;a31 a32 a33]')
               M13=input('    ');
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                       p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);
    
           elseif sis1==2
               M13=[0 1 0;1.407 -0.832 -0.45;0.9 -1.189 0.233];
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
            p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);
               
            elseif sis1==3
               Myuvxyz=[0.967 0.235 0.591;1 0 0;1.173 2.244 -0.020];
               M12=inv(Myuvxyz);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                           p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

            elseif sis1==4
               M13=[0.667 0 0;0 1 0;-0.5 1.5 0.5];
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                           p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

            elseif sis1==5
               TTr=xyz2lab(paltx,[150 150 150]);
               TT=xyz2lab(Tx,[150 150 150]);
            elseif sis1==6
               TTr=xyz2luv(paltx,[150 150 150]);
               TT=xyz2luv(Tx,[150 150 150]);
            elseif sis1==7
               M13=[2.365 -0.897 -0.468;-0.515 1.426 0.089;0.005 -0.014 1.009];
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                           p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

            elseif sis1==8
               M13=[1 0 0;0 1 0;0 0 1];
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                           p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

            elseif sis1==9
               M13=[1.910 -0.532 -0.288;-0.985 2 -0.028;0.058 -0.118 0.898];
               %[f_igual3,utri3,M3X,coco3]=cambiaco(M13,f_igual,utri,Msx,coco);
               [f_igual3,utri3,M3X]=newconst(M13,f_igual,utri,Msx);
                           p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);

            elseif sis1==10
               %[atd1,TTr]=xyz2atd(paltx,6,[0 0 0],[1 0.5],2,0,300);
               %[atd1,TT]=xyz2atd(Tx,6,[0 0 0],[1 0.5],2,0,300);
               [atd1,TT]=xyz2atd(Tx,11);
               [atd1,TTr]=xyz2atd(paltx,11);
               M13=10;
               
            end
            if (sis1~=5)&(sis1~=6)&(sis1~=10)
               
               TT=val2tri(pal,utri3,coco3,a,g);
               TTr=newbasis(paltx,M13);
            end
            %[im1,im2,im3]=palt2tri(im,TT);
            im3=pal2true(im,TT);
            [imi,TTr]=true2pal(im3,TTr);
            %[imi,TTr]=tri2palt(im1,im2,im3,TTr);
            if (sis1~=5)&(sis1~=6)&(sis1~=10)
               TTrx=newbasis(TTr,inv(M13));
            elseif sis1==5
               TTrx=lab2xyz(TTr,[150 150 150]);
            elseif sis1==6
               TTrx=luv2xyz(TTr,[150 150 150]);
            else
               %TTrx=atd2xyz(TTr,2,6,[0 0 0],[1 0.5],2,0,300);
               TTrx=atd2xyz(TTr,2,11);
            end
            fi=get(0,'Children');
            fi=max(fi)+1;
            figure(fi);clf;set(fi,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
            TTru=newbasis(TTrx,[0.667 0 0;0 1 0;-0.5 1.5 0.5]);
            [f_igual3,utri3,M3X]=newconst([0.667 0 0;0 1 0;-0.5 1.5 0.5],f_igual,utri,[1 0 0;0 1 0;0 0 1]);
            p=which('std_crt.mat');
           [coco3,a,g]=loadmonm(p,M3X);
            
            %[f_igual3,utri3,M3X,coco3]=cambiaco([0.667 0 0;0 1 0;-0.5 1.5 0.5],f_igual,utri,[1 0 0;0 1 0;0 0 1],coco);
            %[nmon,nmat,satur,Tpos]=tri2niv4(coco3,utri3,a,g,1,TTru);
            [nmat,satur,Tpos]=tri2val(TTru,utri3,coco3,a,g,8);
            figure(fi),colormap(nmat),image(imi),ax,axis('off'),
         end 
         
      end 
      kk=menu('¿Try again with the same image?','Yes','No (return to the main menu)');
      if kk==1
         set(fi,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
         clear M12
      end
end
clc