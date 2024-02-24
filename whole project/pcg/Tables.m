% Initialize variables for timing
tic1 = tic;
[x1, flag1, relres1, iter1, resvec1, errvec1] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, [], [], x0_poisson, xsol_poisson);
toc1 = toc(tic1);

tic2 = tic;
[x2, flag2, relres2, iter2, resvec2, errvec2] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, [], [], x0_suiteparse, xsol_suitesparse);
toc2 = toc(tic2);

tic3 = tic;
[x3, flag3, relres3, iter3, resvec3, errvec3] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, ichol(A_poisson), [], x0_poisson, xsol_poisson);
toc3 = toc(tic3);

tic4 = tic;
[x4, flag4, relres4, iter4, resvec4, errvec4] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, custom_preconditioner_suite_sparse(A_suitesparse), [], x0_suiteparse, xsol_suitesparse);
toc4 = toc(tic4);

tic5 = tic;
[x5, flag5, relres5, iter5, resvec5, errvec5] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, ichol(A_suitesparse), [], x0_suiteparse, xsol_suitesparse);
toc5 = toc(tic5);

tic6 = tic;
[x6, flag6, relres6, iter6, resvec6, errvec6] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, custom_preconditioner(A_poisson), [], x0_poisson, xsol_poisson);
toc6 = toc(tic6);

% Create cell array for each iteration
% Create cell array for each iteration
table_data = {relres1(end), errvec1(end), iter1, mean(resvec1), mean(errvec1), toc1;...
              relres2(end), errvec2(end), iter2, mean(resvec2), mean(errvec2), toc2;...
              relres3(end), errvec3(end), iter3, mean(resvec3), mean(errvec3), toc3;...
              relres4(end), errvec4(end), iter4, mean(resvec4), mean(errvec4), toc4;...
              relres5(end), errvec5(end), iter5, mean(resvec5), mean(errvec5), toc5;...
              relres6(end), errvec6(end), iter6, mean(resvec6), mean(errvec6), toc6};
table_headers = {'Final RelRes', 'Final Err', 'Iterations', 'Mean Residual', 'Mean Error', 'Execution Time (s)'};

% Create custom row names
row_names = {'No Presetting - Poisson Matrix', 'No Presetting - SuiteSparse Matrix', 'ichol Presetting - Poisson Matrix', ...
             'Custom Presetting - SuiteSparse Matrix', 'ichol Presetting - SuiteSparse Matrix', 'Custom Presetting - Poisson Matrix'};

table_figure = figure;
uitable(table_figure, 'Data', table_data, 'ColumnName', table_headers, 'RowName', row_names, 'ColumnFormat', {'char'}, 'Position', [20 20 600 150]);

% Display tables
disp('Experiment Results:');
disp(cell2table(table_data, 'VariableNames', table_headers, 'RowNames', row_names));
