% Initialize parameters
tol = 1e-6;
maxit = 4 * n;  % Upper bound on th
num_experiments = 3;  % Number of experiments 

% Initialize result arrays
results = zeros(num_experiments, 4);  
% Experiment 1
tic;
[x1, flag1, relres1, iter1, ~, errvec1] = pcg_myid(A, b, tol, maxit, [], [], [], xsol);
time1 = toc;

% Experiment 2: 
tic;
M_ic0 = ichol(A);
[x2, flag2, relres2, iter2, ~, errvec2] = pcg_myid(A, b, tol, maxit, M_ic0, [], [], xsol);
time2 = toc;

% Experiment 3
tic;
% Define and set up your custom pre-conditioner
% M_custom 
[x3, flag3, relres3, iter3, ~, errvec3] = pcg_myid(A, b, tol, maxit, M_custom, [], [], xsol);
time3 = toc;

% Record results
results(1, :) = [relres1, errvec1(end), iter1, time1];
results(2, :) = [relres2, errvec2(end), iter2, time2];
results(3, :) = [relres3, errvec3(end), iter3, time3];

% Display results
disp('Results:');
disp('Experiment | Relative Balance | Relative Error | Iterations | Execution Time');
disp('------------------------------------------------------------------------');
for i = 1:num_experiments
    disp([i, results(i, :)]);
end
