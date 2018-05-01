function demofi(im,pal,f_igual,utri,Msx,coco,a,g,an,al);

%function [nmatlab,imi,M12,fi,radios,portot]=demofi(im,pal,f_igual,utri,Msx,coco,a,g,an,al);
% funcion basura para resolver problema fantasma
%
%

%[im1,im2,im3,pal2,f_igual2,utri2,M2X,coco2,M12]=descomp2(im,pal,1,f_igual,utri,Msx,coco,a,g);

[im1,im2,im3,pal2,f_igual2,utri2,M2X,coco2,M12]=descom3(im,pal,f_igual,utri,Msx,coco,a,g);

      clear MENU_VARIABLE        

      figure(1);clf;set(1,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
      figure(2);clf;set(2,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
      figure(3);clf;set(3,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
      figure(4);clf;set(4,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
      figure(5);clf;set(5,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);

      %[paltreq,paltpos,imind,nmat,sat]=pincol4(4,im,0,0,0,utri,a,g,coco,pal,0,0,0,f_igual,0,0,0,1);axis('off');

      figure(1),colormap(pal),image(im),ax,axis('off')      
      title('Original Image','FontSize',8);

      if prod(size(M12))>1
         TT=pal2;
       
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

%             symb='o';
%             lim_axis=0;
%             showvectors=0;
%             show_lin=0;
%             show_numb=0;
%             showdiag=0;
%             showtriang=0;
%             linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
%             linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
%             linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
%             fontsizes=[10 12 1 8];
%             
%             figure(2)
%             colorspc([TT;f_igualre],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,...
%             showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);

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
          
        colorspc([TT;f_igualre],1,f_igual2,utri2,'show_numb',0,'showvectors',0,'symb','o','sizes',fontsizes,'linecolors',linecolors)

        
         else
            figure(2) 
            colordgm(TT,1,f_igual2,utri2,coco2);
         end
      else
         TT=pal2;
         f_igualre=f_igual2(:,2:4);
         rango1=maxi(f_igualre(:,1))-mini(f_igualre(:,1));
         rango2=maxi(f_igualre(:,2))-mini(f_igualre(:,2));
         rango3=maxi(f_igualre(:,3))-mini(f_igualre(:,3));
         m1=mini(f_igualre(:,1))-0.05*rango1;
         M1=maxi(f_igualre(:,1))+0.05*rango1;
         m2=mini(f_igualre(:,2))-0.05*rango2;
         M2=maxi(f_igualre(:,2))+0.05*rango2;
         m3=mini(f_igualre(:,3))-0.05*rango3;
         M3=maxi(f_igualre(:,3))+0.05*rango3;
         
         % colorene([TT;f_igualre],1,0,f_igual2,utri,coco,0,0,2,1,[m1 M1 m2 M2 m3 M3],[100 30]);
         
%             symb='o';
%             lim_axis=0;
%             showvectors=0;
%             show_lin=0;
%             show_numb=0;
%             showdiag=0;
%             showtriang=0;
%             linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
%             linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
%             linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
%             fontsizes=[10 12 1 8];
%             
%             figure(2)
%             colorspc([TT;f_igualre],1,f_igual2,utri2,coco2,symb,lim_axis,showvectors,show_lin,show_numb,...
%             showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
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
          
        colorspc([TT;f_igualre],1,f_igual2,utri2,'show_numb',0,'showvectors',0,'symb','o','sizes',fontsizes,'linecolors',linecolors)
      end

      %[im1,im2,im3]=palt2tri(im,TT);
      im3d=pal2true(im,TT);
      
      im1=im3d(:,:,1);
      im2=im3d(:,:,2);
      im3=im3d(:,:,3);
      
      pinta(im1,3),axis('off')
      pinta(im2,4),axis('off')
      pinta(im3,5),axis('off')
      clc
      disp(' ') 
      disp(' ')
      disp(' BANDWIDTH REDUCTION')
      disp(' ')
      disp('  Now we will compute the spectrum of each chromatic')
      disp('  channel. You will define three ideal low-pass filters.')
      disp('  You can select the cut frequencies with the mouse')
      disp(' ')
      disp('  (Press any key to continue...)')
      pause
      
      tt1=fftshift(fft2(im1));
      tt2=fftshift(fft2(im2));
      tt3=fftshift(fft2(im3));
      
      pto=size(im1);
      pto=ceil((pto(1)+1)/2);
      
      figure(6);clf;set(6,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
      figure(7);clf;set(7,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
      figure(8);clf;set(8,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
      
      nor=maxi([abs(tt1(pto,pto)) abs(tt2(pto,pto)) abs(tt3(pto,pto))]);
      figure(6),clf,contour(abs(tt1)/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('SPECTRUM OF CHANNEL 1','FontSize',8)
      figure(7),clf,contour(abs(tt2)/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('SPECTRUM OF CHANNEL 2','FontSize',8)
      figure(8),clf,contour(abs(tt3)/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('SPECTRUM OF CHANNEL 3','FontSize',8)
      figure(9),clc,set(9,'Position',[0.275*an (3/4)*0.5*al 0.45*an 0.18*al]);
      clf,axis([0 1 0 1]),axis('off'),text(0,0.7,'PRESS ANY KEY TO','FontSize',9);
      text(0,0.5,'DESIGN THE FILTERS...','FontSize',9);
      pause
      close(9)

      figure(9);clf;set(9,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
      figure(10);clf;set(10,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
      figure(11);clf;set(11,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
 
      polaris(9),xlabel('Channel 1 filter','FontSize',8)
      [x,y]=ginput(1);
      r1=sqrt(x^2+y^2);
      t1=linspace(0,2*pi,floor(r1*100));
      x1=r1*cos(t1);
      y1=r1*sin(t1);
      hold on 
      plot(x1,y1,'b-'),hold off
      polaris(10),xlabel('Channel 2 filter','FontSize',8)
      [x,y]=ginput(1);
      r2=sqrt(x^2+y^2);
      x1=r2*cos(t1);
      y1=r2*sin(t1);
      hold on 
      plot(x1,y1,'b-'),hold off
      polaris(11),xlabel('Channel 3 filter','FontSize',8)
      [x,y]=ginput(1);
      r3=sqrt(x^2+y^2);
      x1=r3*cos(t1);
      y1=r3*sin(t1);
      hold on 
      plot(x1,y1,'b-'),hold off
      pause(0.2)
      radios=[r1 r2 r3];
      for i=1:3
          if radios(i)>1
             A=radios(i)^2*[acos(1/radios(i))-(1/2)*sin(2*acos(1/radios(i)))];
             por(i)=(100/4)*((pi*radios(i)^2)-4*A);
          else
             por(i)=(100*pi/4)*(radios(i)^2);
          end
      end
      portot=mean(por);
      pt=size(im1);
      ppt=min(pt);
      filt=pasaband(2,ppt,0,r1,0,179.9);
      if pt(1)~=pt(2)
         filt=fftshift(metesub(zeros(pt(1),pt(2)),[pt(1)/2 pt(2)/2],fftshift(filt)));
      end   
      figure(9),contour(abs(tt1.*fftshift(filt))/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('Channel 1 after low-pass','FontSize',8)
      im1f=real(ifft2(fftshift(tt1).*filt));
      clear tt1
      pt=size(im1);
      ppt=min(pt);
      filt=pasaband(2,ppt,0,r2,0,179.9);
      if pt(1)~=pt(2)
         filt=fftshift(metesub(zeros(pt(1),pt(2)),[pt(1)/2 pt(2)/2],fftshift(filt)));
      end   
      figure(10),contour(abs(tt2.*fftshift(filt))/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('Channel 2 after low-pass','FontSize',8)
      im2f=real((ifft2(fftshift(tt2).*filt)));
      clear tt2
      pt=size(im1);
      ppt=min(pt);
      filt=pasaband(2,ppt,0,r3,0,179.9);
      if pt(1)~=pt(2)
         filt=fftshift(metesub(zeros(pt(1),pt(2)),[pt(1)/2 pt(2)/2],fftshift(filt)));
      end   
      figure(11),contour(abs(tt3.*fftshift(filt))/nor,[0.00175 0.01 0.1 0.2 0.5]),ax,axis('off')
      title('Channel 3 after low-pass','FontSize',8)
       
      figure(12),clc,set(12,'Position',[0.275*an (3/4)*0.5*al 0.45*an 0.18*al]);
      clf,axis([0 1 0 1]),axis('off'),text(-0.07,0.5,'PRESS ANY KEY TO SEE THE FILTERING RESULTS...','FontSize',9);
      pause
      close(12)
      
      im3f=real((ifft2(fftshift(tt3).*filt)));
      clear tt3
      figure(12),set(12,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
      pinta(im1f,12),axis('off')
      figure(13);clf;set(13,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);
      pinta(im2f,13),axis('off') 
      figure(14);clf;set(14,'Position',[0.67*an 0.53*al 0.3225*an 0.4*al]);
      pinta(im3f,14),axis('off')
      
      fi=get(0,'Children'); 
      fi=max(fi)+1; 
      figure(fi),clc,set(fi,'Position',[0.275*an (3/4)*0.5*al 0.45*an 0.18*al]); 
      clf,axis([0 1 0 1]),axis('off'),text(0,0.5,'PRESS ANY KEY TO SEE THE RECONSTRUCTED IMAGE...','FontSize',9);
      pause 
      close(fi) 
      
      figure(1);set(1,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]); 

 
      figure(fi);clf;set(fi,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]); 
%      [imi,palt]=tri2palt(im1f,im2f,im3f,45); 
      
%     imf=im;
      
      imf(:,:,1)=im1f;
      imf(:,:,2)=im2f;
      imf(:,:,3)=im3f;

      [imi,palt]=true2pal(imf,100);
      
      %M12
       
      if prod(size(M12))>1 
         %paltx=cambibas(palt,inv(M12)); 
         paltx=newbasis(palt,inv(M12));
      elseif M12==5 
         paltx=lab2xyz(palt,[150 150 150]); 
      elseif M12==6
         paltx=luv2xyz(palt,[150 150 150]);
      elseif M12==10
         paltx=atd2xyz(palt,2,11);
      elseif M12==11 
         paltx=svf2xyz(palt,[160 160 160]);
      end
      
      %[nmonit,nmatlab,satur,Tposible]=tri2niv4(coco,[0 1 0],a,g,1,paltx);
      [nmatlab,saturat,Tn]=tri2val(paltx,utri,coco,a,g,8);
     
%      save c:\caca
%      clear
%         close(2) 
%         close(3) 
%         close(4) 
%         close(5) 
%         close(6) 
%         close(7) 
%         close(9) 
%         close(10)
%      clc
%      load c:\caca
%      figure(fi);clf;set(fi,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]); 

% save c:\caca

p=which('ciergb.mat');
path_data=p(1:end-18);

save([path_data,'caca'],'im','pal','f_igual','utri','Msx','coco','a','g','nmatlab','imi','an','al','M12','portot','radios')
clear all
