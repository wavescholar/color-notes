function democal

% Calibration Demo
 
clc;
pantalla=get(0,'Screensize');
an=pantalla(3);
al=pantalla(4);
nf(1)=figure(1);clf;set(1,'Position',[0.005*an 0.0533*al 0.655*an 0.8767*al]);
nf(2)=figure(2);clf;set(2,'Position',[0.67*an 0.0533*al 0.3225*an 0.4733*al]);
nf(3)=figure(3);
nf(4)=figure(4);
nf(5)=figure(5);
nf(6)=figure(6);
close(nf(3:6));

%    [f_igual,utri,Msx]=loadsysm('c:\matlab\toolbox\colorlab\colordat\systems\ciexyz');
%    [coco,a,g]=loadmonm('c:\matlab\toolbox\colorlab\colordat\monitor\monito',Msx);
      
p=which('ciergb.mat');
path_data=p(1:end-18);

[T_l,Yw,Mbx]=loadsysm([path_data,'systems\ciexyz']);
[coco,a,g]=loadmonm([path_data,'monitor\std_crt'],Mbx);

      
fig=1;
lado=30;
Nm=65;
tray='';
busca=0;
clc
disp('  ')
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  STIMULI GENERATION AND MEASUREMENT')
disp('  ')
disp('    First you should put the colorimeter on the screen')
disp('    and enter the chromaticities and luminance')
disp('    [t1 t2 Y] of the generated stimuli')
disp('    (in this DEMO the program will do it for you)')
disp('  ')
disp('    (Press any key to continue...)')
pause

nptos=4;
p=linspace(0,1,nptos);
cocodemo(1,:)=p;
cocowdem(1,:)=p;

yw=[0.3 1.1 5.3 13 25.6 46 67.9 91.2 114.2 135.2];
lili=[0    0.1111    0.2222    0.3333    0.4444    0.5556    0.6667;0.3000    0.3300    0.3300    0.3300    0.3300    0.3200    0.3200;0.3200    0.3500    0.3500    0.3500    0.3500    0.3500    0.3500];
lulu=[0.7778    0.8889    1.0000;0.3200    0.3300    0.3200;0.3500    0.3500    0.3500];
cocow=[lili lulu];


for i=1:nptos
	for j=1:3
	ydemo(j,i)=a(j)*p(i)^g(j);
	cocodemo(2*j,i)=interp1(coco(1,:),coco(2*j,:),p(i));
	cocodemo(2*j+1,i)=interp1(coco(1,:),coco(2*j+1,:),p(i));
	end
	ydemo(4,i)=interp1(cocow(1,:),yw,p(i));
	cocowdem(2,i)=interp1(cocow(1,:),cocow(2,:),p(i));
	cocowdem(3,i)=interp1(cocow(1,:),cocow(3,:),p(i));
end
for i=1:4
    if i<4
       for j=1:nptos
           clc
           disp('  ')
           disp('  ')
           disp('  MONITOR CALIBRATION')
           disp('  ')
           disp(['  GUN ',int2str(i),': DIGITAL VALUE [0,1] ',num2str(  p(j) )])
           disp('  ')
           disp('  ')
           n=[0 0 0];
           eval(['n(',int2str(i),')=p(',int2str(j),');'])
           calibra(n,0.5,fig);
           k=0;
           while k==0
             disp('  ')         
             disp('    Chromatic coordinates and luminance(cd/m2)? [t1 t2 Y]  ');
             disp('  ')
	     pause (0.5);
	     disp(['      [ti Y]= [' num2str(cocodemo(2*i,j)) ' ' num2str(cocodemo(2*i+1,j)) ' ' num2str(ydemo(i,j)) ']']);	     
	     pause(1);
             disp('  ')
             disp('    Are you sure? (1=yes / 0=no)  ');
	     corr=(rand>0.1);
	     disp(['        ' num2str(corr) ]);
	     pause(1);
             disp('  ')         
	          if corr==1
                k=1;
                eval(['save ',tray])
             else
                k=0;
             end
           end
        end
    else
       for j=1:nptos
           clc
           
           disp('  ')
           disp('  ')
           disp('  MONITOR CALIBRATION')
           disp('  ')
           disp(['  WHITE: DIGITAL VALUE ',num2str( p(j) )])
           disp('  ')
           disp('  ')
          
           eval(['n=round(p(',int2str(j),'));'])
           n=[n n n];
           calibra(n,0.5,fig);
           k=0;
           while k==0
              disp('    Chromatic coordinates and luminance(cd/m2)? [t1 t2 Y] ');
              
	     pause(1);
	     disp(['      [ti Y]=[' num2str(cocowdem(2,j)) ' ' num2str(cocowdem(3,j)) ' ' num2str(ydemo(4,j)) ']']);	     
             disp('  ')
	     pause(1);
             disp('    Are you sure? (1=yes / 0=no)  ');
           corr=(rand>0.1);
	     disp(['         ' num2str(corr) ]);
	     pause(1);
             disp('  ')         
             if corr==1
                k=1;
                eval(['save ',tray])
             else
                k=0;
             end
           end
        end
    end
