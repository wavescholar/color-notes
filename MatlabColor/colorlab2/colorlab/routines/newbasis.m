function TT=newbasis(T,M)

% NEWBASIS represents a set of tristimulus vectors in a new basis.
% 
% NEWBASIS applies the matrix Mpp' (that relates the systems P and P')
% to the input vectors (expressed in the system P). 
% For each vector input, Tp, we will have an output, Tp', given by:
%
%                     Tp' =  Mpp' * Tp
%
% The matrix Mpp' can be computed with CHNGMTX.
% 
% SYNTAX:
% -------------------------------------------------------------------------------
% 
%  TT=newbasis(T,M);
%
%  M  = The change-of-basis matrix that relates the systems P and P' (3*3 matrix)
%  
%  T  = Input set of tristimulus vectors (color-like variable, N*3 matrix)
% 
%  TT = Output set of tristimulus vectors (color-like variable, N*3 matrix)

TT=(M*(T'))';

