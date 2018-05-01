function [im1,im2,im3,TT,f_igual2,utri2,M2X,coco2,M12]=descom3(im,pal,f_igual,utri,Msx,coco,a,g)

% DESCOMP3 descompone la imagen de entrada (imagen indexada con paleta de 
% de niveles digitales) en tres imagenes triestimulo en el espacio
% de representacion que se quiera...
% 
% Lo hace como sigue: 
%
% - primero transforma la paleta de entrada en paleta triestimulo en el espacio XYZ 
%   
% - luego defines (manual o graficamente) el sistema de representacion a partir del XYZ 
%   (asumimos luminancia unidad para el nuevo blanco). 
%
% - por ultimo transforma la paleta en XYZ en la paleta en el nuevo espacio y genera las
%   imagenes triestimulo leyendo punto a punto a partir de la imagen indexada y la paleta  
%   triestimulo.  
%
% Hasta aqui hemos hablado de 'triestimulo', pero estan incluidas representaciones 
% no vectoriales (no triestimulo) como Lab, Luv, ATD...
%
% En cualquier caso, el programa devuelve las imagenes triestimulo y la nueva paleta,
% pero si ademas la nueva representacion es vectorial, da la matriz de cambio de base, 
% las nuevas funciones de igualacion del color, las nuevas unidades tricromaticas y las 
% coordenadas de los primarios del monitor en la nueva representacion.
%
% USO: [im1,im2,im3,pal_tries,f_igual2,utri2,M2X,coco2,M12]=descomp(im,pal,f_igual,utri,Msx,coco,a,g);


      %[f_igual,utri,Mxx,coco]=newconst(Msx,f_igual,utri,Msx,coco);
      [f_igual,utri,Mxx]=newconst(Msx,f_igual,utri,Msx);
      
      p=which('std_crt.mat');
      [coco,a,g]=loadmonm(p,Mxx);
      
      Tx=val2tri(pal,utri,coco,a,g);
          
      f_igual2=0;
      coco2=0;
      clc  
      meme=menu('Representation Space','Graphic Definition of the basis','Numeric definition of the basis');
      clear MENU_VARIABLE
      h=get(0,'Children');
      if length(h)>0
         h=max(h);  
      else
         h=0; 
      end 
      if meme==1
         clc
         
         pantalla=get(0,'Screensize');
         an=pantalla(3);
         al=pantalla(4);
        
         figure(h+1)
         set(h+1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
         [M2X,M12,f_igual2,utri2,coco2]=defsys(1,f_igual,utri,Msx,coco);
         
         %[M2X,M12,f_igual2,utri2,coco2]=defsysg(1,f_igual,utri,Msx,coco,h+1,1);
        
        h=get(0,'Children');
        h=max(h);
        close(h)
        TT=newbasis(Tx,M12);
      else
        clc
        sis1=menu('Choose a representation:','Manual','YIQ System','YUV System','UVW System','CIE L*a*b*','CIE L*u*v*','CIE RGB','CIE XYZ','NTSC RGB','ATD (Guth 95)','SVF space');
        clear MENU_VARIABLE 
        if sis1==1
           lala=1;
           while lala==1 
                 clc
                 disp(' ')
                 disp(' ')
                 disp(' ')
                 disp('    Enter a change-of-basis matrix:')
                 disp('    [a11 a12 a13;a21 a22 a23;a31 a32 a33]')
                 M12=input('    ');
                 if prod(size(M12))~=9
                    lala=1; 
                 else
                    lala=0;
                 end  
           end
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==2
           M12=[0 1 0;1.407 -0.832 -0.45;0.9 -1.189 0.233];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==3
           Myuvxyz=[0.967 0.235 0.591;1 0 0;1.173 2.244 -0.020];
           M12=inv(Myuvxyz);
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
           p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==4
           M12=[0.667 0 0;0 1 0;-0.5 1.5 0.5];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==5
           %Tref=max([Tx(:,2) Tx(:,2) Tx(:,2)]);
           %TT=xyz2lab(Tx,Tref);
           
           Ym=maxi(Tx(:,2));   
           TT=xyz2lab(Tx,[Ym Ym Ym]);
           f_igual2=xyz2lab(120*f_igual(:,2:4),[Ym Ym Ym]);
           f_igual2=[f_igual(:,1) f_igual2];
           % TT(:,1)=TT2(:,1);
           utri2=5;
           coco2=5;
           M2X=5;
           M12=5;
        elseif sis1==6
           %Tref=[Tx(:,2) Tx(:,2) Tx(:,2)];
           %TT=xyz2luv(Tx,Tref);
           Ym=maxi(Tx(:,2));            
           TT=xyz2luv(Tx,[Ym Ym Ym]);
           f_igual2=xyz2luv(120*f_igual(:,2:4),[Ym Ym Ym]);             
           f_igual2=[f_igual(:,1) f_igual2];
           %TT(:,1)=TT2(:,1); 
           utri2=6;
           coco2=6;
           M2X=6;
           M12=6;
        elseif sis1==7
           Mrcx=[2.7698 1.7567 1.1302;1 4.5907 0.0601;0 0.0565 5.5943];
           M12=inv(Mrcx);
           %M12=[2.365 -0.897 -0.468;-0.515 1.426 0.089;0.005 -0.014 1.009];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==8
           M12=[1 0 0;0 1 0;0 0 1];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==9
           M12=[1.910 -0.532 -0.288;-0.985 2 -0.028;0.058 -0.118 0.898];
           [f_igual2,utri2,M2X]=newconst(M12,f_igual,utri,Mxx);
            p=which('std_crt.mat');
           [coco2,a,g]=loadmonm(p,M2X);
           TT=newbasis(Tx,M12);
        elseif sis1==10
           [atd1,TT]=xyz2atd(Tx,11);
           
           [atd1,f_igual2]=xyz2atd(120*f_igual(:,2:4),11);
           f_igual2=[f_igual(:,1) f_igual2];
           utri2=10;
           coco2=10;
           M2X=10;
           M12=10;
        elseif sis1==11
           TT=xyz2svf(Tx,[160 160 160]);
           f_igual2=xyz2svf(120*f_igual(:,2:4),[160 160 160]);
           f_igual2=[f_igual(:,1) f_igual2];
           utri2=11;
           coco2=11;
           M2X=11;
           M12=11;
        end
      end
      
      imt=pal2true(im,TT);
      
      im1=imt(:,:,1);
      im2=imt(:,:,2);
      im3=imt(:,:,3);
