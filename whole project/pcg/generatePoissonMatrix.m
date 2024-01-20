function A = generatePoissonMatrix(n)
    % Discretize 
    h = 1 / (n + 1); % Step size
    N = n^2; % Total number 

    % Create the Laplacian matrix 
    e = ones(N, 1);
    A = spdiags([-e, -e, 4*e, -e, -e], [-n, -1, 0, 1, n], N, N);

    % boundary conditions
    for i = 1:n-1
        A(i*n, i*n + 1) = 0;
        A(i*n + 1, i*n) = 0;
    end
end
