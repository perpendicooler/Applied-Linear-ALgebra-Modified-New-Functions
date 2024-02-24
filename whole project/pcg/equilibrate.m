function [P, R, C] = equilibrate(A)
%EQUILIBRATE Matrix equilibration.
%    [P,R,C] = EQUILIBRATE(A) permutes and rescales a structurally 
%    non-singular matrix A in such a way that the modified matrix 
%
%                           B = R*P*A*C
%
%    has only 1 and -1 on all its diagonal entries, and all its off-diagonal
%    entries are not greater than 1 in magnitude. Matrix A must be square and
%    structurally nonsingular.
%    The output P is a permutation matrix, and R and C are diagonal.
%    P*A is the permutation of A which maximizes the product of its 
%    diagonal values.
%
%   See also MATCHPAIRS, SPRANK.

%   Copyright 2018 The MathWorks, Inc.
%
%   Reference:
%   I.S. Duff and J. Koster. "On Algorithms For Permuting Large Entries
%   to the Diagonal of a Sparse Matrix."
%   SIAM J. Matrix Anal. & Appl., 22(4), 973-996, 2001.  

[m, n] = size(A);
if ~isfloat(A) || ~ismatrix(A) || m ~= n
    error(message('MATLAB:equilibrate:InvalidInput'));
elseif ~all(isfinite(A), 'all')
    error(message('MATLAB:equilibrate:NonFiniteInput'));
end

if issparse(A)
    logNzA = -log(abs(nonzeros(A)));
    [perm, ~, u, v] = matlab.internal.graph.perfectMatching(A, logNzA);
else
    logA = -log(abs(A));
    [perm, ~, u, v] = matlab.internal.graph.perfectMatching(logA);
end

% A perfect matching was found, therefore the matrix is
% structurally singular.
if isempty(perm) && n ~= 0
    error(message('MATLAB:equilibrate:StructSingular'));
end

if issparse(A)
    P = sparse(1:n, perm, 1, n, n);
    R = diag(sparse(exp(u(perm))));
    C = diag(sparse(exp(v)));
else
    P = zeros(n, n);
    P((1:n)'+n*perm-n) = 1;
    R = diag(exp(u(perm)));
    C = diag(exp(v));
end
