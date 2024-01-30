% Custom preconditioner for SuiteSparse (replace with your own logic)
function M = custom_preconditioner_suite_sparse(A)
    % Example: Using SuiteSparse preconditioner (e.g., ilutp)
    opts.type = 'ilutp';  % ILU with threshold pivoting
    opts.droptol = 1e-6;   % Drop tolerance
    
    try
        % Attempt ILU factorization
        [L, U] = ilu(A, opts);

        % Combine ILU factors into a preconditioner matrix M
        M = U \ (L \ eye(size(A)));
    catch
        % If ILU fails, use a simple Jacobi preconditioner as a fallback
        D = diag(A);
        M = spdiags(1./D, 0, length(D), length(D));
    end
end

% Custom preconditioner for ichol pre-setting (replace with your own logic)
function M = custom_preconditioner_ichol(A)
    % Example: Using ichol preconditioner with threshold
    opts.type = 'ict';   % Incomplete Cholesky with threshold
    opts.droptol = 1e-6;  % Drop tolerance
    
    try
        % Attempt ichol factorization
        L = ichol(A, opts);

        % Combine ichol factors into a preconditioner matrix M
        M = L \ eye(size(A));
    catch
        % If ichol fails, use a simple Jacobi preconditioner as a fallback
        D = diag(A);
        M = spdiags(1./D, 0, length(D), length(D));
    end
end
