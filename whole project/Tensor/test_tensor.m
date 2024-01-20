%%main file

function test_tensor
    % Initialization
    clear; 
    tol = 1e-8;
    nd = 3;
    rng(42);
    err = zeros(1, nd + 2);
    ndim = [3, 4, 2];
    Atemp = randi(5, ndim);
    Btemp = randi(4, ndim);
    X = randi([-1, 1], max(ndim), 1);
    
    % Create tensors using create_tensor
    A = create_tensor(Atemp);
    B = create_tensor(Btemp);

    try
        for k = 1:nd
            err(k) = norm(ttv_myid(A, X(1:ndim(k), 1), k) - double(ttv(A, X(1:ndim(k), 1), k)));
        end
        assert(max(err) < tol, 'ttm modal multiplication fails')
    catch ME1
        disp(ME1.message)
    end

    try
        err(nd + 1) = norm(ttt_myid(A, B) - ttt(A, B));
        assert(err(nd + 1) < tol, 'ttt outer multiplication fails')
    catch ME2
        disp(ME2.message)
    end

    try
        err(nd + 2) = abs(ttt_myid(A, B, 'all') - double(ttt(A, B, [1:nd])));
        assert(err(nd + 2) < tol, 'ttt inner product fails')
    catch ME3
        disp(ME3.message)
    end
end

function T = create_tensor(arr)
    % Create a tensor from a multidimensional array
    T = permute(arr, ndims(arr):-1:1);
end
