% Initialize parameters
maxit = 50;
tol=1e-6;
iterations = maxit;  % Number of iterations for plotting
x0_poisson = zeros(size(A_poisson, 1), 1);  % Initial guess

% Initialize figure
figure;

%No presetting
[~, ~, ~, ~, ~, errvec1] = pcg_myid(A_poisson, b_poisson, tol, iterations,[],[], x0_poisson, xsol_poisson);
%subplot(2, 2, 1);
plot(1:length(errvec1), errvec1, '-o');
title('No Presetting');
xlabel('Iteration');
ylabel('A-norm Error');
legend();
grid on;
figure;
%Presetting with incomplete Cholesky (IC(0))
L_poisson = ichol(A_poisson, struct('michol', 'on'));
[~, ~, ~, ~, ~, errvec2] = pcg_myid(A_poisson, b_poisson, tol, iterations, L_poisson, [], x0_poisson, xsol_poisson);
%subplot(2, 2, 2);
plot(1:length(errvec2), errvec2, '*');
title('Presetting with IC(0)');
xlabel('Iteration');
ylabel('A-norm Error');
legend();
grid on;
figure;
% Custom pre-conditioner 
M_custom = ichol(A_poisson);  
[~, ~, ~, ~, ~, errvec3] = pcg_myid(A_poisson , b_poisson, tol, iterations, M_custom, [], x0_poisson, xsol_poisson);
%subplot(2, 2, 3);
plot(1:length(errvec3), errvec3, '--');
title('Custom Pre-Conditioner');
xlabel('Iteration');
ylabel('A-norm Error');
legend();
grid on;
figure;
% No presetting for SuiteSparse matrix
x0_suitesparse = zeros(size(A_suitesparse, 1), 1);

[~, ~, ~, ~, ~, errvec_suitesparse] = pcg_myid(A_suitesparse, b_suitesparse, tol, iterations, [], [], x0, xsol_suitesparse);

%subplot(2, 2, 4);

plot(1:length(errvec_suitesparse), errvec_suitesparse, '-*');
title('No Presetting (SuiteSparse)');
xlabel('Iteration');
ylabel('A-norm Error');
legend();
grid on;

