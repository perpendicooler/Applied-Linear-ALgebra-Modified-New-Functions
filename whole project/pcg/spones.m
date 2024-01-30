function R = spones(S)
%SPONES Replace nonzero sparse matrix elements with ones.
%   R = SPONES(S) generates a matrix with the same sparsity
%   structure as S, but with ones in the nonzero positions.
%
%   See also SPFUN, SPALLOC, NNZ.

%   Copyright 1984-2018 The MathWorks, Inc. 

if ~ismatrix(S)
    error(message('MATLAB:spones:ndInput'));
end
if issparse(S)
    R = double(S~=0);
else
    [i,j] = find(S);
    [m,n] = size(S);
    R = sparse(i,j,1,m,n);
end
