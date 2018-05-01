startcol

f_igual=T_l;
utri=Yw;
coco=tm;

pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
figure(1);clf;set(1,'Position',[0.005*an 0.53*al 0.6538*an 0.4*al]);
figure(2);clf;set(2,'Position',[0.005*an 0.053*al 0.49*an 0.47*al]);
figure(3);clf;set(3,'Position',[0.505*an 0.053*al 0.49*an 0.47*al]);
figure(4);
figure(5);
figure(6);
delete(4)
delete(5)
delete(6)
figure(2)
figure(3)
figure(1)
rango=maxi(f_igual(:,2:4))-mini(f_igual(:,2:4));
figure(1),aaa=axes;plot(f_igual(:,1),f_igual(:,2),'r-'),hold on,
plot(f_igual(:,1),f_igual(:,3),'g-'),hold on,plot(f_igual(:,1),f_igual(:,4),'b-'),set(aaa,'FontSize',8,'XLim',[380 770],'XLimMode','Manual')
xlabel('Wavelenght (nm)')
title('Color Matching Funtions','FontSize',8)
hold off
clear rango
s=size(coco);
col=[(coco(2:3,s(2)))' 40;(coco(4:5,s(2)))' 100;(coco(6:7,s(2)))' 18];

%colorend(col,2,f_igual,utri,1,coco,1,1,2);
%   symb='o';
%   show_lin=0;
%   show_numb=1; 
%   showtriang=3;
%   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
%   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
%   linestyles=['- ';'- ';'- ';'- ';': ';'- '];
%   fontsizes=[10 12 1.5 8];
%  
figure(2),%colordgm(col,2,f_igual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  symb='o';
  show_lin=0;
  show_numb=1; 
  showtriang=3;
  lincolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.5 0.4 0;0.5 0.4 0;0.5 0.4 0];
  linewidths=[0.5 0.5 0.5 0.5 0.5 0.5];
  linestyles=['- ';'- ';'- ';'- ';': ';'- '];
  fontsizes=[10 12 4 8];
 
  %colordgm([0.9*masimo 0.9*masimo 0.9*masimo;T;Tposible],1,figual,utri,coco,symb,show_lin,show_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);

  colordgm(col,2,f_igual,utri,'symb','o','sizes',fontsizes,'showtriang',{3,coco},'linecolors',lincolors,'show_numb',1)
  


title('Chromatic Diagram','FontSize',8)

%   symb='o';
%   lim_axis=[-.5 5 -.5 5 -.5 5]/2;
%   showvectors=1;
%   show_lin=0;
%   show_numb=1;
%   showdiag=1;
%   showtriang=3;
%   linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0;0.3 0.2 0;0.6 0.2 0;0.3 0.2 0;0.3 0.2 0];
%   linewidths=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
%   linestyles=['- ';'- ';'- ';'- ';': ';'- ';'- '];
%   fontsizes=[10 12 1.5 8];
  
  figure(3),%colorspc([col(:,1:2) 1*[50;100;18]/100],2,f_igual,utri,coco,symb,lim_axis,showvectors,show_lin,show_numb,showdiag,showtriang,linecolors,linewidths,linestyles,fontsizes);
  
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

colorspc([col(:,1:2) 1*[50;100;18]/100],2,f_igual,utri,'show_numb',1,'showvectors',1,'symb','o','sizes',sizes,'showtriang',{3,coco},'showdiag',1,'linecolors',linecolors)

  
  
title('Tristimulus Space','FontSize',8)
clear s ans
figure(1)