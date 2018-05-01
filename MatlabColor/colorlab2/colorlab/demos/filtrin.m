inicio

% Load image

[im,pal,im1,im2,im3,palre,ilumin]=carga(1,f_igual,utri,Msx,1,coco,a,g);

% Define filter

fig=1;
filt=defrefl(ilumin(:,1),fig);
[TTf,ilum2]=spec2tri(f_igual,5,filt,4*ilumin);
[TTi,ilum]=spec2tri(f_igual,5,[filt(:,1) ones(length(filt(:,1)),1)],4*ilumin);
tti=tri2coor(TTi,utri);
ttf=tri2coor(TTf,utri);

% Colors (tristimulus and chromatic coordinates) without filter

[T1,Radiance]=spec2tri(f_igual,5,palre,4*ilumin);
t1=tri2coor(T1,utri);

% Colors (tristimulus and chromatic coordinates) with filter

[T2,Radiance]=spec2tri(f_igual,5,palre,ilum2);
t2=tri2coor(T2,utri);

% Image without filter

[paltreq1,paltpos1,imind,nmat,sat1]=pincol4(4,im,0,0,0,utri,a,g,coco,T1,0,0,0,f_igual,0,0,0,3);

% Image with filter

[paltreq2,paltpos2,imind,nmat,sat2]=pincol4(4,im,0,0,0,utri,a,g,coco,[T1(1:9,:);T2(1:9,:)],0,0,0,f_igual,0,0,0,4);

colorend(paltreq2,1,f_igual,utri,1,coco,0,1,5);hold on
for i=1:9
    line([t1(i,1) t2(i,1)],[t1(i,2) t2(i,2)])
    plot(t1(i,1),t1(i,2),'co');
end
y=line([tti(1,1) ttf(1,1)],[tti(1,2) ttf(1,2)]);
set(y,'Color',[1 1 1]);
plot(tti(1,1),tti(1,2),'wo');
hold off

colorene(5*paltreq2/maxi(paltreq2),1,1,f_igual,utri,coco,0,0,6,1,[0 5 0 5 0 5],[100 30]);hold on
for i=1:9
    line(5*[T1(i,1) T2(i,1)]/maxi(paltreq2),5*[T1(i,2) T2(i,2)]/maxi(paltreq2),5*[T1(i,3) T2(i,3)]/maxi(paltreq2));
    plot3(5*T1(i,1)/maxi(paltreq2),5*T1(i,2)/maxi(paltreq2),5*T1(i,3)/maxi(paltreq2),'co');
end
y=line(5*[TTi(1,1) TTf(1,1)]/maxi(paltreq2),5*[TTi(1,2) TTf(1,2)]/maxi(paltreq2),5*[TTi(1,3) TTf(1,3)]/maxi(paltreq2));
set(y,'Color',[1 1 1]);
plot3(5*TTi(1,1)/maxi(paltreq2),5*TTi(1,2)/maxi(paltreq2),5*TTi(1,3)/maxi(paltreq2),'wo');
hold off
rotate3d


%%%%%%%%%%%%%%%%%%%%%%%%%%% TO REPEAT:

% Define filter

fig=1;
filt=defrefl(ilumin(:,1),fig);
[TTf,ilum2]=spec2tri(f_igual,5,filt,4*ilumin);
ttf=tri2coor(TTf,utri);

% Colors (tristimulus and chromatic coordinates) with filter

[T2,Radiance]=spec2tri(f_igual,5,palre,ilum2);
t2=tri2coor(T2,utri);

% Image with filter

[paltreq2,paltpos2,imind,nmat,sat2]=pincol4(4,im,0,0,0,utri,a,g,coco,[T1(1:9,:);T2(1:9,:)],0,0,0,f_igual,0,0,0,4);

colorend(paltreq2,1,f_igual,utri,1,coco,0,1,5);hold on
for i=1:9
    line([t1(i,1) t2(i,1)],[t1(i,2) t2(i,2)])
    plot(t1(i,1),t1(i,2),'co');
end
y=line([tti(1,1) ttf(1,1)],[tti(1,2) ttf(1,2)]);
set(y,'Color',[1 1 1]);
plot(tti(1,1),tti(1,2),'wo');
hold off

colorene(5*paltreq2/maxi(paltreq2),1,1,f_igual,utri,coco,0,0,6,1,[0 5 0 5 0 5],[100 30]);hold on
for i=1:9
    line(5*[T1(i,1) T2(i,1)]/maxi(paltreq2),5*[T1(i,2) T2(i,2)]/maxi(paltreq2),5*[T1(i,3) T2(i,3)]/maxi(paltreq2));
    plot3(5*T1(i,1)/maxi(paltreq2),5*T1(i,2)/maxi(paltreq2),5*T1(i,3)/maxi(paltreq2),'co');
end
y=line(3*[TTi(1,1) TTf(1,1)]/maxi(paltreq2),3*[TTi(1,2) TTf(1,2)]/maxi(paltreq2),3*[TTi(1,3) TTf(1,3)]/maxi(paltreq2));
set(y,'Color',[1 1 1]);
plot3(3*TTi(1,1)/maxi(paltreq2),3*TTi(1,2)/maxi(paltreq2),3*TTi(1,3)/maxi(paltreq2),'wo');
hold off
rotate3d
