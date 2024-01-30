% Load the SuiteSparse matrix
load('1138_bus.mat');

% Export the sparse matrix to a .mtx file
mmwrite('matrix_file.mtx', Problem.A);
