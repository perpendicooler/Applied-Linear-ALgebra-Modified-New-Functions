clc
clear all
% Generate matrices

n=30;
tol = 1e-6;
A_poisson = generatePoissonMatrix(n);
A_suitesparse = loadSuiteSparseMatrix();
x0_poisson = (zeros(size(A_poisson, 1), 1));
x0_suiteparse = (zeros(size(A_suitesparse,1),1));
% Define right sides
b_poisson = (A_poisson * ones(size(A_poisson, 1), 1));
b_suitesparse =(( A_suitesparse * ones(size(A_suitesparse, 1), 1)));


% Known exact solutions (for testing)
xsol_poisson = exactSolutionPoisson(n);  % exact solution

xsol_suitesparse =ones(size(A_suitesparse, 1), 1);% Define or calculate exact solution for SuiteSparse problem
