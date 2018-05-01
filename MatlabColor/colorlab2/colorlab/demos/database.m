% Color data base

T1=loadcol(f_igual,utri,eye(3),3,'c:\matlab\toolbox\colorlab\colordat\colors\locus1cd');
figure(1),colordgm(T1,3,f_igual,utri,coco);title('Colors in    locus1d.mat')
%T1(1:20:end,:)

T1=loadcol(f_igual,utri,eye(3),3,'c:\matlab\toolbox\colorlab\colordat\colors\purex1cd');
figure(2),colordgm(T1,3,f_igual,utri,coco);title('Colors in    purex1d.mat')
%T1(1:20:end,:)

T1=loadcol(f_igual,utri,eye(3),4,'c:\matlab\toolbox\colorlab\colordat\colors\purcolor');
figure(3),colordgm(T1,4,f_igual,utri,coco);title('Colors in    purcolor.mat')
%T1(1:20:end,:)

T1=loadcol(f_igual,utri,eye(3),3,'c:\matlab\toolbox\colorlab\colordat\colors\macadam');
%figure(4),colordgm(T1,3,f_igual,utri,coco);title('Colors in    macadam.mat')

  symb='o';
  show_lin=0;
  show_numb=0; 
  showtriang=3;
  linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0 0 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 1.4 8];
  figure(4),colordgm(T1,3,f_igual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
  title('Colors in    macadam.mat')
  
  print -f1 -dtiff d:\usuarios_p\jesus\locus.tif
  print -f2 -dtiff d:\usuarios_p\jesus\purex.tif
  print -f3 -dtiff d:\usuarios_p\jesus\purcol.tif
  print -f4 -dtiff d:\usuarios_p\jesus\macadam.tif
  
  % Base de imagenes
  %
  
startcol  
imagenes=['ball.tif    ';...
          'cezanne.jpg ';...
          'clock.tif   ';...
          'cubes.tif   ';...
          'gris.jpg    ';...
          'keys.tif    ';...
          'marilyn.jpg ';...
          'matisse.jpg ';...
          'mondrian.jpg';...
          'pool.tif    ';...
          'sand.tif    ';...
          'stamp.tif   ';...
          'thermo.tif  ';...
          'warhol1.jpg ';...          
          'warhol2.jpg '];
    
    
for i=1:15,
   
    vacia=find([imagenes(i,:)==' ']==1);
    if isempty(vacia)
       ultima=12;
    else
       ultima=vacia-1;
    end
    
    imagen=imagenes(i,1:ultima);
    [im,pal]=imread(['c:\matlab\toolbox\colorlab\colordat\images\images\',imagen]);
    
    if isempty(pal)
       [im,pal]=true2pal(im,256);
    elseif length(pal(:,1))>256
       im=pal2true(im,pal);
       [im,pal]=true2pal(im,256);
    end
    T=val2tri(pal,Yw,tm,a,g); 
    
    figure(1),clf,imshow(im,pal),title(imagenes(i,:))
    symb='o';
    show_lin=0;
    show_numb=0; 
    showtriang=3;
    linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0 0 0;0.5 0.4 0];
    linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
    linestyles=['- ';'- ';'- ';'- ';': ';'- '];
    fontsizes=[10 12 1.3 8];
    figure(2),clf,colordgm(T,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
    axis([0 0.8 0 0.9]),axis('equal')
    title(['Colors in  ',imagenes(i,:)])

    eval(['print -f1 -dtiff d:\usuarios_p\jesus\imagen',num2str(i),'.tif'])
    eval(['print -f2 -dtiff d:\usuarios_p\jesus\colores',num2str(i),'.tif'])
    
 end    
 
 
 
 imagenes=['lens.mat    ';...
           'monkey.mat  ';...
           'rainbow1.mat';...
           'rainbow2.mat';...
           'rainbow3.mat';...
           'scales.mat  ';...
           'sun.mat     '];
        
for i=1:7,
   
    vacia=find([imagenes(i,:)==' ']==1);
    if isempty(vacia)
       ultima=12;
    else
       ultima=vacia-1;
    end
    imagen=imagenes(i,1:ultima);
   
    load(['c:\matlab\toolbox\colorlab\colordat\images\mosaics\',imagen]);
    
    figure(1),plot(palre(:,1),palre(:,2:end)),axis([380 750 0 1]),xlabel('Wavelength (nm)'),ylabel('Reflectance')
    title(['Reflectance of   ',imagen])
    
    [T,RR]=spec2tri(3,T_l,5,palre,[palre(:,1) ones(length(palre(:,1)),1)],140,Yw);
    %  [im,pal]=imread(['c:\matlab\toolbox\colorlab\colordat\images\images\',imagen]);
    
    [pal,saturat,Tn]=tri2val(T,Yw,tm,a,g,8);
    
    figure(2),clf,colormap(pal),image(im),axis('off'),title(['Mosaic:  ',imagen])
    symb='o';
    show_lin=0;
    show_numb=0; 
    showtriang=3;
    linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0 0 0;0.5 0.4 0];
    linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
    linestyles=['- ';'- ';'- ';'- ';': ';'- '];
    fontsizes=[10 12 1.3 8];
    figure(3),clf,colordgm(T,1,T_l,Yw,tm,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
    axis([0 0.8 0 0.9]),axis('equal')
    title(['Colors in  ',imagenes(i,:)])
    
    pause
    eval(['print -f1 -dtiff d:\usuarios_p\jesus\arefl',num2str(i),'.tif'])
    eval(['print -f2 -dtiff d:\usuarios_p\jesus\amosaic',num2str(i),'.tif'])
    eval(['print -f3 -dtiff d:\usuarios_p\jesus\acolor',num2str(i),'.tif'])

end 