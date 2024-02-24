function solveTridiagonalSystem(a, b, c, d)
    % Number of equations
    n = length(d);

    % Initializing solution vectors
    alpha = zeros(n, 1);
    s = zeros(n, 1);
    x = zeros(n, 1);

    % Calculating values of alpha and s
    alpha(1) = b(1);
    s(1) = d(1);

    for i = 2:n
        m = a(i) / alpha(i - 1);
        alpha(i) = b(i) - (c(i - 1) * m);
        s(i) = d(i) - (s(i - 1) * m);
    end

    % Back-substitution to find the solution
    x(n) = s(n) / alpha(n);
    for i = n - 1:-1:1
        x(i) = (s(i) - (c(i) * x(i + 1))) / alpha(i);
    end

    % Printing solution
    disp('The solution for the tridiagonal system:');
    for i = 1:n
        fprintf('x(%d): %f\n', i, x(i));
    end

    % Calculate norms directly from the coefficients
    super_diagonal_norm = norm(b, inf);
    sub_diagonal_norm = norm(c, inf);

    % Displaying results
    fprintf('Super-diagonal norm: %f\n', super_diagonal_norm);
    fprintf('Sub-diagonal norm: %f\n', sub_diagonal_norm);
end
%a = [1; 1; 1];
%b = [2; 2; 2];
%c = [3; 3; 3];
%d = [4; 4; 4];

%solveTridiagonalSystem(a, b, c, d);
