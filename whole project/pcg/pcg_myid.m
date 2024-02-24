function [x, flag, relres, iter, resvec, errvec] = pcg_myid(A, b, tol, maxit, M1, M2, x0, xsol, varargin)
    % Call the original pcg function
    [x, flag, relres, iter, resvec] = pcg(A, b, tol, maxit, M1, M2, x0, varargin{:});

    % Check if xsol and x have the same dimensions
    if numel(xsol) ~= numel(x)
        error('The dimensions of xsol and x must agree.');
    end

    % Calculate the A-norm error2
    errvec = norm(xsol - x);
end
