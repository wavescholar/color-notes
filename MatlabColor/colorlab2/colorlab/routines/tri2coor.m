function t=tri2coor(T,yw)

% TRI2COOR compute chromatic coordinates and luminance from tristimulus values
% 
% SYNTAX
% ----------------------------------------------------------------------------
% 
% t=tri2coor(T,Yw);
% 
% T  = Input tristimulus vectors (color-like variable, colors in rows).
% 
% Yw = Trichromatic units [Yw(P1) Yw(P2) Yw(P3)]
%
% t  = Output chromatic coordinates and luminance  (color-like variable, [t1 t2 Y]).
%

l=size(T);
l=l(1);

for i=1:l
    TT=T(i,:);
    if sum(TT)~=0
       tt=TT./sum(TT);
    else
       tt=TT./0.00001;
    end
    Y=TT*yw'; 
    t(i,:)=[tt(1:2) Y];
end