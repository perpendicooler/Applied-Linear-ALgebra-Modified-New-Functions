function A = loadSuiteSparseMatrix()
% Load the SuiteSparse matrix
A = load('matlab.mat','Problem');
A = A.Problem.A;

% Get the size of the matrix
n = size(A, 1);

% Generate the right-hand side vector
b = A*ones(n, 1);
end
