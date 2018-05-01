function f=lator(x,vS3)

%Auxiliary function for SVF2XYZ
%

for i=1:length(vS3)
	f(i)=abs(((x-0.43)^0.51/(((x-0.43)^0.51)+31.75))-vS3(i));
end