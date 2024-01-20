% Generate matrices
tol = 1e-6;
A_poisson = generatePoissonMatrix(30);
A_suitesparse = loadSuiteSparseMatrix();

% Define right sides
b_poisson = A_poisson * ones(size(A_poisson, 1), 1);
b_suitesparse =( A_suitesparse .* ones(size(A_suitesparse, 1), 1));


% Known exact solutions (for testing)
xsol_poisson = zeros(size(b_poisson));% Define or calculate exact solution for Poisson problem
xsol_suitesparse =ones(size(A_suitesparse, 1), 1);% Define or calculate exact solution for SuiteSparse problem

% Run pcg_myid and measure performance
tic;
[x_poisson, flag_p, relres_p, iter_p, resvec_p, errvec_p] = pcg_myid(A_poisson, b_poisson, 1e-6, 120,[],[],[], xsol_poisson);
time_poisson = toc;

tic;
[x_suitesparse, flag_s, relres_s, iter_s, resvec_s, errvec_s] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, 4532,[],[],[], xsol_suitesparse);
time_suitesparse = toc;

% Initialize parameters
maxit =50;
iterations = maxit;  % Number of iterations for plotting
x0 = zeros(size(A_poisson, 1), 1);  % Initial guess




