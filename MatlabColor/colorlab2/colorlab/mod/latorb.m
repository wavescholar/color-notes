function f=latorb(x,v2S3,KVY)

%Auxiliary function for SVF2XYZ

for i=1:length(v2S3)
	f(i)=abs((((x./KVY(i))-0.1).^0.86)./((((x./KVY(i))-0.1).^0.86)+103.2)-v2S3(i));
end