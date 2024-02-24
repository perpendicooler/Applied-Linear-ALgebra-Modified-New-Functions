% Call the modified pcg function for both matrices
maxit = 4 * n;
%no presetting
[x1, flag1, relres1, iter1, resvec1, errvec1] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, [], [], x0_poisson, xsol_poisson);
[x2, flag2, relres2, iter2, resvec2, errvec2] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, [], [], x0_suiteparse, xsol_suitesparse);
% ichol presetting
[x5, flag5, relres5, iter5, resvec5, errvec5] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, ichol(A_suitesparse), [], x0_suiteparse, xsol_suitesparse);

[x3, flag3, relres3, iter3, resvec3, errvec3] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, ichol(A_poisson), [], x0_poisson, xsol_poisson);
%custom presetting
[x4, flag4, relres4, iter4, resvec4, errvec4] = pcg_myid(A_suitesparse, b_suitesparse, 1e-6, maxit, custom_preconditioner_suite_sparse(A_suitesparse), [], x0_suiteparse, xsol_suitesparse);
[x6, flag6, relres6, iter6, resvec6, errvec6] = pcg_myid(A_poisson, b_poisson, 1e-6, maxit, custom_preconditioner(A_poisson), [], x0_poisson, xsol_poisson);

% Plot figures

figure;
sgtitle( 'No presetting' )

subplot(2, 2, 1);
semilogy(1:iter1, resvec1(1:iter1), '-o');
title('Matrix-poisson Residuals');
xlabel('Iteration');
ylabel('Relative Residual');

subplot(2, 2, 2);
semilogy(1:iter1, errvec1(1:min(iter1, length(errvec1))), '-o');
title('Matrix-poisson A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

subplot(2, 2, 3);
semilogy(1:iter2, resvec2(1:iter2), '-o');
title('Matrix-suitesparse Residuals');
xlabel('Iteration');
ylabel('Relative Residual');

subplot(2, 2, 4);
semilogy(1:iter2, errvec2(1:min(iter2, length(errvec2))), '-o');
title('Matrix-suitesparse A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

% ichol preconditioning
figure;
sgtitle( 'Precondtioned ichol' )

subplot(2, 2, 1);
semilogy(1:iter3, resvec3(1:iter3), '-o');
title('Matrix-poisson ichol Residuals');
xlabel('Iteration');
ylabel('Relative Residual');

subplot(2, 2, 2);
semilogy(1:iter3, errvec3(1:min(iter3, length(errvec3))), '-o');
title('Matrix-poisson ichol A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

subplot(2, 2, 3);
semilogy(1:iter5, resvec5(1:iter5), '-o');
title('Matrix-suitesparse ichol Residuals');
xlabel('Iteration');
ylabel('Relative Residual');
subplot(2, 2, 4);
semilogy(1:iter5, errvec5(1:min(iter5, length(errvec5))), '-o');
title('Matrix-suitesparse ichol A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

% for custom preconditioning
figure;
sgtitle( 'custom Precondtioned' )
subplot(2, 2, 1);
semilogy(1:iter4, resvec4(1:iter4), '-o');
title('Matrix-suitesparse Custom Residuals');
xlabel('Iteration');
ylabel('Relative Residual');

subplot(2, 2, 2);
semilogy(1:iter4, errvec4(1:min(iter4, length(errvec4))), '-o');
title('Matrix-suitesparse Custom A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

subplot(2, 2, 3);
semilogy(1:iter6, resvec6(1:iter6), '-o');
title('Matrix-poisson Custom Residuals');
xlabel('Iteration');
ylabel('Relative Residual');

subplot(2, 2, 4);
semilogy(1:iter6, errvec6(1:min(iter6, length(errvec6))), '-o');
title('Matrix-poisson Custom A-norm Error');
xlabel('Iteration');
ylabel('A-norm Error');

