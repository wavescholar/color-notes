% The display functions image or imshow generate different results when using 
% RGB images or indexed images with equivalent colormaps!
% Look at these two examples:


% Load some arbitrary image

[X,map]=imread('kids.tif');

% We convert the indexed image and colormap into a RGB
% image (three matrices).

im=ind2rgb(X,map);

% Lets display the (undersampled) results 

figure(1),imshow(X(1:10:400,1:10:318),map,'notruesize'),title('Indexed image and colormap')
figure(2),imshow(im(1:10:400,1:10:318,:),'notruesize'),title('RGB image')
figure(3),colormap(map),image(X(1:10:400,1:10:318)),title('Indexed image and colormap (image)')
figure(4),image(im(1:10:400,1:10:318,:)),title('RGB image (image)')

% THEY ARE NOT THE SAME: 
% you can see this by making both figure full-size and switching from one to the other
% NOTE that the colors in the RGB image are (slightly but noticeably) brighter.
%
% The display of RGB images is brighter than (the same) indexed image and colormap
% systematically (with any image). Another example:

% Load the image
RGB = imread('flowers.tif');
% We select a colormap with few colors (for instance 30 colors)
[X,map] = rgb2ind(RGB,30);
% We convert the indexed image and colormap into a RGB
% image (three matrices).
im=ind2rgb(X,map);
% Lets display the (undersampled) results 
figure(5),imshow(X(1:10:362,1:20:500),map,'notruesize'),title('Indexed image and colormap (imshow)')
figure(6),imshow(im(1:10:362,1:20:500,:),'notruesize'),title('RGB image (imshow)')
figure(7),colormap(map),image(X(1:10:362,1:20:500)),title('Indexed image and colormap (image)')
figure(8),image(im(1:10:362,1:20:500,:)),title('RGB image (image)')

