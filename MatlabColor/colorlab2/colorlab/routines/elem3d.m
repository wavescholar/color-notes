function [r,c] = elem3d(siz,i,j,k)
%ELEM3D	Element positions of 3-D matrix packed in a 2-D matrix.
%	E = ELEM3D([M N P],I,J,K) returns the element position E
%	of the (i,j,k) elements of a M-by-N-by-P matrix which is
%	stored in a (M*N)-by-P matrix (see NDX3D).  E is size(I).
%
%	[R,C] = ELEM3D([M N P],I,J,K) returns row and column
%	indices as required by SPARSE.
%
%	See also NDX3D, MESHGRID, SLICE, SPARSE.

%	Clay M. Thompson 11-3-92
%	Copyright (c) 1992 by The MathWorks, Inc.
%	$Revision: 1.8 $  $Date: 1993/09/03 14:39:01 $

if isstr(i), i = 1:siz(1); end
if isstr(j), j = 1:siz(2); end
if isstr(k), k = 1:siz(3); end

if isempty(i) | isempty(j) | isempty(k), r = []; c = []; return, end

if nargout==2
  r = i + (j-1)*siz(1);
  c = k;

else
  r = i + (j-1)*siz(1) + (k-1)*prod(siz(1:2));

end



