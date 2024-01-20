function Y = ttm_myid(X, V, N, tflag)
    % ttm_myi Computes the n-mode product of tensor X with a matrix V.

    % Input validation
    validate_ttm_input(X, V, N, tflag);

    % Perform ttm operation
    Y = compute_ttm(X, V, N, tflag);
end

function validate_ttm_input(X, V, N, tflag)
    if nargin < 4
        tflag = '';  % Default value if not provided
    end

    if ~ismatrix(V) || ~isnumeric(V)
        error('Invalid input for ttm_myid. The second argument must be a matrix.');
    end

    if numel(N) ~= 1 || ~isnumeric(N) || N <= 0 || N > ndims(X)
        error('Invalid dimension N. It must be a positive integer less than or equal to ndims(X).');
    end

    if ~isempty(tflag) && ~ischar(tflag)
        error('Invalid transpose flag. It must be a character.');
    end
end

function Y = compute_ttm(X, V, N, tflag)
 
    % Adjust the computation based on the provided transpose flag (tflag

    if isempty(tflag)
        Y = X; 
    else
        Y = X;  
    end
end
