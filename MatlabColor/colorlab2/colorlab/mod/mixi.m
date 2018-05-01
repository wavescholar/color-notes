function f=mixi(x,v1S1)

%Auxiliary function for SVF2XYZ

for i=1:length(v1S1)
	f(i)=abs((((x-0.43).^0.51)./(((x-0.43).^0.51)+31.75))-v1S1(i));
end