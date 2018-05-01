   
%ML_SPEC_CF
[lambda, D65] = illuminant('d65');
   figure;
   plot(lambda, D65)
   title('D_{65} illuminant')
   spectrumLabel(gca)
   
   
   
   %OPTPROP
  rgb=cat(3,[1 0 0], [0 1 0], [0 0 1]);

  xyz=[rgb2xyz(rgb,'srgb','D50/2'); 
    
rgb2xyz(rgb,'adobe','D50/2')];
YCBCR = rgb2ycbcr(rgb);
xy=xyz2xy(xyz);

xyl=cat(2,xy,xy(:,1,:));
plot(xyl(:,:,1)',xyl(:,:,2)');
xlabel('x');ylabel('y')
legend('sRGB', 'Adobe');

clear all;
rgb=cat(3,[1 0 0], [0 1 0], [0 0 1]);
xyz=rgb2xyz(rgb,'srgb','D65/10');
xy=xyz2xy(xyz);
ballplot(xy(:,:,1),xy(:,:,2),zeros(size(xy(:,:,1))),rgb);
hold on
YCBCR=rgb2ycbcr(rgb);
xyz=rgb2xyz(YCBCR,'srgb','D65/10');
xy=xyz2xy(xyz);
ballplot(xy(:,:,1),xy(:,:,2),zeros(size(xy(:,:,1))),YCBCR);


clear all;
m=255;
h = (0:m-1)'/max(m,1);
rgb=[h ones(m,2)];
hsvmapinv = hsv2rgb([h ones(m,2)]);
hsvmapfdw = rgb2hsv([h ones(m,2)]);

ycbcrinv=rgb2ycbcr([h ones(m,2)]);
ycbncrfwd=ycbcr2rgb([h ones(m,2)]);

xyz=rgb2xyz(rgb,'srgb','Gamma', 1);
ballplot(xyz,rgb);
camorbit(90,0);
camlight;
lighting phong
xlabel('X');ylabel('Y'); zlabel('Z');

h=viewgamut(xyz,rgb, 'EdgeColor', [0 0 0]);
camorbit(90,0);
xlabel('X');ylabel('Y'); zlabel('Z');


clear all;
rgb=addmix(5,5);

hold on;
subplot(1,2,1);

xyz=rgb2xyz(rgb,'srgb','Gamma', 1);

ballplot(xyz,rgb);
subplot(1,2,2);

ycbcrinv=rgb2ycbcr(rgb);
xyz=rgb2xyz(rgb,'srgb','Gamma', 1);
ballplot(xyz,ycbcrinv);
camorbit(90,0);
camlight;
lighting phong
xlabel('Red');ylabel('Green'); zlabel('Blue');
hold off;

     [x,y,z] = sphere(8);
	   
     X = [x(:)*.5 x(:)*.75 x(:)];
     Y = [y(:)*.5 y(:)*.75 y(:)];
     Z = [z(:)*.5 z(:)*.75 z(:)];
     C = repmat([1 2 3],numel(x),1);
     ballplot(X,Y,Z,C(:));
     view(-60,10)
     camlight

