function f=acop(x,v1Y)

%Auxiliary function for SVF2XYZ

for i=1:length(v1Y)
	f(i)=abs((((x-0.43).^0.51)./(((x-0.43).^0.51)+31.75))-v1Y(i));
end


