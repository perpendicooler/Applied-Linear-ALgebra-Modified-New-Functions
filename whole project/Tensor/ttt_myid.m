function C = ttt_myid(A, B, varargin)
    % ttt_myid: Computes the outer or inner product of two multidimensional arrays A and B.

    if nargin < 2 || nargin > 3
        error('Invalid number of input arguments. Usage: C = ttt_myid(A, B) or t = ttt_myid(A, B, ''all'').');
    end

    if isempty(A) || isempty(B) || ~isnumeric(A) || ~isnumeric(B)
        error('Input tensors A and B must be non-empty numeric arrays.');
    end

    if nargin == 3 && ~strcmpi(varargin{1}, 'all')
        error('Invalid third argument. Use ''all'' for inner product or omit for outer product.');
    end

    if nargin == 2
        % Outer product
        C = outer_product(A, B);
    else
        % Inner product
        validate_inner_product_input(A, B);
        C = inner_product(A, B);
    end
end

function C = outer_product(A, B)
    sizeA = size(A);
    sizeB = size(B);

    C = reshape(A, [sizeA, 1]) .* reshape(B, [1, sizeB]);
end

function validate_inner_product_input(A, B)
    sizeA = size(A);
    sizeB = size(B);

    if ~isequal(sizeA, sizeB)
        error('Inner product requires tensors A and B to have the same dimensions.');
    end
end

function t = inner_product(A, B)
    t = sum(A(:) .* B(:));
end
