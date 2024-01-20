function [x, flag, relres, iter, resvec, errvec] = pcg_myid(A, b, tol, maxit,M1,M2,x0, xsol, varargin)
    if nargin < 2
        error('Not enough input arguments.');
    end


    % Default values for optional arguments
    if nargin < 3 || isempty(tol)
        tol = 1e-6; 
    end
    if nargin < 4 || isempty(maxit)
        maxit = min(size(A,1), 20); 
    end
    if nargin < 5
        M1 = []; 
    end
    if nargin < 6
        M2 = []; 
    end
    if nargin < 7
        x0 = zeros(size(b)); 
    end
   % u = ;
    x0 = zeros((size(b)));
    r = b - A .* x0;

    err = xsol - x0;
    errvec = norm(A .* err, 'fro');
    resvec = norm(r) / norm(b);
    x = x0;

    for iter = 1:maxit
    err = xsol - x;
    errvec(iter) = norm(A .* err, 'fro');  % Calculate Frobenius norm of A * err

    % Check for convergence
    if norm(r) <= tol * norm(b)
        flag = 0;
        break;
    end
    end


    % Final values
    relres = norm(b - A .* x) / norm(b);
    if iter == maxit, flag = 1; end
end
