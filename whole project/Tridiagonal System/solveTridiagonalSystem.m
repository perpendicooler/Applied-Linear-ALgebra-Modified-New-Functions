%%the start form here
function x = solveTridiagonalSystem(a, b, c, d)
    % tridiagonal system of linear equations using the Thomas algorithm
    
    % input sizes
    n = length(b);
    assert(length(a) == n && length(c) == n && length(d) == n, 'Input sizes mismatch');

    % Initial sol
    alpha = b;
    s = d;

    % Forward elimination
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
end
% Example usage
%a = [1; 1; 1];   % Diagonal coefficients
%b = [2; 2; 2];   % Upper diagonal coefficients
%c = [3; 3; 3];   % Lower diagonal coefficients
%d = [4; 4; 4];   % Right-hand side coefficients
