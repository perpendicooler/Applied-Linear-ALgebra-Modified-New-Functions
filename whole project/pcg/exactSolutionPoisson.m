function u = exactSolutionPoisson(n)
% Calculate the exact solution of the Poisson equation for the given number of internal nodes, n

% Calculate the total number of nodes
m = n ;
total_nodes = m *n ;

% Calculate the step size
h = 1 / (n + 1);

% Initialize the exact solution vector
u = zeros(total_nodes, 1);

% Calculate the exact solution at each node
for i = 1:total_nodes
    % Convert the node index to (x, y) coordinates
    x = mod(i - 1, n) / n;
    y = floor((i - 1) / n) / (m - 1);

    % Calculate the exact solution at the current node
    u(i) = x^2 + sin(pi * x) + y^3 * (1 - y) + x * y / 8;
end

end
