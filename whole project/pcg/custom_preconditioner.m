function M = custom_preconditioner(A)
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