end

bla=sum(prod(cocowdem(1:2,:))==0)+1;
crobla0=cocowdem(1:2,bla);	
ro=sum(prod(cocodemo(1:2,:))==0)+1;
croro0=cocodemo(1:2,ro);
ver=sum(prod(cocodemo(3:4,:))==0)+1;
crover0=cocodemo(3:4,ver);
az=sum(prod(cocodemo(5:6,:))==0)+1;
croaz0=cocodemo(5:6,az);
if ro>1
   for i=1:ro-1
       cocodemo(1:2,i)=crobla0+(cocodemo(1:2,ro)-crobla0)*(i-1)/(ro-1);
   end
end 
if ver>1
   for i=1:ver-1
       cocodemo(3:4,i)=crobla0+(cocodemo(3:4,ver)-crobla0)*(i-1)/(ver-1);
   end
end
if az>1
   for i=1:az-1
       cocodemo(5:6,i)=crobla0+(cocodemo(5:6,az)-crobla0)*(i-1)/(az-1);
   end
end
if bla>1
   cocowdemo(:,1:bla-1)=crobla0*ones(1,bla-1);
end
clf;
clc
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  CURVE FIT')
disp('  ')
disp('    Now CALIBRAT will fit the parameters')
disp('    of the curves Y_i=a_i*n_i^g_i')
disp('    ')
disp('    * First you will see some flickering numbers (the fit!) ')
disp('    * Then the fitted curves will show up')
disp('  ')
disp('    (Press any key to continue...)')
pause
nf(1)=figure(fig);clf;set(fig,'Position',[0.005*an 0.053*al 0.3225*an 0.4*al]);
nf(2)=figure(fig+1);clf;set(fig+1,'Position',[0.3375*an 0.053*al 0.3225*an 0.4*al]);
nf(3)=figure(fig+2);clf;set(fig+2,'Position',[0.67*an 0.053*al 0.3225*an 0.4*al]);
nf(4)=figure(fig+3);clf;set(fig+3,'Position',[0.005*an 0.53*al 0.3225*an 0.4*al]);
nf(5)=figure(fig+4);clf;set(fig+4,'Position',[0.3375*an 0.53*al 0.3225*an 0.4*al]);

[a,ea,g,eg]=sacagama([p;p;p],ydemo(1:3,:),200,fig);
yrdemo=ydemo(1,:);
ygdemo=ydemo(2,:);
ybdemo=ydemo(3,:);
ywdemo=ydemo(4,:);

clc;
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  ADDITIVITY CHECK')
disp('  ')
disp('    CALIBRAT now represents the sum')
disp('    of the gun luminances and the luminance')
disp('    of the corresponding white in order to')
disp('    check the additivity assumption')
disp('  ')
disp('    (Press any key to continue...)')
disp('  ')
pause

nf(4)=figure(fig+3);aj=axes;plot(p,[sum(ydemo(1:3,1))/3 sum(ydemo(1:3,2:nptos))],'bo');axis([0 1.1 0 200])
hold on,plot(p,ydemo(4,:),'k+')
set(aj,'FontSize',8);
xlabel('digital value','FontSize',8);
ylabel('Luminance (cd/m^2)','FontSize',8);
title('o Sum of the luminances     + White Luminance','FontSize',8);
hold off
eval(['save ',tray,' a g ea eg yrdemo ygdemo ybdemo ywdemo cocodemo cocowdemo'])
nf(5)=figure(fig+4);

%repmonit(a,g,cocodemo,f_igual,0,1,fig+4);

coco=cocodemo;
s=size(coco);
N=coco(1,s(2));
colores=[[coco(2:3,:)' ones(s(2),1)];[coco(4:5,:)' ones(s(2),1)];[coco(6:7,:)' ones(s(2),1)]];

ni=linspace(0,N,40);

for i=1:3
    y=a(i)*ni.^g(i);
    figure(fig+i-1),clf;aaa=axes;
    plot(ni,y);hold on
    plot(p,ydemo(i,:),'ko')
    set(aaa,'FontSize',8,'XLim',[0 1.05],'XLimMode','Manual');
    set(aaa,'YLim',[0 115],'YLimMode','Manual'),
    xlabel(['Digital value of gun ',int2str(i)],'FontSize',8),
    ylabel('Luminance (cd/m^2)','FontSize',8)
    title(['Y_{',num2str(i),'}=a_{',num2str(i),'}*n_{',num2str(i),'}^{\gamma_{',num2str(i),'}}      a_{',num2str(i),'}=',num2str(a(i)),'    \gamma_{',num2str(i),'}=',num2str(g(i))])
end
figure(5),colordgm(colores,2,T_l,[0 1 0]);
title('Chromaticities of the guns','FontSize',8)