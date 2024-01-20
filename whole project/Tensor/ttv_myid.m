function Y = ttv_myid(X, V, N)
    %  Computes the product of a multidimensional array X with a (column) vector V.
    % The integer N specifies the dimension in X along 

   
    if ~ismatrix(X) || ~isnumeric(X) || ~isvector(V) || ~isnumeric(V) || ~isscalar(N) || ~isnumeric(N) || N <= 0 || N > ndims(X) || size(V, 1) ~= size(X, N)
        error('Invalid input for ttv_myid. Check the types and dimensions of the input variables.');
    end

    % ttv operation
    Y = sum(X .* V, N);
end
