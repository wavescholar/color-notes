function demodes

% DEMODES Demo de descomposicion de
% una imagen en canales cromáticos.
%
% USO: demodes

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

p=which('ciergb.mat');
path_data=p(1:end-18);

[f_igual,utri,Msx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Msx);

clc

p=which('marilyn.jpg');
path_data=p(1:end-11);
[fich,tray]=uigetfile([path_data,'*.*'],'Load *.jpg or *.tif images');
[im,pal]=imread([tray,fich]);

if isempty(pal)
   [im,pal]=true2pal(im,40);
elseif length(pal(:,1))>40
   im=pal2true(im,pal);
   [im,pal]=true2pal(im,40);
end

[im1,im2,im3,T,f_igual2,utri2,M2X,coco2,M12]=descom3(im,pal,f_igual,utri,Msx,coco,a,g);


figure(1);clf;set(1,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
figure(2);clf;set(2,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
figure(3);clf;set(3,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
figure(4);clf;set(4,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
figure(5);clf;set(5,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);

%[pr,pp,imi,nmat,sat]=pincol4(4,im,0,0,0,utri,a,g,coco,pal,0,0,0,f_igual,0,0,0,1);axis('off');

figure(1),colormap(pal),image(im)

if prod(size(M12))==1
          sss=size(f_igual2);
          f_igualre=1.1*f_igual2(:,sss(2)-2:sss(2));
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
            showtriang=0;
            linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
            linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
            linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
            fontsizes=[10 12 1 8];
            
            figure(2)
            %colorspc([T;f_igualre],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,...
            %showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
          
        colorspc([T;f_igualre],1,f_igual2,utri2,'show_numb',0,'showvectors',0,'symb','o','sizes',fontsizes,'linecolors',linecolors)

        
  %      colorene([T;f_igualre],1,0,f_igual2,utri2,coco2,0,0,2,1,[m1 M1 m2 M2 m3 M3],[100 30]);

          pinta(im1,3),axis('off')
          pinta(im2,4),axis('off')
          pinta(im3,5),axis('off') 

else
    loc=tri2coor(f_igual2(:,2:4),utri2);
    if maxi(loc(:,1:2))>10
       
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
   
            %colorene([T;f_igualre],1,0,f_igual2,utri2,coco2,0,0,2,1,[m1 M1 m2 M2 m3 M3],[100 30]);
  
            symb='o';
            lim_axis=0;
            showvectors=0;
            show_lin=0;
            show_numb=0;
            showdiag=0;
            showtriang=0;
            linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
            linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
            linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
            fontsizes=[10 12 1 8];
            
            figure(2)
            %colorspc([T;f_igualre],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,...
            %showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
        
            colorspc([T;f_igualre],1,f_igual2,utri2,'show_numb',0,'showvectors',0,'symb','o','sizes',fontsizes,'linecolors',linecolors)
   else
      % colorend(T,1,f_igual2,utri2,1,coco2,0,1,2);
      figure(2), 
      %colordgm(T,1,f_igual2,utri2,coco2);
      
        symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  lincolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 4 8];
 
  %colordgm([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  colordgm(T,1,f_igual2,utri2,'symb','o','sizes',fontsizes,'showtriang',{3,coco2},'linecolors',lincolors,'show_numb',0)

      
   end

   % A ver si los primarios elegidos son generables con el monitor...

        ta=size(coco);
        p=[1 0 0;0 1 0;0 0 0];
        p1=[coco2(2,ta(2)) coco2(3,ta(2)) 0];
        p2=[coco2(4,ta(2)) coco2(5,ta(2)) 0];
        p3=[coco2(6,ta(2)) coco2(7,ta(2)) 0];
        pm=[p1;p2;p3];

        a1=(p2-p1);
        a2=(p3-p1);
        
        b1=(p1-p2);
        b2=(p3-p2);
        
        c1=(p1-p3);
        c2=(p2-p3);
        
        putos=[a1;a2;b1;b2;c1;c2];
        
        cc=[0 0 0];        
        for i=1:3
            punto=p(i,:);
            for j=1:3
                pp1=p_vect(putos(2*(j-1)+1,:),punto-pm(j,:)); 
                pp2=p_vect(putos(2*(j-1)+2,:),punto-pm(j,:)); 
                
                cc(j)=(sign( pp1(3)*pp2(3) )<=0); 
                
                %pause
                
            end     
            c(i)=prod(cc);
        end 
        c=prod(c);

   % Si los primarios son generables que pinte la parte positiva de las imagenes triestimulo 
   % y si no, que haga un pinta en blanco y negro... 
   
        %c=1
        if c>0
           ta=size(im1);
           
           [pal1,saturat,Tn]=tri2val([T(:,1).*(T(:,1)>0) zeros(length(T(:,1)),2)],utri2,coco2,a,g,8);
           [pal2,saturat,Tn]=tri2val([zeros(length(T(:,1)),1) T(:,2).*(T(:,2)>0) zeros(length(T(:,1)),1)],utri2,coco2,a,g,8);
           [pal3,saturat,Tn]=tri2val([zeros(length(T(:,1)),2) T(:,3).*(T(:,3)>0)],utri2,coco2,a,g,8);
           
           figure(3),colormap(pal1);image(im)
           figure(4),colormap(pal2);image(im)
           figure(5),colormap(pal3);image(im)
           
           %[paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri2,a,g,coco2,[T(:,1).*(T(:,1)>0) zeros(length(T(:,1)),2)],0,0,0,f_igual2,0,0,0,3);
           %[paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri2,a,g,coco2,[zeros(length(T(:,1)),1) T(:,2).*(T(:,2)>0) zeros(length(T(:,1)),1)],0,0,0,f_igual2,0,0,0,4);
           %[paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri2,a,g,coco2,[zeros(length(T(:,1)),2) T(:,3).*(T(:,3)>0)],0,0,0,f_igual2,0,0,0,5);
           
        else
          pinta(im1,3),axis('off')
          pinta(im2,4),axis('off')
          pinta(im3,5),axis('off')
        end         
end