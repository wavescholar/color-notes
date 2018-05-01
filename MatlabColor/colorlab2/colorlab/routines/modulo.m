function y=modulo(x,a,b);


% MODULO devuelve la siguiente funcion:
%
%
%                                y = f(x,a,b)
% 
%                                |
%                                |
%                                |
%                                |
%                                |b
%       - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%               /|          /|   |      /|          /|          /|         
%              / |         / |   |     / |         / |         / |       
%             /  |        /  |   |    /  |        /  |        /  |     
%            /   |       /   |   |   /   |       /   |       /   |   
%           /    |      /    |   |  /    |      /    |      /    | 
%          /     |     /     |   | /     |     /     |     /     |  
%         /      |    /      |a  |/      |b   /      |    /      |    
%       -/-------|---/-------|---/-------|---/-------|---/-------|------------> x        
%       /        |  /        |  /|       |  /        |  /        |  /    
%                | /         | / |a      | /         | /         | /  
%       - - - - -|/- - - - - |/ -|- - - -|/- - - - - |/- - - - - |/- - - 
%                                | 
%                                |       
%                                |
%                                |
%                                |
%                                |     
%
%
% que es util cuando queremos confinar cualquier valor entre dos limites
% (como por ejemplo lo que ocurre con la frecuencia aparente en las DFTs)
%
%
% USO: y=modulo(x,a,b);
%
%

vv=x-a;
m=b-a;
v=vv-m/2;
k=floor(2*abs(v/m));
y=m*sign(v/m).*(abs(v/m)-(k+(1-(-1).^k)/2)/2)+m/2+a;
