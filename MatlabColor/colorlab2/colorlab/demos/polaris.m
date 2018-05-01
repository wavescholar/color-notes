function polaris(fig)

% POLARIS dibuja un diagrama polar y algo mas...
%
% USO: polaris(fig)

x=linspace(-1,1,5);
y1=zeros(1,5);
y2=tan(30*pi/180)*x;
y3=tan(60*pi/180)*x;
x4=zeros(1,5);
y4=linspace(-1,1,5);

figure(fig)
plot(x,y1,'y-'),hold on
plot(x,y2,'y-'),hold on
plot(x,y3,'y-'),hold on
plot(x4,y4,'y-'),hold on
plot(x,-y3,'y-'),hold on
plot(x,-y2,'y-'),hold on
plot(-ones(1,5),y4,'y-'),hold on
plot(ones(1,5),y4,'y-'),hold on
plot(x,ones(1,5),'y-'),hold on
plot(x,-ones(1,5),'y-'),hold on

t1=linspace(0,2*pi,floor(0.25*100));
t2=linspace(0,2*pi,floor(0.5*100));
t3=linspace(0,2*pi,floor(0.75*100));
t4=linspace(0,2*pi,100);

x1=0.25*cos(t1);
y1=0.25*sin(t1);
x2=0.5*cos(t1);
y2=0.5*sin(t1);
x3=0.75*cos(t1);
y3=0.75*sin(t1);
x4=cos(t1);
y4=sin(t1);

plot(x1,y1,'y-'),hold on
plot(x2,y2,'y-'),hold on
plot(x3,y3,'y-'),hold on
plot(x4,y4,'y-'),hold off
title('Percentage of coefficients','FontSize',8);
text(0.26,-0.1,'5%','FontSize',8)
text(0.51,-0.1,'20%','FontSize',8)
text(0.76,-0.1,'45%','FontSize',8)
text(1.01,-0.1,'79%','FontSize',8)
axis('off'),ax,axis([-1 1 -1 1]),axis('off')
hold off